#!/bin/bash
# Instalar (Linux).sh
# Duplo clique neste arquivo para instalar os hooks no repositório atual.
#
# IMPORTANTE (Linux): por padrão a maioria dos gerenciadores de arquivos (Nautilus,
# Dolphin, etc.) abre arquivos .sh como texto em vez de executá-los, por segurança.
# Na primeira vez, pode ser necessário:
#   1. Clique com o botão direito neste arquivo → Propriedades → Permissões →
#      marcar "Permitir execução como programa" (ou equivalente).
#   2. Em alguns ambientes (GNOME recente), pode aparecer um diálogo perguntando
#      se você quer "Executar" ou "Exibir" o arquivo — escolha "Executar".
# Se preferir, basta abrir um terminal nesta pasta e rodar:
#   bash .hooks/install.sh

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
