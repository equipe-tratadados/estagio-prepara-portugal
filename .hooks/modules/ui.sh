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
# CONVENÇÃO: toda função aqui que serve para EXIBIR algo na tela (menus, títulos,
# mensagens de sucesso/erro/aviso/info) escreve em stderr (>&2), nunca em stdout.
# Isso evita que ela seja "engolida" sempre que algum caller futuro a chamar dentro
# de $(...) (foi exatamente isso que causou o bug histórico do selecionar_opcao).
# Só funções que existem para RETORNAR um valor (ex.: human_readable, selecionar_opcao)
# usam stdout, e só para o valor em si — nunca para texto decorativo.

titulo() {
    local texto="$1"
    clear
    echo "" >&2
    echo -e "${BLUE}================================================================================${NC}" >&2
    echo -e "${BLUE}  ${BOLD}${texto}${NC}" >&2
    echo -e "${BLUE}================================================================================${NC}" >&2
    echo "" >&2
}

subtitulo() {
    echo "" >&2
    echo -e "${CYAN}${BOLD}>> $1${NC}" >&2
    echo -e "${CYAN}-------------------------------------------------------------------------------${NC}" >&2
}

pause() {
    echo "" >&2
    read -p "👉 Pressione ENTER para continuar... " >&2
}

pause_com_mensagem() {
    local mensagem="${1:-Pressione ENTER para continuar...}"
    echo "" >&2
    read -p "👉 ${mensagem} " >&2
}

success() {
    echo -e "${GREEN}✅ $1${NC}" >&2
}

error() {
    echo -e "${RED}❌ $1${NC}" >&2
}

warning() {
    echo -e "${YELLOW}⚠️  $1${NC}" >&2
}

info() {
    echo -e "${CYAN}ℹ️  $1${NC}" >&2
}

destaque() {
    echo -e "${BOLD}${BLUE}📌 $1${NC}" >&2
}

linha() {
    echo -e "${BLUE}================================================================================${NC}" >&2
}

linha_fina() {
    echo -e "${CYAN}--------------------------------------------------------------------------------${NC}" >&2
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
    
    echo -e "${YELLOW}${BOLD}${titulo}${NC}" >&2
    for i in "${!opcoes[@]}"; do
        echo "  ${BOLD}$((i+1))${NC}. ${opcoes[$i]}" >&2
    done
    echo "" >&2
}

selecionar_opcao() {
    local titulo="$1"
    shift
    local opcoes=("$@")
    local max=${#opcoes[@]}
    
    # IMPORTANTE: esta função é chamada via $(...) pelos callers (ex.: commit-builder.sh),
    # então TUDO que for output de interface (menu, prompts, mensagens de erro) precisa ir
    # para stderr (>&2). Só o valor escolhido (echo final) pode ir para stdout, ou então
    # ele é "engolido" junto com o menu inteiro e a tela fica em branco para o usuário.
    menu_numerado "$titulo" "${opcoes[@]}" >&2

    while true; do
        read -p "Digite o número (1-$max): " escolha >&2
        if [[ "$escolha" =~ ^[0-9]+$ ]] && [ "$escolha" -ge 1 ] && [ "$escolha" -le "$max" ]; then
            echo "${opcoes[$((escolha-1))]}"
            return 0
        else
            error "Opção inválida. Digite um número entre 1 e $max." >&2
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