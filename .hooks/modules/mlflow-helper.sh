#!/bin/bash
# .hooks/modules/mlflow-helper.sh
# Integração com MLflow e DVC

source "$(dirname "${BASH_SOURCE[0]}")/config.sh"
source "$(dirname "${BASH_SOURCE[0]}")/ui.sh"

# ============================================
# MLFLOW
# ============================================

verificar_mlflow() {
    if command -v mlflow &> /dev/null; then
        return 0
    else
        return 1
    fi
}

registrar_experimento_mlflow() {
    if [ "$MLFLOW_ENABLED" != "true" ]; then
        return 0
    fi
    
    if ! verificar_mlflow; then
        warning "MLflow não encontrado. Pule esta etapa."
        return 1
    fi
    
    titulo "🧪 INTEGRAÇÃO COM MLFLOW"
    
    info "O commit atual pode ser registrado no MLflow."
    echo ""
    
    read -p "Registrar experimento no MLflow? (s/n): " registrar
    
    if [ "$registrar" != "s" ] && [ "$registrar" != "S" ]; then
        info "Pulando registro no MLflow."
        return 0
    fi
    
    read -p "Nome do experimento (ou ENTER para usar 'default'): " exp_name
    exp_name="${exp_name:-default}"
    
    read -p "Tags (ex: 'env=prod,team=ds'): " mlflow_tags
    
    echo ""
    info "📊 Registrando experimento no MLflow..."
    
    local run_id=$(mlflow run . --experiment-name "$exp_name" --no-conda 2>/dev/null)
    
    if [ -n "$run_id" ]; then
        success "✅ Experimento registrado! Run ID: $run_id"
        export MLFLOW_RUN_ID="$run_id"
        export MLFLOW_EXP_NAME="$exp_name"
    else
        warning "⚠️  Erro ao registrar experimento."
    fi
}

# ============================================
# DVC
# ============================================

verificar_dvc() {
    if command -v dvc &> /dev/null; then
        return 0
    else
        return 1
    fi
}

verificar_dados_dvc() {
    if [ "$DVC_ENABLED" != "true" ]; then
        return 0
    fi
    
    if ! verificar_dvc; then
        warning "DVC não encontrado."
        return 1
    fi
    
    titulo "📦 VERIFICANDO DADOS NO DVC"
    
    local arquivos_dvc=$(find . -name "*.dvc" -type f 2>/dev/null | wc -l)
    
    if [ "$arquivos_dvc" -eq 0 ]; then
        info "Nenhum arquivo .dvc encontrado."
        return 0
    fi
    
    info "🔍 Verificando integridade dos dados..."
    
    if dvc status 2>/dev/null | grep -q "changed"; then
        warning "⚠️  Dados alterados detectados!"
        echo "  Execute 'dvc status' para mais detalhes."
        
        read -p "Deseja commitar as alterações de dados com DVC? (s/n): " dvc_commit
        
        if [ "$dvc_commit" = "s" ] || [ "$dvc_commit" = "S" ]; then
            info "📦 Atualizando dados no DVC..."
            dvc commit
            success "✅ Dados atualizados!"
        fi
    else
        success "✅ Dados estão atualizados."
    fi
}

export -f verificar_mlflow registrar_experimento_mlflow
export -f verificar_dvc verificar_dados_dvc