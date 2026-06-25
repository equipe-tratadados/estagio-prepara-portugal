#!/bin/bash
# .hooks/modules/backup-manager.sh
# Backup automático antes do commit

source "$(dirname "${BASH_SOURCE[0]}")/config.sh"
source "$(dirname "${BASH_SOURCE[0]}")/ui.sh"

# ============================================
# BACKUP
# ============================================

criar_backup() {
    if [ "$BACKUP_ENABLED" != "true" ]; then
        return 0
    fi
    
    mkdir -p "$BACKUP_DIR"
    
    local data=$(date +"%Y%m%d_%H%M%S")
    local backup_file="${BACKUP_DIR}/commit-backup-${data}.tar.gz"
    
    info "💾 Criando backup antes do commit..."
    
    local arquivos=$(git diff --cached --name-only | tr '\n' ' ')
    
    if [ -z "$arquivos" ]; then
        warning "Nenhum arquivo para backup."
        return 0
    fi
    
    tar -czf "$backup_file" $arquivos 2>/dev/null
    
    if [ $? -eq 0 ]; then
        success "✅ Backup criado: $backup_file"
        
        # Remove backups antigos
        local keep_days=$BACKUP_KEEP_DAYS
        find "$BACKUP_DIR" -name "*.tar.gz" -mtime "+$keep_days" -delete 2>/dev/null
        
        return 0
    else
        warning "⚠️  Falha ao criar backup."
        return 1
    fi
}

listar_backups() {
    if [ ! -d "$BACKUP_DIR" ]; then
        info "Nenhum backup encontrado."
        return 0
    fi
    
    echo ""
    echo -e "${YELLOW}📋 Backups disponíveis:${NC}"
    find "$BACKUP_DIR" -name "*.tar.gz" -type f -exec ls -lh {} \; | awk '{print "  " $9 " - " $5}'
}

restaurar_backup() {
    local arquivo="$1"
    
    if [ ! -f "$arquivo" ]; then
        error "Arquivo não encontrado: $arquivo"
        return 1
    fi
    
    info "🔄 Restaurando backup: $arquivo"
    tar -xzf "$arquivo" -C .
    success "✅ Backup restaurado!"
}

export -f criar_backup listar_backups restaurar_backup