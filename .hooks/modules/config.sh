#!/bin/bash
# .hooks/modules/config.sh
# Configurações gerais do sistema

# ============================================
# VERSÃO E IDENTIFICAÇÃO
# ============================================

export HOOK_VERSION="3.0.0"
export HOOK_NAME="Assistente de Commits para Ciência de Dados"

# ============================================
# LIMITES DE ARQUIVOS
# ============================================

export LIMITE_AVISO_MB=50        # Avisa se arquivo > 50MB
export LIMITE_BLOQUEIO_MB=100    # Bloqueia se arquivo > 100MB
export LIMITE_CSV_LINHAS=1000000 # Avisa se CSV > 1M linhas

# ============================================
# EXTENSÕES
# ============================================

export EXTENSOES_DADOS="csv|parquet|json|feather|h5|pkl|joblib|pickle|arrow|avro|orc|xlsx|xls"
export EXTENSOES_LFS="csv|parquet|pkl|joblib|h5|feather|arrow"
export EXTENSOES_IGNORAR="tmp|log|cache"

# ============================================
# TIPOS DE COMMIT
# ============================================

export TIPOS_COMMIT=(
    "feat:Nova funcionalidade para o usuário final"
    "fix:Correção de bug ou problema identificado"
    "docs:Documentação do projeto, código ou dados"
    "style:Formatação, estilização, sem mudar lógica"
    "refactor:Refatoração de código sem mudar comportamento"
    "perf:Melhoria de performance ou eficiência"
    "test:Adição ou modificação de testes"
    "chore:Tarefas administrativas, build, CI/CD"
    "data:Alteração em dados, pipelines ou ETL"
    "model:Mudanças em modelos de ML ou AI"
    "experiment:Novo experimento ou abordagem"
    "deploy:Configurações de deploy ou infraestrutura"
)

# ============================================
# VALIDAÇÕES
# ============================================

export VALIDAR_ENCODING=true
export VALIDAR_SCHEMA=true
export VALIDAR_DUPLICADOS=true
export VALIDAR_TAMANHO=true

# ============================================
# MLFLOW/DVC
# ============================================

export MLFLOW_ENABLED=true
export DVC_ENABLED=true
export MLFLOW_TRACKING_URI="http://localhost:5000"

# ============================================
# BACKUP
# ============================================

export BACKUP_ENABLED=true
export BACKUP_DIR=".hooks/backups"
export BACKUP_KEEP_DAYS=30

# ============================================
# NOTIFICAÇÕES
# ============================================

export NOTIFICAR_SLACK=false
export NOTIFICAR_TEAMS=false
export SLACK_WEBHOOK_URL=""
export TEAMS_WEBHOOK_URL=""

# ============================================
# MODOS
# ============================================

export QUICK_MODE_ENABLED=true
export QUICK_MODE_THRESHOLD=3

# ============================================
# PATHS
# ============================================

export HOOKS_COMMON_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export LOG_DIR=".hooks/logs"
export PLUGIN_DIR=".hooks/plugins"
export PR_TEMPLATE_PATH=".github/pull_request_template.md"

# Cria diretórios
mkdir -p "$LOG_DIR" "$PLUGIN_DIR" "$BACKUP_DIR" 2>/dev/null