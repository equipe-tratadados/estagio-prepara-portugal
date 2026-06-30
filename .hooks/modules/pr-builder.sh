#!/bin/bash
# .hooks/modules/pr-builder.sh
# Geração do template da Pull Request

source "$(dirname "${BASH_SOURCE[0]}")/config.sh"
source "$(dirname "${BASH_SOURCE[0]}")/ui.sh"

# ============================================
# VARIÁVEIS GLOBAIS
# ============================================

export PR_TIPO=""
export PR_DESCRICAO=""
export PR_SCREENSHOTS=""
export PR_DEPENDENCIAS=""

# ============================================
# FUNÇÕES DE PERGUNTAS
# ============================================

perguntar_tipo_pr() {
    titulo "📋 PREPARANDO A PULL REQUEST - TIPO"
    
    info "Classifique sua mudança para a PR (alinhado com CONTRIBUTING.md)."
    echo ""
    
    local opcoes=(
        "Adição de dados"
        "Limpeza/Tratamento de dados existentes"
        "Script novo/atualizado"
        "Documentação - mudanças em docs, reports, etc"
        "Correção - Ajuste pontual em dados ou script"
        "Entrega - Movendo arquivos para data/3-delivery/"
    )
    
    local escolha=$(selecionar_opcao "Tipo de mudança:" "${opcoes[@]}")
    PR_TIPO="$escolha"
    
    success "Tipo para PR: ${BOLD}${PR_TIPO}${NC}"
    pause
}

perguntar_descricao_pr() {
    titulo "📋 PREPARANDO A PULL REQUEST - DESCRIÇÃO"
    
    info "Explique o contexto e motivação da mudança."
    echo "  Pense em quem vai revisar seu código."
    echo ""
    info "Exemplo: 'Esta PR adiciona validação de dados no backend'"
    echo ""
    
    read -p "Digite a descrição (ou ENTER para pular): " PR_DESCRICAO
    
    if [ -n "$PR_DESCRICAO" ]; then
        success "Descrição adicionada."
    else
        warning "Descrição pulada."
    fi
    pause
}

perguntar_screenshots_pr() {
    titulo "📋 PREPARANDO A PULL REQUEST - SCREENSHOTS"
    
    info "Screenshots ajudam a visualizar a mudança."
    echo "  Descreva ou cole links para imagens."
    echo "  Se não houver, digite 'N/A'"
    echo ""
    
    read -p "Digite a descrição (ou ENTER): " PR_SCREENSHOTS
    
    if [ -z "$PR_SCREENSHOTS" ]; then
        PR_SCREENSHOTS="N/A"
    fi
    success "Screenshots registradas."
    pause
}

perguntar_dependencias_pr() {
    titulo "📋 PREPARANDO A PULL REQUEST - DEPENDÊNCIAS"
    
    info "Outras PRs que são necessárias para esta funcionar."
    echo "  Exemplo: 'https://github.com/org/repo/pull/42'"
    echo "  Se não houver, digite 'N/A'"
    echo ""
    
    read -p "Digite (ou ENTER): " PR_DEPENDENCIAS
    
    if [ -z "$PR_DEPENDENCIAS" ]; then
        PR_DEPENDENCIAS="N/A"
    fi
    success "Dependências registradas."
    pause
}

montar_template_pr() {
    # Determina qual tipo foi escolhido para marcar no checkbox
    local tipo_checkbox="x"
    
    # Constrói checklist específico baseado no tipo
    local checklist_especifico=""
    
    case "$PR_TIPO" in
        *"dados"*|*"Limpeza"*|*"Entrega"*)
            checklist_especifico="
#### Aplicável apenas para **dados** (CSV, Excel, etc.):
- [ ] Os arquivos em \`data/1-raw/\` permanecem **inalterados**
- [ ] O CSV segue o padrão: UTF-8, separador \`;\`, datas \`AAAA-MM-DD\`"
            ;;
        *"Script"*)
            checklist_especifico="
#### Aplicável apenas para **scripts**:
- [ ] Testei localmente o funcionamento do script"
            ;;
        *"Documentação"*)
            checklist_especifico="
#### Aplicável apenas para **documentação**:
- [ ] Verifiquei links e formatação Markdown"
            ;;
    esac
    
    # Adiciona checklist para entrega
    if [[ "$PR_TIPO" == *"Entrega"* ]]; then
        checklist_especifico="${checklist_especifico}

#### Aplicável apenas para **dados que vão para \`delivery/\`**:
- [ ] Atualizei \`docs/dicionario.md\`"
    fi
    
    local template="## 📌 Descrição da PR
<!-- Descreva em 1-2 frases o que foi feito -->

${PR_DESCRICAO}

## Tipo de alteração
- [${tipo_checkbox}] **${PR_TIPO}**

## Checklist de qualidade

#### Obrigatório para TODAS as PRs:
- [ ] A branch está atualizada com \`main\`
${checklist_especifico}

## Tarefa relacionada:
${ID_TAREFA:-<!-- Link ou ID da task (ex.: BU001, DP-012) -->}

## Screenshots (se aplicável)
${PR_SCREENSHOTS}

## Dependências
${PR_DEPENDENCIAS}"
    
    echo "$template"
}

salvar_template_pr() {
    local template="$1"
    
    # Salva como rascunho para não sobrescrever o template do projeto
    mkdir -p .github/pr-drafts
    local timestamp=$(date +"%Y%m%d_%H%M%S")
    local draft_file=".github/pr-drafts/pr-${timestamp}.md"
    
    echo "$template" > "$draft_file"
    success "📝 Rascunho da PR salvo em: ${BOLD}${draft_file}${NC}"
    info "� Copie este conteúdo ao abrir a PR no GitHub!"
    info "   O template padrão em .github/pull_request_template será preenchido automaticamente"
}

export -f perguntar_tipo_pr perguntar_descricao_pr
export -f perguntar_screenshots_pr perguntar_dependencias_pr
export -f montar_template_pr salvar_template_pr