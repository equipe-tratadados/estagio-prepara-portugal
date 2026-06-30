#!/bin/bash
# .hooks/modules/lfs-helper.sh
# Configuração automática do Git LFS

source "$(dirname "${BASH_SOURCE[0]}")/config.sh"
source "$(dirname "${BASH_SOURCE[0]}")/ui.sh"

# ============================================
# FUNÇÕES DO LFS
# ============================================

verificar_lfs() {
    if command -v git-lfs &> /dev/null; then
        return 0
    else
        return 1
    fi
}

configurar_lfs_para_extensao() {
    local extensao="$1"
    
    if [ -z "$extensao" ]; then
        return 1
    fi
    
    echo -e "  🔧 Configurando LFS para: ${CYAN}*.${extensao}${NC}"
    git lfs track "*.${extensao}"
}

configurar_lfs_automatico() {
    titulo "⚙️ CONFIGURANDO GIT LFS"
    
    if ! verificar_lfs; then
        error "Git LFS não encontrado."
        echo ""
        warning "📌 Instale com:"
        echo -e "  ${CYAN}brew install git-lfs${NC}  # macOS"
        echo -e "  ${CYAN}sudo apt install git-lfs${NC}  # Ubuntu"
        echo "  Ou visite: https://git-lfs.com"
        echo ""
        info "Depois, configure manualmente com:"
        echo -e "  ${CYAN}git lfs install${NC}"
        echo -e "  ${CYAN}git lfs track \"*.csv\" \"*.parquet\" \"*.pkl\"${NC}"
        pause
        return 1
    fi
    
    success "Git LFS encontrado!"
    echo ""
    
    # Instala LFS se necessário
    if ! git lfs install 2>/dev/null | grep -q "Git LFS initialized"; then
        git lfs install
    fi
    
    # Detecta extensões de arquivos grandes
    local extensoes_adicionadas=()
    
    for i in "${!ARQUIVOS_NOMES[@]}"; do
        if [ "${ARQUIVOS_STATUS[$i]}" = "GRANDE" ] || [ "${ARQUIVOS_STATUS[$i]}" = "BLOQUEADO" ]; then
            local extensao="${ARQUIVOS_NOMES[$i]##*.}"
            
            if [ -n "$extensao" ]; then
                # Verifica se já não foi adicionada
                local ja_adicionada=0
                for ext in "${extensoes_adicionadas[@]}"; do
                    if [ "$ext" = "$extensao" ]; then
                        ja_adicionada=1
                        break
                    fi
                done
                
                if [ $ja_adicionada -eq 0 ]; then
                    configurar_lfs_para_extensao "$extensao"
                    extensoes_adicionadas+=("$extensao")
                fi
            fi
        fi
    done
    
    # Adiciona .gitattributes
    git add .gitattributes 2>/dev/null
    
    echo ""
    success "Git LFS configurado!"
    info "📌 Execute 'git add' novamente para usar LFS."
    pause
}

oferecer_lfs() {
    if [ $ARQUIVOS_GRANDES -gt 0 ] || [ $ARQUIVOS_MUITO_GRANDES -gt 0 ]; then
        titulo "⚠️ ARQUIVOS GRANDES DETECTADOS"
        
        warning "Arquivos com mais de ${LIMITE_AVISO_MB}MB podem causar:"
        echo "  ❌ Repositório lento"
        echo "  ❌ Problemas de clone/pull"
        echo "  ❌ Erros de envio"
        echo ""
        
        destaque "📌 Recomendações:"
        echo "  1. Instalar e configurar Git LFS (recomendado)"
        echo "  2. Adicionar ao .gitignore"
        echo "  3. Comprimir os arquivos"
        echo "  4. Usar --force (com cuidado)"
        echo ""
        
        read -p "Deseja configurar Git LFS automaticamente? (s/n): " configurar_lfs
        
        if [ "$configurar_lfs" = "s" ] || [ "$configurar_lfs" = "S" ]; then
            configurar_lfs_automatico
        else
            warning "Git LFS não será configurado."
            echo "  Lembre-se: arquivos grandes podem causar problemas."
            pause
        fi
    fi
}

export -f verificar_lfs configurar_lfs_automatico oferecer_lfs