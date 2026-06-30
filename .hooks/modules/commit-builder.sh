#!/bin/bash
# .hooks/modules/commit-builder.sh
# Geração da mensagem de commit

source "$(dirname "${BASH_SOURCE[0]}")/config.sh"
source "$(dirname "${BASH_SOURCE[0]}")/ui.sh"

# ============================================
# VARIÁVEIS GLOBAIS
# ============================================

export TIPO_COMMIT=""
export ID_TAREFA=""
export ESCOPO=""
export RESUMO=""
export CORPO=""

# ============================================
# FUNÇÕES DE PERGUNTAS
# ============================================

perguntar_tipo() {
    titulo "📌 PASSO 1 DE 4: ESCOLHA O TIPO DE COMMIT"
    
    info "O tipo de commit classifica a NATUREZA da sua alteração."
    echo ""
    
    local opcoes=()
    for item in "${TIPOS_COMMIT[@]}"; do
        opcoes+=("${item}")
    done
    
    local escolha=$(selecionar_opcao "Tipos disponíveis (Convenção do Angular):" "${opcoes[@]}")
    
    TIPO_COMMIT=$(echo "$escolha" | cut -d':' -f1)
    
    success "Tipo escolhido: ${BOLD}${TIPO_COMMIT}${NC}"
    echo ""
    info "📌 Você usou '${TIPO_COMMIT}' porque: $(echo "$escolha" | cut -d':' -f2)"
    pause
}

perguntar_id_tarefa() {
    titulo "🆔 PASSO 2 DE 4: ID DA TAREFA (OPCIONAL)"
    
    info "Código da tarefa no JIRA, Trello, GitHub Issues, etc."
    echo "  Exemplos: TL-100, PROJ-42, #15"
    echo ""
    info "Por que usar? Conecta o commit à tarefa correspondente."
    echo ""
    
    read -p "Digite o ID (ou ENTER para pular): " ID_TAREFA
    
    if [ -n "$ID_TAREFA" ]; then
        success "ID registrado: ${BOLD}${ID_TAREFA}${NC}"
    else
        warning "Nenhum ID informado."
    fi
    pause
}

perguntar_escopo() {
    titulo "📂 PASSO 3 DE 4: ESCOPO (OPCIONAL)"
    
    info "Parte do projeto afetada."
    echo "  Exemplos: dados, pipeline, api, frontend, auth, database"
    echo ""
    info "Quando usar: Quando a mudança afeta um módulo específico."
    echo ""
    
    read -p "Digite o escopo (ou ENTER para pular): " ESCOPO
    
    if [ -n "$ESCOPO" ]; then
        success "Escopo definido: ${BOLD}${ESCOPO}${NC}"
        info "A mensagem ficará: ${TIPO_COMMIT}(${ESCOPO}): ..."
    else
        warning "Escopo pulado."
    fi
    pause
}

perguntar_resumo() {
    titulo "📝 PASSO 4 DE 4: RESUMO (OBRIGATÓRIO)"
    
    info "Frase CURTA descrevendo O QUE foi feito."
    echo "  ✅ Máximo de 72 caracteres"
    echo "  ✅ Use verbos no presente: 'Adiciona', 'Corrige', 'Remove'"
    echo "  ✅ Seja específico: diga O QUE, não COMO"
    echo ""
    
    destaque "Exemplos:"
    echo "  ✅ 'Adiciona validação de dados'"
    echo "  ✅ 'Corrige encoding na leitura de CSV'"
    echo "  ✅ 'Remove dependência obsoleta'"
    echo "  ❌ 'Atualizações no código' (muito vago)"
    echo ""
    
    while true; do
        read -p "Digite o resumo: " RESUMO
        if [ -z "$RESUMO" ]; then
            error "O resumo é OBRIGATÓRIO. Digite algo."
            continue
        fi
        
        local tamanho=${#RESUMO}
        if [ $tamanho -gt 72 ]; then
            error "Resumo com $tamanho caracteres (máx 72)."
            echo "  Por favor, encurte mantendo a essência:"
            echo "  '$RESUMO'"
            continue
        fi
        
        success "Resumo válido (${BOLD}${tamanho}${NC} caracteres)."
        break
    done
    
    echo ""
    destaque "📌 Sua mensagem parcial:"
    if [ -n "$ESCOPO" ]; then
        echo -e "  ${CYAN}${TIPO_COMMIT}(${ESCOPO}): ${RESUMO}${NC}"
    else
        echo -e "  ${CYAN}${TIPO_COMMIT}: ${RESUMO}${NC}"
    fi
    pause
}

perguntar_corpo() {
    titulo "🔬 CORPO DO COMMIT (OPCIONAL)"
    
    info "Detalhes técnicos da mudança."
    echo "  📌 O problema que você estava resolvendo"
    echo "  📌 A abordagem que você usou"
    echo "  📌 Alternativas consideradas (se houver)"
    echo "  📌 Impacto esperado"
    echo ""
    info "Pense em você mesmo daqui a 6 meses tentando entender"
    echo "  por que fez essa mudança. Escreva para essa pessoa."
    echo ""
    
    echo -e "${CYAN}Digite o corpo (várias linhas). Digite 'FIM' para finalizar.${NC}"
    echo ""
    
    CORPO=""
    local linha_num=0
    
    while true; do
        read -p "> " linha
        
        if [ "$linha" = "FIM" ] || [ "$linha" = "fim" ]; then
            break
        fi
        
        if [ -z "$linha" ] && [ $linha_num -eq 0 ]; then
            warning "Pulando corpo..."
            CORPO=""
            break
        fi
        
        if [ -z "$linha" ] && [ $linha_num -gt 0 ]; then
            break
        fi
        
        if [ $linha_num -eq 0 ]; then
            CORPO="$linha"
        else
            CORPO="${CORPO}
${linha}"
        fi
        linha_num=$((linha_num + 1))
    done
    
    if [ -n "$CORPO" ]; then
        success "Corpo adicionado."
    else
        warning "Corpo pulado."
    fi
    pause
}

montar_mensagem() {
    local mensagem="${TIPO_COMMIT}"
    
    if [ -n "$ESCOPO" ]; then
        mensagem="${mensagem}(${ESCOPO})"
    fi
    
    mensagem="${mensagem}: ${RESUMO}"
    
    if [ -n "$CORPO" ]; then
        mensagem="${mensagem}

${CORPO}"
    fi
    
    echo "$mensagem"
}

export -f perguntar_tipo perguntar_id_tarefa perguntar_escopo
export -f perguntar_resumo perguntar_corpo montar_mensagem