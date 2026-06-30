#!/bin/bash
# .hooks/modules/quick-mode.sh
# Modo rápido para usuários experientes

source "$(dirname "${BASH_SOURCE[0]}")/config.sh"
source "$(dirname "${BASH_SOURCE[0]}")/ui.sh"

# ============================================
# MODO RÁPIDO
# ============================================

verificar_modo_rapido() {
    if [ "$QUICK_MODE_ENABLED" != "true" ]; then
        return 1
    fi
    
    # Ativa se poucos arquivos
    if [ ${#ARQUIVOS_SELECIONADOS[@]} -le "$QUICK_MODE_THRESHOLD" ]; then
        return 0
    fi
    
    echo ""
    read -p "Deseja usar o modo rápido? (s/n): " usar_quick
    
    if [ "$usar_quick" = "s" ] || [ "$usar_quick" = "S" ]; then
        return 0
    fi
    
    return 1
}

executar_modo_rapido() {
    local msg_file="$1"
    
    titulo "⚡ MODO RÁPIDO ATIVADO"
    
    info "Você escolheu o modo rápido. Vamos direto ao ponto!"
    echo ""
    
    # Pergunta apenas o essencial
    perguntar_tipo
    
    echo ""
    echo -e "${YELLOW}📌 Resumo do commit (máx 72 caracteres):${NC}"
    read -p "> " RESUMO
    
    if [ -z "$RESUMO" ]; then
        error "Resumo obrigatório. Commit cancelado."
        exit 1
    fi
    
    # Monta mensagem direta
    local mensagem="$TIPO_COMMIT: $RESUMO"
    
    success "✅ Mensagem gerada:"
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════════${NC}"
    echo "$mensagem"
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════════${NC}"
    
    # Pergunta se quer adicionar corpo
    read -p "Adicionar corpo? (s/n): " add_corpo
    if [ "$add_corpo" = "s" ] || [ "$add_corpo" = "S" ]; then
        echo "Digite o corpo (digite FIM para finalizar):"
        local linha
        local corpo=""
        while true; do
            read -p "> " linha
            if [ "$linha" = "FIM" ] || [ "$linha" = "fim" ]; then
                break
            fi
            corpo="${corpo}${linha}\n"
        done
        mensagem="${mensagem}\n\n${corpo}"
    fi
    
    # Salva e finaliza
    echo "$mensagem" > "$msg_file"
    
    success "✅ Commit rápido finalizado!"
    exit 0
}

export -f verificar_modo_rapido executar_modo_rapido