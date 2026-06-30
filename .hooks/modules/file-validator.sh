#!/bin/bash
# .hooks/modules/file-validator.sh
# Validação de arquivos de dados

source "$(dirname "${BASH_SOURCE[0]}")/config.sh"
source "$(dirname "${BASH_SOURCE[0]}")/ui.sh"

# ============================================
# VALIDAÇÃO DE ENCODING
# ============================================

validar_encoding_csv() {
    local arquivo="$1"
    
    if ! echo "$arquivo" | grep -qi "\.csv$"; then
        return 0
    fi
    
    info "🔍 Validando encoding do arquivo: $arquivo"
    
    # Detecta encoding usando file ou iconv
    local encoding=$(file -b --mime-encoding "$arquivo" 2>/dev/null || echo "unknown")
    
    case "$encoding" in
        utf-8|us-ascii)
            success "✅ Encoding OK: $encoding"
            return 0
            ;;
        iso-8859-1|latin1|windows-1252)
            warning "⚠️  Encoding $encoding detectado. Recomendado UTF-8."
            echo "  Para converter: iconv -f $encoding -t utf-8 $arquivo > ${arquivo}.utf8"
            read -p "  Converter automaticamente? (s/n): " converter
            if [ "$converter" = "s" ] || [ "$converter" = "S" ]; then
                mv "$arquivo" "${arquivo}.bak"
                iconv -f "$encoding" -t utf-8 "${arquivo}.bak" > "$arquivo"
                success "✅ Arquivo convertido para UTF-8"
            fi
            return 1
            ;;
        *)
            warning "⚠️  Encoding não identificado: $encoding"
            return 1
            ;;
    esac
}

# ============================================
# VALIDAÇÃO DE SCHEMA
# ============================================

validar_schema_csv() {
    local arquivo="$1"
    
    if ! echo "$arquivo" | grep -qi "\.csv$"; then
        return 0
    fi
    
    info "📊 Validando schema do arquivo: $arquivo"
    
    # Lê primeira linha para cabeçalhos
    local cabecalho=$(head -n 1 "$arquivo" 2>/dev/null)
    
    if [ -z "$cabecalho" ]; then
        error "❌ Arquivo vazio ou sem cabeçalho!"
        return 1
    fi
    
    # Conta colunas
    local colunas=$(echo "$cabecalho" | awk -F',' '{print NF}')
    local colunas_unicas=$(echo "$cabecalho" | tr ',' '\n' | sort -u | wc -l)
    
    echo "  📋 Colunas: $colunas"
    echo "  📋 Colunas únicas: $colunas_unicas"
    
    if [ "$colunas" -ne "$colunas_unicas" ]; then
        warning "⚠️  Nomes de colunas duplicados detectados!"
        echo "  Colunas: $cabecalho"
        return 1
    fi
    
    # Verifica se há dados
    local linhas=$(wc -l < "$arquivo" 2>/dev/null)
    linhas=$((linhas - 1))
    
    if [ "$linhas" -eq 0 ]; then
        warning "⚠️  Arquivo sem dados (apenas cabeçalho)"
        return 1
    fi
    
    success "✅ Schema válido: $colunas colunas, $linhas linhas"
    
    # Verifica limite de linhas
    if [ "$linhas" -gt "$LIMITE_CSV_LINHAS" ]; then
        warning "⚠️  Arquivo com $linhas linhas (> $LIMITE_CSV_LINHAS)"
        echo "  Considere dividir ou usar Parquet para melhor performance."
    fi
    
    return 0
}

# ============================================
# VALIDAÇÃO DE DUPLICADOS
# ============================================

validar_duplicados_csv() {
    local arquivo="$1"
    
    if ! echo "$arquivo" | grep -qi "\.csv$"; then
        return 0
    fi
    
    info "🔍 Verificando duplicados em: $arquivo"
    
    # Verifica duplicados na primeira coluna
    local duplicados=$(cut -d',' -f1 "$arquivo" | sort | uniq -d | wc -l)
    duplicados=$((duplicados - 1))
    
    if [ "$duplicados" -gt 0 ]; then
        warning "⚠️  Encontrados $duplicados valores duplicados na primeira coluna"
        echo "  Dica: Use 'sort | uniq -d' para identificar."
        return 1
    fi
    
    success "✅ Sem duplicados detectados"
    return 0
}

# ============================================
# VALIDAÇÃO DE TAMANHO
# ============================================

validar_tamanho_arquivo() {
    local arquivo="$1"
    local tamanho=$2
    
    if [ $tamanho -gt $((LIMITE_BLOQUEIO_MB * 1048576)) ]; then
        error "❌ Arquivo muito grande: $(human_readable $tamanho)"
        echo "  Use Git LFS ou divida o arquivo."
        return 1
    fi
    
    if [ $tamanho -gt $((LIMITE_AVISO_MB * 1048576)) ]; then
        warning "⚠️  Arquivo grande: $(human_readable $tamanho)"
        echo "  Considere usar Git LFS."
        return 0
    fi
    
    return 0
}

# ============================================
# VALIDAÇÃO COMPLETA
# ============================================

validar_arquivos_completo() {
    local todos_validos=true
    
    for i in "${!ARQUIVOS_SELECIONADOS[@]}"; do
        local arquivo="${ARQUIVOS_SELECIONADOS[$i]}"
        local tamanho="${ARQUIVOS_TAMANHOS[$i]}"
        
        titulo "🔍 Validando: $arquivo"
        
        # Valida tamanho
        if ! validar_tamanho_arquivo "$arquivo" "$tamanho"; then
            todos_validos=false
        fi
        
        # Valida encoding
        if [ "$VALIDAR_ENCODING" = "true" ]; then
            if ! validar_encoding_csv "$arquivo"; then
                todos_validos=false
            fi
        fi
        
        # Valida schema
        if [ "$VALIDAR_SCHEMA" = "true" ]; then
            if ! validar_schema_csv "$arquivo"; then
                todos_validos=false
            fi
        fi
        
        # Valida duplicados
        if [ "$VALIDAR_DUPLICADOS" = "true" ]; then
            if ! validar_duplicados_csv "$arquivo"; then
                todos_validos=false
            fi
        fi
        
        pause
    done
    
    if [ "$todos_validos" = false ]; then
        echo ""
        warning "⚠️  Algumas validações falharam."
        read -p "Deseja continuar mesmo assim? (s/n): " continuar
        if [ "$continuar" != "s" ] && [ "$continuar" != "S" ]; then
            error "Commit cancelado."
            exit 1
        fi
    else
        success "✅ Todas as validações passaram!"
    fi
}

export -f validar_encoding_csv validar_schema_csv
export -f validar_duplicados_csv validar_tamanho_arquivo
export -f validar_arquivos_completo