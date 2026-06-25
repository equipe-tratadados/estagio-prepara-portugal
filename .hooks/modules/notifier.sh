#!/bin/bash
# .hooks/modules/notifier.sh
# Notificações Slack/Teams

source "$(dirname "${BASH_SOURCE[0]}")/config.sh"
source "$(dirname "${BASH_SOURCE[0]}")/ui.sh"

# ============================================
# SLACK
# ============================================

notificar_slack() {
    if [ "$NOTIFICAR_SLACK" != "true" ]; then
        return 0
    fi
    
    if [ -z "$SLACK_WEBHOOK_URL" ]; then
        warning "Slack webhook URL não configurada."
        return 1
    fi
    
    local mensagem="$1"
    local usuario="${2:-Cientista de Dados}"
    
    local payload="{
        \"text\": \"🔔 *${usuario}* realizou um commit:\n${mensagem}\",
        \"username\": \"Git Hook Bot\",
        \"icon_emoji\": \":git:\"
    }"
    
    curl -s -X POST -H "Content-Type: application/json" -d "$payload" "$SLACK_WEBHOOK_URL" &> /dev/null
    
    if [ $? -eq 0 ]; then
        success "✅ Notificação enviada para Slack"
    else
        warning "⚠️  Falha ao enviar notificação para Slack"
    fi
}

# ============================================
# TEAMS
# ============================================

notificar_teams() {
    if [ "$NOTIFICAR_TEAMS" != "true" ]; then
        return 0
    fi
    
    if [ -z "$TEAMS_WEBHOOK_URL" ]; then
        warning "Teams webhook URL não configurada."
        return 1
    fi
    
    local mensagem="$1"
    local usuario="${2:-Cientista de Dados}"
    
    local payload="{
        \"title\": \"🔔 Commit Realizado\",
        \"text\": \"**${usuario}** realizou um commit:\n\n${mensagem}\"
    }"
    
    curl -s -X POST -H "Content-Type: application/json" -d "$payload" "$TEAMS_WEBHOOK_URL" &> /dev/null
    
    if [ $? -eq 0 ]; then
        success "✅ Notificação enviada para Teams"
    else
        warning "⚠️  Falha ao enviar notificação para Teams"
    fi
}

notificar_completo() {
    local mensagem="$1"
    
    info "📢 Enviando notificações..."
    
    notificar_slack "$mensagem"
    notificar_teams "$mensagem"
}

export -f notificar_slack notificar_teams notificar_completo