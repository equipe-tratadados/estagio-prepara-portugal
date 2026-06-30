#!/bin/bash
# .hooks/install.sh
# Script de instalação universal

set -e

# ============================================
# CORES
# ============================================

if [ -t 1 ]; then
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[1;33m'
    BLUE='\033[0;34m'
    CYAN='\033[0;36m'
    MAGENTA='\033[0;35m'
    NC='\033[0m'
    BOLD='\033[1m'
else
    RED=''; GREEN=''; YELLOW=''; BLUE=''; CYAN=''; MAGENTA=''; NC=''; BOLD=''
fi

# ============================================
# DETECÇÃO DO SISTEMA OPERACIONAL
# ============================================

detect_os() {
    case "$(uname -s)" in
        Linux*)     echo "linux";;
        Darwin*)    echo "macos";;
        CYGWIN*|MINGW*|MSYS*) echo "windows";;
        *)          echo "unknown";;
    esac
}

OS=$(detect_os)

# ============================================
# FUNÇÕES DE UTILIDADE
# ============================================

echo_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

echo_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

echo_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

echo_error() {
    echo -e "${RED}❌ $1${NC}"
}

echo_title() {
    echo ""
    echo -e "${BLUE}================================================================${NC}"
    echo -e "${BLUE}  ${BOLD}$1${NC}"
    echo -e "${BLUE}================================================================${NC}"
    echo ""
}

pause() {
    echo ""
    read -p "👉 Pressione ENTER para continuar... "
}

# ============================================
# VERIFICAÇÃO DE DEPENDÊNCIAS
# ============================================

check_dependencies() {
    echo_title "🔍 VERIFICANDO DEPENDÊNCIAS"
    
    local missing=()
    
    # Verifica Git
    if ! command -v git &> /dev/null; then
        missing+=("git")
    else
        echo_success "Git: $(git --version | head -n1)"
    fi
    
    # Verifica bash
    if ! command -v bash &> /dev/null; then
        missing+=("bash")
    else
        echo_success "Bash: $(bash --version | head -n1)"
    fi
    
    # Verifica curl
    if ! command -v curl &> /dev/null; then
        echo_warning "curl não encontrado (opcional - para notificações)"
    else
        echo_success "curl: $(curl --version | head -n1)"
    fi
    
    # Verifica Git LFS
    if ! command -v git-lfs &> /dev/null; then
        echo_warning "Git LFS não encontrado (recomendado para arquivos grandes)"
        echo "  Instale com:"
        case $OS in
            linux)   echo "    sudo apt-get install git-lfs" ;;
            macos)   echo "    brew install git-lfs" ;;
            windows) echo "    Baixe em: https://git-lfs.com" ;;
        esac
    else
        echo_success "Git LFS: $(git-lfs --version)"
    fi
    
    echo ""
    
    if [ ${#missing[@]} -gt 0 ]; then
        echo_error "Dependências essenciais faltando: ${missing[*]}"
        echo "  Instale antes de continuar."
        exit 1
    fi
    
    echo_success "Todas as dependências essenciais estão instaladas!"
    pause
}

# ============================================
# CONFIGURAÇÃO DO GIT
# ============================================

setup_git() {
    echo_title "⚙️ CONFIGURANDO GIT"
    
    # Configura core.hooksPath
    git config core.hooksPath .hooks
    echo_success "Git configurado para usar hooks em .hooks/"
    
    # Configura Git LFS
    if command -v git-lfs &> /dev/null; then
        echo_info "Configurando Git LFS..."
        # Usa --skip-repo para não instalar hooks (já temos hooks customizados integrados)
        git lfs install --skip-repo 2>/dev/null || true
        
        # Configura extensões
        git lfs track "*.csv" 2>/dev/null || true
        git lfs track "*.parquet" 2>/dev/null || true
        git lfs track "*.pkl" 2>/dev/null || true
        git lfs track "*.joblib" 2>/dev/null || true
        git lfs track "*.h5" 2>/dev/null || true
        git lfs track "*.feather" 2>/dev/null || true
        git lfs track "*.arrow" 2>/dev/null || true
        
        echo_success "Git LFS configurado para arquivos de dados"
        echo_info "Os hooks do Git LFS já estão integrados nos hooks customizados do projeto"
        
        # Adiciona .gitattributes se não existir
        if [ ! -f ".gitattributes" ]; then
            git add .gitattributes 2>/dev/null || true
        fi
    fi
    
    pause
}

# ============================================
# INSTALAÇÃO DOS HOOKS
# ============================================

install_hooks() {
    echo_title "📦 INSTALANDO HOOKS"
    
    # Cria estrutura de diretórios
    mkdir -p .hooks/modules
    mkdir -p .hooks/plugins
    mkdir -p .hooks/logs
    mkdir -p .hooks/backups
    
    echo_success "Estrutura de diretórios criada"
    
    # Torna os hooks executáveis
    chmod +x .hooks/* 2>/dev/null || true
    chmod +x .hooks/modules/*.sh 2>/dev/null || true
    chmod +x .hooks/plugins/*.sh 2>/dev/null || true
    
    echo_success "Hooks instalados e configurados"
    pause
}

# ============================================
# CONFIGURAÇÃO DO TEMPLATE DA PR
# ============================================

setup_pr_template() {
    echo_title "📋 VERIFICANDO TEMPLATE DA PR"
    
    # Verifica se já existe template customizado
    if [ -f ".github/pull_request_template" ] || [ -f ".github/pull_request_template.md" ]; then
        echo_success "Template de PR já existe no projeto"
        echo_info "Mantendo o template existente (recomendado para projetos customizados)"
        echo ""
        echo_warning "Se quiser usar o template padrão dos hooks, delete o arquivo existente e rode novamente."
        pause
        return 0
    fi
    
    # Só cria se não existir
    mkdir -p .github
    
    cat > .github/pull_request_template.md << 'EOF'
## 📌 Descrição da PR
<!-- Descreve em 1-2 frases o que foi feito  -->

## Tipo de alteração
- [ ] **Adição de dados**
- [ ] **Limpeza/Tratamento de dados existentes**
- [ ] **Script novo/atualizado**
- [ ] **Documentação** - mudanças em docs, reports, etc
- [ ] **Correção** - Ajuste pontual em dados ou script
- [ ] **Entrega** - Movendo arquivos para `data/3-delivery/`

## Checklist de qualidade

#### Obrigatório para TODAS as PRs:
- [ ] A branch está atualizada com `main`

#### Aplicável apenas para **dados** (CSV, Excel, etc.):
- [ ] Os arquivos em `data/1-raw/` permanecem **inalterados**
- [ ] O CSV segue o padrão: UTF-8, separador `;`, datas `AAAA-MM-DD`

#### Aplicável apenas para **scripts**:
- [ ] Testei localmente o funcionamento do script

#### Aplicável apenas para **downloads/novas fontes**:
- [ ] Atualizei `docs/log/DP003_X.md` (log individual — responsabilidade do colaborador)

#### Aplicável apenas para **dados que vão para `delivery/`**:
- [ ] Atualizei `docs/dicionario.md`

## Tarefa relacionada:
<!-- Link ou ID da task *ex.: BU001* -->
EOF
    
    echo_success "Template da PR configurado em .github/pull_request_template.md"
    pause
}

# ============================================
# VALIDAÇÃO DA INSTALAÇÃO
# ============================================

validate_installation() {
    echo_title "✅ VALIDANDO INSTALAÇÃO"
    
    # Verifica hooksPath
    if git config core.hooksPath | grep -q ".hooks"; then
        echo_success "hooksPath configurado: $(git config core.hooksPath)"
    else
        echo_warning "hooksPath não configurado"
    fi
    
    # Verifica hook principal
    if [ -f ".hooks/prepare-commit-msg" ]; then
        echo_success "Hook principal: .hooks/prepare-commit-msg"
    else
        echo_error "Hook principal não encontrado"
    fi
    
    # Conta módulos
    local module_count=$(ls -1 .hooks/modules/*.sh 2>/dev/null | wc -l)
    echo_success "Módulos instalados: $module_count"
    
    # Conta plugins
    local plugin_count=$(ls -1 .hooks/plugins/*.sh 2>/dev/null | wc -l)
    echo_success "Plugins instalados: $plugin_count"
    
    echo ""
    echo_success "Instalação validada com sucesso!"
    pause
}

# ============================================
# ATUALIZAR .gitignore
# ============================================

update_gitignore() {
    echo_info "Atualizando .gitignore..."
    
    # Verifica se .gitignore existe
    if [ ! -f ".gitignore" ]; then
        touch .gitignore
    fi
    
    # Adiciona entradas se não existirem
    if ! grep -q ".hooks/logs/" .gitignore 2>/dev/null; then
        echo "" >> .gitignore
        echo "# Git hooks - logs, backups e rascunhos de PR" >> .gitignore
        echo ".hooks/logs/" >> .gitignore
        echo ".hooks/backups/" >> .gitignore
        echo ".hooks/*.log" >> .gitignore
        echo ".github/pr-drafts/" >> .gitignore
    fi
    
    echo_success ".gitignore atualizado"
}

# ============================================
# MENU PRINCIPAL
# ============================================

show_welcome() {
    clear
    echo ""
    echo -e "${BLUE}====================================================================${NC}"
    echo -e "${BLUE}                                                                    ${NC}"
    echo -e "${BLUE}  ${BOLD}🚀 INSTALADOR UNIVERSAL DE HOOKS PARA CIÊNCIA DE DADOS${NC}"
    echo -e "${BLUE}                                                                    ${NC}"
    echo -e "${BLUE}  v3.0.0 - Baseado no artigo do TabNews                            ${NC}"
    echo -e "${BLUE}                                                                    ${NC}"
    echo -e "${BLUE}====================================================================${NC}"
    echo ""
    echo -e "${CYAN}Sistema detectado: ${BOLD}$OS${NC}"
    echo ""
    echo "Este instalador vai:"
    echo "  ✅ Verificar dependências"
    echo "  ✅ Configurar o Git para usar os hooks"
    echo "  ✅ Instalar todos os módulos"
    echo "  ✅ Configurar Git LFS"
    echo "  ✅ Configurar template da PR"
    echo "  ✅ Validar a instalação"
    echo ""
    echo -e "${YELLOW}Pressione ENTER para iniciar ou Ctrl+C para cancelar${NC}"
    read -p "👉 " -t 5 || true
}

# ============================================
# FUNÇÃO PRINCIPAL
# ============================================

main() {
    # Verifica se está na raiz do repositório
    if [ ! -d ".git" ]; then
        echo_error "Este script deve ser executado na raiz do repositório Git"
        echo "  Execute: cd /caminho/do/seu/repositorio && .hooks/install.sh"
        exit 1
    fi
    
    show_welcome
    check_dependencies
    setup_git
    install_hooks
    setup_pr_template
    update_gitignore
    validate_installation
    
    echo ""
    echo -e "${GREEN}====================================================================${NC}"
    echo -e "${GREEN}  ${BOLD}✅ INSTALAÇÃO CONCLUÍDA COM SUCESSO!${NC}"
    echo -e "${GREEN}====================================================================${NC}"
    echo ""
    echo -e "${BOLD}📋 Como usar:${NC}"
    echo "  1. Faça suas alterações nos arquivos"
    echo "  2. git add ."
    echo "  3. git commit  # O assistente será iniciado"
    echo ""
    echo -e "${BOLD}📁 Onde estão os arquivos:${NC}"
    echo "  📂 .hooks/          → Todos os hooks e módulos"
    echo "  📂 .hooks/modules/  → Módulos do sistema"
    echo "  📂 .hooks/plugins/  → Plugins customizados"
    echo ""
    echo -e "${BOLD}🔧 Personalização:${NC}"
    echo "  Edite .hooks/modules/config.sh para ajustar limites"
    echo "  Adicione scripts em .hooks/plugins/ para novas funcionalidades"
    echo ""
    echo -e "${YELLOW}💡 Dica: Commit os arquivos .hooks/ para compartilhar com o time!${NC}"
    echo ""
}

# Executa
main