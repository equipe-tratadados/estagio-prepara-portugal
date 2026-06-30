#!/bin/bash
# .hooks/modules/file-manager.sh
# Gerenciamento de arquivos

source "$(dirname "${BASH_SOURCE[0]}")/config.sh"
source "$(dirname "${BASH_SOURCE[0]}")/ui.sh"

# ============================================
# VARIÁVEIS GLOBAIS
# ============================================

declare -ga ARQUIVOS_NOMES=()
declare -ga ARQUIVOS_TAMANHOS=()
declare -ga ARQUIVOS_STATUS=()
declare -ga ARQUIVOS_SELECIONADOS=()

# ============================================
# ANÁLISE DE ARQUIVOS
# ============================================

analisar_arquivos() {
    local arquivos_modificados=$(git diff --cached --name-only)
    
    if [ -z "$arquivos_modificados" ]; then
        error "Nenhum arquivo modificado encontrado."
        info "Use 'git add' primeiro para selecionar os arquivos."
        exit 1
    fi
    
    ARQUIVOS_NOMES=()
    ARQUIVOS_TAMANHOS=()
    ARQUIVOS_STATUS=()
    
    local total_arquivos=0
    local total_tamanho=0
    local arquivos_grandes=0
    local arquivos_muito_grandes=0
    local csv_count=0
    local csv_tamanho_total=0
    
    while IFS= read -r arquivo; do
        if [ -z "$arquivo" ]; then continue; fi
        
        if [ ! -f "$arquivo" ]; then
            continue
        fi
        
        # Detecta OS e usa comando apropriado para obter tamanho
        local tamanho=0
        if [[ "$OSTYPE" == "darwin"* ]]; then
            # macOS
            tamanho=$(stat -f%z "$arquivo" 2>/dev/null || echo "0")
        elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" || "$OSTYPE" == "win32" ]]; then
            # Windows (Git Bash/MSYS/Cygwin)
            tamanho=$(stat -c%s "$arquivo" 2>/dev/null || echo "0")
        else
            # Linux e outros
            tamanho=$(stat -c%s "$arquivo" 2>/dev/null || echo "0")
        fi
        tamanho=${tamanho:-0}
        
        local status="NORMAL"
        
        if [ $tamanho -gt $((LIMITE_BLOQUEIO_MB * 1048576)) ]; then
            status="BLOQUEADO"
            arquivos_muito_grandes=$((arquivos_muito_grandes + 1))
        elif [ $tamanho -gt $((LIMITE_AVISO_MB * 1048576)) ]; then
            status="GRANDE"
            arquivos_grandes=$((arquivos_grandes + 1))
        fi
        
        if echo "$arquivo" | grep -qiE "\.($EXTENSOES_DADOS)$"; then
            csv_count=$((csv_count + 1))
            csv_tamanho_total=$((csv_tamanho_total + tamanho))
        fi
        
        ARQUIVOS_NOMES+=("$arquivo")
        ARQUIVOS_TAMANHOS+=("$tamanho")
        ARQUIVOS_STATUS+=("$status")
        
        total_arquivos=$((total_arquivos + 1))
        total_tamanho=$((total_tamanho + tamanho))
    done <<< "$arquivos_modificados"
    
    export ARQUIVOS_NOMES ARQUIVOS_TAMANHOS ARQUIVOS_STATUS
    export TOTAL_ARQUIVOS=$total_arquivos
    export TOTAL_TAMANHO=$total_tamanho
    export ARQUIVOS_GRANDES=$arquivos_grandes
    export ARQUIVOS_MUITO_GRANDES=$arquivos_muito_grandes
    export CSV_COUNT=$csv_count
    export CSV_TAMANHO_TOTAL=$csv_tamanho_total
}

exibir_resumo_analise() {
    titulo "📂 ANÁLISE DE ARQUIVOS MODIFICADOS"
    
    info "Verificando arquivos que você está prestes a commitar..."
    echo ""
    
    destaque "📋 Arquivos detectados:"
    echo ""
    
    for i in "${!ARQUIVOS_NOMES[@]}"; do
        formatar_arquivo "${ARQUIVOS_NOMES[$i]}" "${ARQUIVOS_TAMANHOS[$i]}" "${ARQUIVOS_STATUS[$i]}"
    done
    
    echo ""
    linha
    destaque "📊 RESUMO:"
    echo -e "  📦 Total de arquivos: ${BOLD}${TOTAL_ARQUIVOS}${NC}"
    echo -e "  💾 Tamanho total: ${BOLD}$(human_readable $TOTAL_TAMANHO)${NC}"
    echo -e "  📊 Arquivos de dados: ${BOLD}${CSV_COUNT}${NC} (${BOLD}$(human_readable $CSV_TAMANHO_TOTAL)${NC})"
    
    if [ $ARQUIVOS_GRANDES -gt 0 ]; then
        echo -e "  ${YELLOW}⚠️  Arquivos grandes (>${LIMITE_AVISO_MB}MB): ${BOLD}${ARQUIVOS_GRANDES}${NC}"
    fi
    if [ $ARQUIVOS_MUITO_GRANDES -gt 0 ]; then
        echo -e "  ${RED}❌ Arquivos bloqueados (>${LIMITE_BLOQUEIO_MB}MB): ${BOLD}${ARQUIVOS_MUITO_GRANDES}${NC}"
    fi
    linha
    echo ""
}

verificar_bloqueados() {
    if [ $ARQUIVOS_MUITO_GRANDES -gt 0 ]; then
        error "Arquivos muito grandes detectados!"
        echo ""
        warning "O que fazer:"
        echo "  1. Use Git LFS para arquivos grandes:"
        echo -e "     ${CYAN}git lfs track \"*.csv\" \"*.parquet\" \"*.pkl\"${NC}"
        echo "  2. Adicione ao .gitignore:"
        echo -e "     ${CYAN}echo \"data/*.csv\" >> .gitignore${NC}"
        echo "  3. Divida arquivos muito grandes:"
        echo -e "     ${CYAN}split -l 1000000 arquivo.csv parte_${NC}"
        echo "  4. Use --force com cuidado (NÃO RECOMENDADO):"
        echo -e "     ${RED}git commit --force${NC}"
        echo ""
        error "Commit cancelado para evitar problemas."
        exit 1
    fi
}

selecionar_arquivos() {
    if [ ${#ARQUIVOS_NOMES[@]} -eq 1 ]; then
        ARQUIVOS_SELECIONADOS=("${ARQUIVOS_NOMES[0]}")
        export ARQUIVOS_SELECIONADOS
        return 0
    fi
    
    titulo "✅ SELEÇÃO DE ARQUIVOS PARA COMMIT"
    
    info "Você pode escolher quais arquivos commitar:"
    echo "  Digite 't' para todos, 'n' para nenhum, ou números separados por vírgula"
    echo ""
    
    for i in "${!ARQUIVOS_NOMES[@]}"; do
        formatar_arquivo "${ARQUIVOS_NOMES[$i]}" "${ARQUIVOS_TAMANHOS[$i]}" "${ARQUIVOS_STATUS[$i]}"
    done
    
    echo ""
    read -p "Seleção: " selecao
    
    if [ "$selecao" = "t" ] || [ "$selecao" = "T" ]; then
        ARQUIVOS_SELECIONADOS=("${ARQUIVOS_NOMES[@]}")
        success "Todos os arquivos selecionados."
    elif [ "$selecao" = "n" ] || [ "$selecao" = "N" ]; then
        error "Nenhum arquivo selecionado. Commit cancelado."
        exit 1
    else
        IFS=',' read -ra numeros <<< "$selecao"
        for num in "${numeros[@]}"; do
            num=$(echo "$num" | xargs)
            if [[ "$num" =~ ^[0-9]+$ ]] && [ "$num" -ge 1 ] && [ "$num" -le ${#ARQUIVOS_NOMES[@]} ]; then
                idx=$((num - 1))
                ARQUIVOS_SELECIONADOS+=("${ARQUIVOS_NOMES[$idx]}")
            else
                warning "Número inválido: $num"
            fi
        done
        
        if [ ${#ARQUIVOS_SELECIONADOS[@]} -eq 0 ]; then
            error "Nenhum arquivo válido selecionado. Commit cancelado."
            exit 1
        fi
        
        success "${#ARQUIVOS_SELECIONADOS[@]} arquivo(s) selecionado(s)."
    fi
    
    export ARQUIVOS_SELECIONADOS
    
    echo ""
    destaque "📋 Arquivos a serem commitados:"
    for arquivo in "${ARQUIVOS_SELECIONADOS[@]}"; do
        echo -e "  ${GREEN}✓${NC} $arquivo"
    done
    pause
}

atualizar_stage() {
    info "Atualizando stage com os arquivos selecionados..."
    
    git reset HEAD -- . 2>/dev/null
    
    for arquivo in "${ARQUIVOS_SELECIONADOS[@]}"; do
        git add "$arquivo"
        success "Adicionado: $arquivo"
    done
    
    success "Stage atualizado!"
    pause
}

export -f analisar_arquivos exibir_resumo_analise
export -f verificar_bloqueados selecionar_arquivos atualizar_stage