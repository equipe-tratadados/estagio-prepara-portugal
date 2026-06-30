#!/bin/bash
# .hooks/plugins/example-plugin.sh
# Exemplo de plugin para o sistema de hooks

# ============================================
# HOOK PRE-COMMIT
# ============================================

plugin_example_pre_commit() {
    echo "🔍 Plugin exemplo: verificando arquivos antes do commit..."
    
    # Exemplo: verifica se há arquivos com extensão .tmp
    local tmp_files=$(find . -name "*.tmp" -type f 2>/dev/null | wc -l)
    
    if [ "$tmp_files" -gt 0 ]; then
        echo "  ⚠️  Encontrados $tmp_files arquivos .tmp"
        echo "  Considere removê-los antes do commit."
    fi
    
    return 0
}

# ============================================
# HOOK POST-COMMIT
# ============================================

plugin_example_post_commit() {
    echo "📢 Plugin exemplo: commit realizado com sucesso!"
    
    # Exemplo: mostra o hash do commit
    local commit_hash=$(git rev-parse HEAD | cut -c1-8)
    echo "  📌 Hash: $commit_hash"
    
    return 0
}

# ============================================
# HOOK DE VALIDAÇÃO PERSONALIZADA
# ============================================

plugin_example_validate() {
    echo "✅ Plugin exemplo: validação personalizada passou!"
    return 0
}