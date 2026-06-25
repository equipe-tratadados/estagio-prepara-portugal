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
    
    info "Classifique sua mudança para a PR."
    echo ""
    
    local opcoes=(
        "Bug fix (correção de problema)"
        "New feature (nova funcionalidade)"
        "Chore (documentação, pacotes, testes)"
        "Release (nova versão)"
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
    local template="## Type of change

- [ ] ${PR_TIPO}
- [ ] New feature
- [ ] Chore
- [ ] Release

## Description

${PR_DESCRICAO}

## Screenshots

${PR_SCREENSHOTS}

## Tasks

- [${ID_TAREFA}](https://link-para-sua-tarefa) or N/A

## Checklist

- [ ] My changes have less than or equal 400 lines
- [ ] I have performed a self-review of my own code
- [ ] The existing tests and linter pass locally with my changes
- [ ] I have commented my code in hard-to-understand areas (if applicable)
- [ ] I have created tests for my fix or feature (if applicable)

## Dependencies

This pull request has a dependency on the following others:

- ${PR_DEPENDENCIAS}"
    
    echo "$template"
}

salvar_template_pr() {
    local template="$1"
    
    mkdir -p .github
    echo "$template" > ".github/pull_request_template.md"
    success "Template da PR salvo em ${BOLD}.github/pull_request_template.md${NC}"
    info "📌 Use-o ao abrir sua Pull Request no GitHub!"
}

export -f perguntar_tipo_pr perguntar_descricao_pr
export -f perguntar_screenshots_pr perguntar_dependencias_pr
export -f montar_template_pr salvar_template_pr