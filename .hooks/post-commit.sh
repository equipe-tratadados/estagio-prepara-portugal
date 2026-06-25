#!/bin/bash
# .hooks/post-commit
# Hook executado após o commit (notificações, limpeza, etc)

# ============================================
# CONFIGURAÇÃO INICIAL
# ============================================

# Carrega módulos se disponíveis
HOOKS_COMMON_DIR="$(cd "$(dirname "$0")/modules" 2>/dev/null && pwd)"

if [ -d "$HOOKS_COMMON_DIR" ]; then
    for modulo in "$HOOKS_COMMON_DIR"/*.sh; do
        [ -f "$modulo" ] && source "$modulo"
    done
fi

# ============================================
# CORES (fallback)
# ============================================

if [ -z "$GREEN" ]; then
    GREEN='\033[0;32m'
    YELLOW='\033[1;33m'
    BLUE='\033[0;34m'
    NC='\033[0m'
fi

# ============================================
# FUNÇÕES PÓS-COMMIT
# ============================================

post_commit_cleanup() {
    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}✅ Commit realizado com sucesso!${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    
    # Mostra o último commit
    echo ""
    echo -e "${YELLOW}📋 Último commit:${NC}"
    git log -1 --oneline
    echo ""
    
    # Executa plugins pós-commit
    if declare -F executar_plugin_hook &>/dev/null; then
        executar_plugin_hook "post_commit"
    fi
    
    # Notifica se configurado
    if declare -F notificar_completo &>/dev/null; then
        local commit_msg=$(git log -1 --pretty=%B)
        notificar_completo "$commit_msg" 2>/dev/null
    fi
    
    # Limpa backups antigos
    if [ -d ".hooks/backups" ] && declare -F log_info &>/dev/null; then
        log_info "Backups antigos mantidos por ${BACKUP_KEEP_DAYS:-30} dias"
    fi
}

# ============================================
# EXECUÇÃO
# ============================================

post_commit_cleanup

exit 0