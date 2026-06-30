#!/bin/bash
# .hooks/modules/logger.sh
# Sistema de logs

source "$(dirname "${BASH_SOURCE[0]}")/config.sh"

# ============================================
# LOGS
# ============================================

log_mensagem() {
    local nivel="$1"
    local mensagem="$2"
    local log_file="$LOG_DIR/commit-$(date +%Y-%m-%d).log"
    
    mkdir -p "$LOG_DIR"
    
    echo "[$(date +"%Y-%m-%d %H:%M:%S")] [$nivel] $mensagem" >> "$log_file"
}

log_info() {
    log_mensagem "INFO" "$1"
}

log_warning() {
    log_mensagem "WARNING" "$1"
}

log_error() {
    log_mensagem "ERROR" "$1"
}

log_success() {
    log_mensagem "SUCCESS" "$1"
}

# ============================================
# AUDITORIA
# ============================================

registrar_auditoria() {
    local tipo="$1"
    local detalhes="$2"
    local auditoria_file="$LOG_DIR/auditoria.log"
    
    mkdir -p "$LOG_DIR"
    
    echo "[$(date +"%Y-%m-%d %H:%M:%S")] [$tipo] Usuário: $(whoami) | Detalhes: $detalhes" >> "$auditoria_file"
}

export -f log_info log_warning log_error log_success
export -f registrar_auditoria