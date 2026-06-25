#!/bin/bash
# .hooks/modules/ui.sh
# Funções de interface

# ============================================
# CORES
# ============================================

export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[1;33m'
export BLUE='\033[0;34m'
export MAGENTA='\033[0;35m'
export CYAN='\033[0;36m'
export WHITE='\033[1;37m'
export NC='\033[0m'
export BOLD='\033[1m'
export UNDERLINE='\033[4m'

# ============================================
# FUNÇÕES
# ============================================

titulo() {
    local texto="$1"
    clear
    echo ""
    echo -e "${BLUE}╔════════════════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║  ${texto}  ║${NC}"
    echo -e "${BLUE}╚════════════════════════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

subtitulo() {
    echo ""
    echo -e "${CYAN}${BOLD}▶ $1${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

pause() {
    echo ""
    read -p "👉 Pressione ENTER para continuar... "
}

pause_com_mensagem() {
    local mensagem="${1:-Pressione ENTER para continuar...}"
    echo ""
    read -p "👉 ${mensagem} "
}

success() {
    echo -e "${GREEN}✅ $1${NC}"
}

error() {
    echo -e "${RED}❌ $1${NC}"
}

warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

info() {
    echo -e "${CYAN}ℹ️  $1${NC}"
}

destaque() {
    echo -e "${BOLD}${BLUE}📌 $1${NC}"
}

linha() {
    echo -e "${BLUE}════════════════════════════════════════════════════════════════════════════${NC}"
}

linha_fina() {
    echo -e "${CYAN}────────────────────────────────────────────────────────────────────────────────${NC}"
}

human_readable() {
    local bytes=$1
    if [ -z "$bytes" ] || [ "$bytes" -eq 0 ]; then
        echo "0B"
    elif [ $bytes -lt 1024 ]; then
        echo "${bytes}B"
    elif [ $bytes -lt 1048576 ]; then
        echo "$((bytes / 1024))KB"
    elif [ $bytes -lt 1073741824 ]; then
        echo "$((bytes / 1048576))MB"
    else
        echo "$((bytes / 1073741824))GB"
    fi
}

menu_numerado() {
    local titulo="$1"
    shift
    local opcoes=("$@")
    
    echo -e "${YELLOW}${BOLD}${titulo}${NC}"
    for i in "${!opcoes[@]}"; do
        echo "  ${BOLD}$((i+1))${NC}. ${opcoes[$i]}"
    done
    echo ""
}

selecionar_opcao() {
    local titulo="$1"
    shift
    local opcoes=("$@")
    local max=${#opcoes[@]}
    
    menu_numerado "$titulo" "${opcoes[@]}"
    
    while true; do
        read -p "Digite o número (1-$max): " escolha
        if [[ "$escolha" =~ ^[0-9]+$ ]] && [ "$escolha" -ge 1 ] && [ "$escolha" -le "$max" ]; then
            echo "${opcoes[$((escolha-1))]}"
            return 0
        else
            error "Opção inválida. Digite um número entre 1 e $max."
        fi
    done
}

formatar_arquivo() {
    local arquivo="$1"
    local tamanho="$2"
    local status="$3"
    
    local icone="📄"
    if echo "$arquivo" | grep -qiE "\.($EXTENSOES_DADOS)$"; then
        icone="📊"
    fi
    
    local cor=""
    local status_texto=""
    
    case "$status" in
        "BLOQUEADO")
            cor="${RED}"
            status_texto="❌ BLOQUEADO"
            ;;
        "GRANDE")
            cor="${YELLOW}"
            status_texto="⚠️ GRANDE"
            ;;
        *)
            cor="${GREEN}"
            status_texto=""
            ;;
    esac
    
    echo -e "${cor}${icone} ${BOLD}${arquivo}${NC}${cor} - $(human_readable $tamanho) ${status_texto}${NC}"
}

export -f titulo subtitulo pause pause_com_mensagem
export -f success error warning info destaque
export -f linha linha_fina human_readable
export -f menu_numerado selecionar_opcao formatar_arquivo