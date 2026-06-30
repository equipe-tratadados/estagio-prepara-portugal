#!/bin/bash
# .hooks/modules/plugin-system.sh
# Sistema de plugins

source "$(dirname "${BASH_SOURCE[0]}")/config.sh"
source "$(dirname "${BASH_SOURCE[0]}")/ui.sh"

# ============================================
# CARREGAMENTO DE PLUGINS
# ============================================

carregar_plugins() {
    if [ ! -d "$PLUGIN_DIR" ]; then
        return 0
    fi
    
    info "🔌 Carregando plugins..."
    
    for plugin in "$PLUGIN_DIR"/*.sh; do
        if [ -f "$plugin" ]; then
            source "$plugin"
            local plugin_name=$(basename "$plugin" .sh)
            success "✅ Plugin carregado: $plugin_name"
        fi
    done
}

# ============================================
# EXECUÇÃO DE HOOKS DOS PLUGINS
# ============================================

executar_plugin_hook() {
    local hook_name="$1"
    shift
    local args=("$@")
    
    for plugin in "$PLUGIN_DIR"/*.sh; do
        if [ -f "$plugin" ]; then
            local plugin_name=$(basename "$plugin" .sh)
            
            # Verifica se o plugin implementa este hook
            if declare -F "plugin_${plugin_name}_${hook_name}" &>/dev/null; then
                "plugin_${plugin_name}_${hook_name}" "${args[@]}"
            fi
        fi
    done
}

# ============================================
# PLUGIN DE EXEMPLO
# ============================================

criar_plugin_exemplo() {
    mkdir -p "$PLUGIN_DIR"
    
    cat > "$PLUGIN_DIR/example-plugin.sh" << 'EOF'
#!/bin/bash
# Exemplo de plugin

plugin_example_pre_commit() {
    echo "🔍 Plugin exemplo: verificando arquivos..."
    return 0
}

plugin_example_post_commit() {
    echo "📢 Plugin exemplo: commit realizado!"
    return 0
}
EOF
    
    chmod +x "$PLUGIN_DIR/example-plugin.sh"
    success "✅ Plugin de exemplo criado em $PLUGIN_DIR/example-plugin.sh"
}

export -f carregar_plugins executar_plugin_hook criar_plugin_exemplo