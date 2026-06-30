#!/bin/bash
# .hooks/modules/tech-validator.sh
# Validações técnicas de arquivos CSV e Markdown

source "$(dirname "${BASH_SOURCE[0]}")/ui.sh"

# ============================================
# VARIÁVEIS GLOBAIS
# ============================================

export ERROS_VALIDACAO_TECNICA=0

# ============================================
# FUNÇÕES DE VALIDAÇÃO
# ============================================

validar_csv() {
    local arquivo="$1"
    local nome_arquivo=$(basename "$arquivo")
    local erros_encontrados=0

    info "Iniciando validação CSV para: ${BOLD}$nome_arquivo${NC}"

    # 1. Verificar separador (ponto e vírgula)
    if ! head -n 1 "$arquivo" | grep -q ';'; then
        error "❌ CSV: Separador inválido. Esperado ponto e vírgula (;) em '$nome_arquivo'."
        erros_encontrados=$((erros_encontrados + 1))
    fi

    # 2. Verificar encoding UTF-8
    local encoding=$(file -bi "$arquivo" | sed -e 's/.*charset=//g')
        if [[ "$encoding" != "utf-8" && "$encoding" != "us-ascii" ]]; then
        error "❌ CSV: Encoding inválido. Esperado UTF-8, encontrado '$encoding' em '$nome_arquivo'."
        erros_encontrados=$((erros_encontrados + 1))
    fi

    # Ler o cabeçalho para as próximas validações
    local header=$(head -n 1 "$arquivo")

    # 3. Verificar acentos ou caracteres especiais no cabeçalho
                    if echo "$header" | grep -qE '[^[:alnum:]_\.;-]'; then
        error "❌ CSV: Cabeçalho contém acentos ou caracteres especiais em '$nome_arquivo'. Esperado apenas caracteres ASCII básicos."
        erros_encontrados=$((erros_encontrados + 1))
    fi

    # 4. Alertar se houver letras maiúsculas nos nomes das colunas (snake_case esperado)
    if echo "$header" | grep -qE '[A-Z]'; then
        warning "⚠️ CSV: Cabeçalho contém letras maiúsculas em '$nome_arquivo'. Esperado snake_case (apenas minúsculas e underscores)."
        # Não incrementa erros_encontrados pois é apenas um alerta, não um erro bloqueante
    fi

    if [ $erros_encontrados -eq 0 ]; then
        success "✅ CSV: Validação de $nome_arquivo concluída sem erros críticos."
    else
        error "❌ CSV: '$nome_arquivo' possui $erros_encontrados erro(s) crítico(s)."
        ERROS_VALIDACAO_TECNICA=$((ERROS_VALIDACAO_TECNICA + erros_encontrados))
    fi
    echo ""
    return $erros_encontrados
}

validar_md() {
    local arquivo="$1"
    local nome_arquivo=$(basename "$arquivo")
    local erros_encontrados=0

    info "Iniciando validação Markdown para: ${BOLD}$nome_arquivo${NC}"

    # 1. Verificar títulos sem espaço após o #
    if grep -qE '^#+[^ ]' "$arquivo"; then
        error "❌ MD: Título sem espaço após '#' encontrado em '$nome_arquivo'. Ex: '#Título' em vez de '# Título'."
        erros_encontrados=$((erros_encontrados + 1))
    fi

    # 2. Verificar se tabelas possuem a linha de separação obrigatória |---|
    # Esta validação é um pouco mais complexa, vamos verificar se existe uma linha que parece uma tabela
    # e se a linha de separação (---) está presente logo abaixo.
    # Simplificando: verificar se existe '|' e não existe '|---' na linha seguinte
    local linhas=$(cat "$arquivo")
    local IFS=$'\n'
    local linha_anterior=""
    for linha in $linhas; do
        if [[ "$linha_anterior" =~ ^\|.*\|$ ]] && [[ ! "$linha" =~ ^\|\-*\|.*\|$ ]]; then
            error "❌ MD: Tabela sem linha de separação '|---|' encontrada após cabeçalho em '$nome_arquivo'."
            erros_encontrados=$((erros_encontrados + 1))
            break # Apenas um erro por arquivo para este tipo de validação
        fi
        linha_anterior="$linha"
    done

    if [ $erros_encontrados -eq 0 ]; then
        success "✅ MD: Validação de '$nome_arquivo' concluída sem erros críticos."
    else
        error "❌ MD: '$nome_arquivo' possui $erros_encontrados erro(s) crítico(s)."
        ERROS_VALIDACAO_TECNICA=$((ERROS_VALIDACAO_TECNICA + erros_encontrados))
    fi
    echo ""
    return $erros_encontrados
}

executar_validacoes_tecnicas() {
    titulo "⚙️ EXECUTANDO VALIDAÇÕES TÉCNICAS"
    info "Verificando arquivos em stage para conformidade com as diretrizes da equipe."
    echo ""

    local staged_files=$(git diff --cached --name-only)
    local total_erros=0

    if [ -z "$staged_files" ]; then
        info "Nenhum arquivo em stage para validar."
        return 0
    fi

    for arquivo in $staged_files; do
        if [[ "$arquivo" =~ \.csv$ ]]; then
            validar_csv "$arquivo"
            total_erros=$((total_erros + $?))
        elif [[ "$arquivo" =~ \.md$ ]] && ! [[ "$arquivo" =~ ^\.hooks/.*$ || "$arquivo" =~ ^\.github/.*$ ]]; then
            validar_md "$arquivo"
            total_erros=$((total_erros + $?))
        fi
    done

    if [ $total_erros -gt 0 ]; then
        error "Foram encontrados $total_erros erro(s) nas validações técnicas."
        echo ""
        read -p "Deseja ignorar os erros e prosseguir com o commit? (s/n): " ignorar_erros
        if [[ "$ignorar_erros" =~ ^[Ss]$ ]]; then
            warning "Validações técnicas ignoradas. Prossiga com cautela."
            return 0 # Ignora os erros e permite o commit
        else
            error "Commit cancelado devido a erros de validação técnica."
            return 1 # Cancela o commit
        fi
    else
        success "Todas as validações técnicas foram concluídas sem erros."
        return 0
    fi
}

export -f validar_csv validar_md executar_validacoes_tecnicas
