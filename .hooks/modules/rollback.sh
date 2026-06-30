#!/bin/bash
# .hooks/modules/rollback.sh
# Sistema de rollback

source "$(dirname "${BASH_SOURCE[0]}")/config.sh"
source "$(dirname "${BASH_SOURCE[0]}")/ui.sh"

# ============================================
# ROLLBACK
# ============================================

criar_ponto_restauracao() {
    local ponto_file="$LOG_DIR/rollback-$(date +%Y%m%d_%H%M%S).points"
    
    info "💾 Criando ponto de restauração..."
    
    # Salva estado atual
    git rev-parse HEAD > "$ponto_file" 2>/dev/null
    git diff --cached >> "$ponto_file" 2>/dev/null
    
    success "✅ Ponto de restauração criado: $ponto_file"
}

executar_rollback() {
    local ponto_file="$1"
    
    if [ ! -f "$ponto_file" ]; then
        error "Ponto de restauração não encontrado: $ponto_file"
        return 1
    fi
    
    info "🔄 Executando rollback para: $ponto_file"
    
    # Lê o commit hash
    local commit_hash=$(head -n 1 "$ponto_file")
    
    if [ -n "$commit_hash" ]; then
        git reset --hard "$commit_hash"
        success "✅ Rollback executado para $commit_hash"
    else
        warning "⚠️  Não foi possível executar rollback."
        return 1
    fi
}

export -f criar_ponto_restauracao executar_rollback