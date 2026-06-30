#!/bin/bash
# Instalar (macOS).command
# Duplo clique neste arquivo no Finder para instalar os hooks no repositório atual.
# (No macOS, terminais costumam abrir arquivos .command diretamente.)

cd "$(dirname "$0")" || exit 1

if [ ! -f ".hooks/install.sh" ]; then
    echo "❌ Erro: .hooks/install.sh não encontrado."
    echo "   Este arquivo precisa estar na raiz do repositório, junto com a pasta .hooks/."
    read -p "Pressione ENTER para fechar..."
    exit 1
fi

bash ".hooks/install.sh"

echo ""
read -p "Instalação concluída. Pressione ENTER para fechar esta janela..."
