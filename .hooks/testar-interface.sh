#!/bin/bash
# .hooks/testar-interface.sh
# Script de teste interativo para visualizar o fluxo dos hooks

# ============================================
# DETECÇÃO AVANÇADA DE TERMINAL
# ============================================

# Função para testar se o terminal realmente suporta cores ANSI
testar_suporte_cores() {
    # Testa se estamos em terminal interativo
    if [ ! -t 1 ]; then
        return 1
    fi
    
    # Testa se $TERM está configurado
    if [ -z "$TERM" ] || [ "$TERM" = "dumb" ]; then
        return 1
    fi
    
    # Testa se estamos no cmd.exe (não suporta cores)
    if [ -n "$COMSPEC" ] && [ -z "$MSYSTEM" ]; then
        return 1
    fi
    
    # Se chegou aqui, provavelmente suporta cores
    return 0
}

# ============================================
# CONFIGURAÇÃO DE CORES
# ============================================

if testar_suporte_cores; then
    # Terminal suporta cores
    SUPORTA_CORES=true
    
    # Define variáveis de cor
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[1;33m'
    BLUE='\033[0;34m'
    MAGENTA='\033[0;35m'
    CYAN='\033[0;36m'
    WHITE='\033[1;37m'
    NC='\033[0m'
    BOLD='\033[1m'
    UNDERLINE='\033[4m'
    
    # Tenta carregar módulo UI
    HOOKS_DIR="$(cd "$(dirname "$0")" && pwd)"
    if [ -f "$HOOKS_DIR/modules/ui.sh" ]; then
        source "$HOOKS_DIR/modules/ui.sh" 2>/dev/null
    fi
else
    # Terminal NÃO suporta cores
    SUPORTA_CORES=false
    
    # Desabilita cores
    RED=''
    GREEN=''
    YELLOW=''
    BLUE=''
    MAGENTA=''
    CYAN=''
    WHITE=''
    NC=''
    BOLD=''
    UNDERLINE=''
    
    # Define funções fallback SEM cores
    titulo() {
        clear
        echo ""
        echo "================================================================================"
        echo "  $1"
        echo "================================================================================"
        echo ""
    }
    
    subtitulo() {
        echo ""
        echo ">> $1"
        echo "--------------------------------------------------------------------------------"
    }
    
    success() {
        echo "[OK] $1"
    }
    
    error() {
        echo "[ERRO] $1"
    }
    
    warning() {
        echo "[AVISO] $1"
    }
    
    info() {
        echo "[INFO] $1"
    }
    
    destaque() {
        echo "[*] $1"
    }
    
    linha() {
        echo "================================================================================"
    }
    
    linha_fina() {
        echo "--------------------------------------------------------------------------------"
    }
    
    human_readable() {
        local bytes=$1
        if [ -z "$bytes" ] || [ "$bytes" -eq 0 ]; then
            echo "0B"
        elif [ $bytes -lt 1024 ]; then
            echo "${bytes}B"
        elif [ $bytes -lt 1048576 ]; then
            echo "$((bytes / 1024))KB"
        elif [ $bytes -lt 1073741824 ]; then
            echo "$((bytes / 1048576))MB"
        else
            echo "$((bytes / 1073741824))GB"
        fi
    }
    
    pause() {
        echo ""
        read -p "Pressione ENTER para continuar... "
    }
    
    pause_com_mensagem() {
        local mensagem="${1:-Pressione ENTER para continuar...}"
        echo ""
        read -p "${mensagem} "
    }
fi

# Carrega config
HOOKS_DIR="$(cd "$(dirname "$0")" && pwd)"
if [ -f "$HOOKS_DIR/modules/config.sh" ]; then
    source "$HOOKS_DIR/modules/config.sh" 2>/dev/null
fi

# ============================================
# BANNER INICIAL
# ============================================

clear

echo ""
echo "===================================================================="
echo "                                                                    "
echo "  ** TESTE INTERATIVO DOS HOOKS **                                 "
echo "                                                                    "
echo "  Este script demonstra como os hooks funcionam                    "
echo "  sem fazer commits reais.                                         "
echo "                                                                    "
echo "===================================================================="
echo ""

# Mostra status de cores
if [ "$SUPORTA_CORES" = true ]; then
    echo -e "${GREEN}[OK]${NC} Terminal suporta cores ANSI" >&2
else
    echo "[INFO] Terminal em modo texto simples (sem cores)"
fi
echo ""

# ============================================
# MENU PRINCIPAL
# ============================================

menu_principal() {
    echo ""
    echo "ESCOLHA O QUE DESEJA TESTAR:"
    echo ""
    echo "  1 - Testar UI/UX (cores, titulos, mensagens)"
    echo "  2 - Testar Menu de Tipos de Commit"
    echo "  3 - Testar Validacao de CSV"
    echo "  4 - Testar Validacao de Markdown"
    echo "  5 - Simular Fluxo Completo de Commit"
    echo "  6 - Testar Deteccao de Tamanho de Arquivo"
    echo "  7 - Ver Exemplo de Commit Real (instrucoes)"
    echo "  8 - Sair"
    echo ""
    read -p "Digite o numero (1-8): " escolha

    case $escolha in
        1) testar_ui ;;
        2) testar_tipos_commit ;;
        3) testar_validacao_csv ;;
        4) testar_validacao_markdown ;;
        5) simular_fluxo_completo ;;
        6) testar_tamanho_arquivo ;;
        7) instrucoes_commit_real ;;
        8) sair ;;
        *) 
            error "Opcao invalida!"
            menu_principal
            ;;
    esac
}

# ============================================
# TESTE 1: UI/UX
# ============================================

testar_ui() {
    clear
    titulo "TESTE DE UI/UX"
    
    echo ""
    subtitulo "Cores e icones disponiveis:"
    echo ""
    
    success "Mensagem de sucesso"
    error "Mensagem de erro"
    warning "Mensagem de aviso"
    info "Mensagem informativa"
    destaque "Mensagem destacada"
    
    echo ""
    subtitulo "Linhas decorativas:"
    echo ""
    
    linha
    echo "Linha normal"
    linha
    
    echo ""
    linha_fina
    echo "Linha fina"
    linha_fina
    
    echo ""
    subtitulo "Formatacao de tamanhos:"
    echo ""
    
    echo "50 bytes = $(human_readable 50)"
    echo "5 KB = $(human_readable 5120)"
    echo "10 MB = $(human_readable 10485760)"
    echo "2 GB = $(human_readable 2147483648)"
    
    echo ""
    info "Status de cores: SUPORTA_CORES=$SUPORTA_CORES"
    info "TERM=$TERM"
    info "OSTYPE=$OSTYPE"
    
    pause
    menu_principal
}

# ============================================
# TESTE 2: TIPOS DE COMMIT
# ============================================

testar_tipos_commit() {
    clear
    titulo "TIPOS DE COMMIT"
    
    info "Estes sao os 7 tipos alinhados com CONTRIBUTING.md:"
    echo ""
    
    if [ -n "${TIPOS_COMMIT}" ]; then
        local contador=1
        for item in "${TIPOS_COMMIT[@]}"; do
            local tipo=$(echo "$item" | cut -d':' -f1)
            local descricao=$(echo "$item" | cut -d':' -f2)
            if [ "$SUPORTA_CORES" = true ]; then
                echo -e "  ${BOLD}${contador}${NC}. ${CYAN}${tipo}${NC} - ${descricao}"
            else
                echo "  ${contador}. ${tipo} - ${descricao}"
            fi
            ((contador++))
        done
    else
        warning "TIPOS_COMMIT nao foi carregado do config.sh"
        echo ""
        echo "  1. dados - Adicionar ou atualizar ficheiros em data/"
        echo "  2. limpeza - Scripts ou alteracoes em data/2-clean/"
        echo "  3. script - Adicionar ou modificar scripts em scripts/"
        echo "  4. docs - Alteracoes em arquivos .md"
        echo "  5. fix - Correcao de erros"
        echo "  6. entrega - Mover ficheiros para data/3-delivery/"
        echo "  7. feat - Nova funcionalidade ou melhoria"
    fi
    
    echo ""
    info "Durante um commit, voce escolhe um numero e o hook monta a mensagem."
    echo ""
    
    subtitulo "Exemplo de uso real:"
    echo ""
    echo "Voce escolhe: 1 (dados)"
    echo "Hook pergunta ID: DP-012"
    echo "Hook pergunta escopo: pipeline (opcional)"
    echo "Hook pergunta resumo: Adiciona dataset INE populacao 2024"
    echo ""
    echo "Resultado:"
    if [ "$SUPORTA_CORES" = true ]; then
        echo -e "${GREEN}dados(pipeline): Adiciona dataset INE populacao 2024${NC}"
    else
        echo "dados(pipeline): Adiciona dataset INE populacao 2024"
    fi
    
    pause
    menu_principal
}

# ============================================
# TESTE 3: VALIDAÇÃO CSV
# ============================================

testar_validacao_csv() {
    clear
    titulo "VALIDACAO DE CSV"
    
    info "Criando arquivo CSV de teste..."
    
    # Cria diretório de teste
    mkdir -p /tmp/hooks-test
    
    echo ""
    subtitulo "TESTE 1: CSV Correto"
    echo ""
    
    # CSV correto
    cat > /tmp/hooks-test/correto.csv << 'EOF'
year;nationality;resident_count
2024;Brazil;400000
2024;Ukraine;50000
EOF
    
    success "Criado: correto.csv"
    echo "  Separador: ;"
    echo "  Encoding: UTF-8"
    echo "  Cabecalho: snake_case, sem acentos"
    echo ""
    
    # Testa com tech-validator se existir
    if [ -f "$HOOKS_DIR/modules/tech-validator.sh" ]; then
        source "$HOOKS_DIR/modules/tech-validator.sh"
        validar_csv "/tmp/hooks-test/correto.csv"
    else
        success "Validacao: CSV esta em formato correto!"
    fi
    
    echo ""
    pause
    
    echo ""
    subtitulo "TESTE 2: CSV Incorreto (virgula em vez de ponto e virgula)"
    echo ""
    
    # CSV incorreto
    cat > /tmp/hooks-test/incorreto.csv << 'EOF'
year,nationality,resident_count
2024,Brazil,400000
EOF
    
    warning "Criado: incorreto.csv"
    echo "  Separador: , (ERRADO, deveria ser ;)"
    echo ""
    
    if [ -f "$HOOKS_DIR/modules/tech-validator.sh" ]; then
        validar_csv "/tmp/hooks-test/incorreto.csv"
    else
        error "Problema detectado: separador incorreto!"
    fi
    
    echo ""
    pause
    
    echo ""
    subtitulo "TESTE 3: CSV com acentos no cabecalho"
    echo ""
    
    cat > /tmp/hooks-test/acentos.csv << 'EOF'
ano;nacionalidade;população
2024;Brasil;400000
EOF
    
    warning "Criado: acentos.csv"
    echo "  Cabecalho: ano, nacionalidade, populacao (TEM ACENTOS)"
    echo ""
    
    if [ -f "$HOOKS_DIR/modules/tech-validator.sh" ]; then
        validar_csv "/tmp/hooks-test/acentos.csv"
    else
        error "Problema detectado: cabecalho com acentos!"
    fi
    
    # Limpa
    rm -rf /tmp/hooks-test
    
    pause
    menu_principal
}

# ============================================
# TESTE 4: VALIDAÇÃO MARKDOWN
# ============================================

testar_validacao_markdown() {
    clear
    titulo "VALIDACAO DE MARKDOWN"
    
    info "Criando arquivos Markdown de teste..."
    
    mkdir -p /tmp/hooks-test
    
    echo ""
    subtitulo "TESTE 1: Markdown Correto"
    echo ""
    
    cat > /tmp/hooks-test/correto.md << 'EOF'
# Titulo Correto

Este e um documento bem formatado.

## Tabela Correta

| Nome | Idade |
|------|-------|
| Joao | 30    |
| Maria | 25   |
EOF
    
    success "Criado: correto.md"
    echo "  Titulo: # Titulo (com espaco)"
    echo "  Tabela: tem linha separadora |---|"
    echo ""
    
    if [ -f "$HOOKS_DIR/modules/tech-validator.sh" ]; then
        source "$HOOKS_DIR/modules/tech-validator.sh"
        validar_md "/tmp/hooks-test/correto.md"
    else
        success "Validacao: Markdown esta correto!"
    fi
    
    echo ""
    pause
    
    echo ""
    subtitulo "TESTE 2: Titulo sem espaco"
    echo ""
    
    cat > /tmp/hooks-test/titulo-errado.md << 'EOF'
#TituloSemEspaco

Conteudo aqui.
EOF
    
    warning "Criado: titulo-errado.md"
    echo "  Titulo: #TituloSemEspaco (SEM ESPACO)"
    echo ""
    
    if [ -f "$HOOKS_DIR/modules/tech-validator.sh" ]; then
        validar_md "/tmp/hooks-test/titulo-errado.md"
    else
        error "Problema detectado: titulo sem espaco apos #!"
    fi
    
    echo ""
    pause
    
    echo ""
    subtitulo "TESTE 3: Tabela sem separador"
    echo ""
    
    cat > /tmp/hooks-test/tabela-errada.md << 'EOF'
# Titulo

| Nome | Idade |
| Joao | 30    |
| Maria | 25   |
EOF
    
    warning "Criado: tabela-errada.md"
    echo "  Tabela: faltando linha |---|"
    echo ""
    
    if [ -f "$HOOKS_DIR/modules/tech-validator.sh" ]; then
        validar_md "/tmp/hooks-test/tabela-errada.md"
    else
        error "Problema detectado: tabela sem separador!"
    fi
    
    rm -rf /tmp/hooks-test
    
    pause
    menu_principal
}

# ============================================
# TESTE 5: SIMULAR FLUXO COMPLETO
# ============================================

simular_fluxo_completo() {
    clear
    titulo "SIMULACAO DE FLUXO COMPLETO"
    
    info "Vamos simular um commit passo a passo (sem fazer commit real)."
    echo ""
    
    pause
    
    # Passo 1: Tipo
    clear
    titulo "PASSO 1/4: TIPO DE COMMIT"
    
    echo "  1. dados - Adicionar ou atualizar ficheiros em data/"
    echo "  2. limpeza - Scripts ou alteracoes em data/2-clean/"
    echo "  3. script - Adicionar ou modificar scripts em scripts/"
    echo "  4. docs - Alteracoes em arquivos .md"
    echo "  5. fix - Correcao de erros"
    echo "  6. entrega - Mover ficheiros para data/3-delivery/"
    echo "  7. feat - Nova funcionalidade ou melhoria"
    echo ""
    read -p "Digite o numero (1-7): " tipo_num
    
    if [[ ! "$tipo_num" =~ ^[1-7]$ ]]; then
        error "Numero invalido!"
        pause
        menu_principal
        return
    fi
    
    local tipos=("dados" "limpeza" "script" "docs" "fix" "entrega" "feat")
    local tipo_escolhido="${tipos[$((tipo_num-1))]}"
    success "Tipo escolhido: ${tipo_escolhido}"
    pause
    
    # Passo 2: ID
    clear
    titulo "PASSO 2/4: ID DA TAREFA"
    
    info "Codigo da tarefa no formato CRISP-DM"
    echo "  Exemplos: DP-012, BU-001, DU-005"
    echo ""
    read -p "Digite o ID (ou ENTER para pular): " id_tarefa
    
    if [ -n "$id_tarefa" ]; then
        success "ID registrado: ${id_tarefa}"
    else
        warning "ID pulado"
    fi
    pause
    
    # Passo 3: Escopo
    clear
    titulo "PASSO 3/4: ESCOPO"
    
    info "Parte do projeto afetada"
    echo "  Exemplos: dados, pipeline, api, frontend"
    echo ""
    read -p "Digite o escopo (ou ENTER para pular): " escopo
    
    if [ -n "$escopo" ]; then
        success "Escopo definido: ${escopo}"
    else
        warning "Escopo pulado"
    fi
    pause
    
    # Passo 4: Resumo
    clear
    titulo "PASSO 4/4: RESUMO"
    
    info "Frase CURTA descrevendo O QUE foi feito (max 72 caracteres)"
    echo "  Use verbos no presente: 'Adiciona', 'Corrige', 'Remove'"
    echo ""
    read -p "Digite o resumo: " resumo
    
    if [ -z "$resumo" ]; then
        error "Resumo e obrigatorio!"
        pause
        menu_principal
        return
    fi
    
    local tamanho=${#resumo}
    if [ $tamanho -gt 72 ]; then
        warning "Resumo com $tamanho caracteres (max 72)"
    else
        success "Resumo valido (${tamanho} caracteres)"
    fi
    pause
    
    # Monta mensagem
    clear
    titulo "REVISAO FINAL"
    
    local mensagem="${tipo_escolhido}"
    if [ -n "$escopo" ]; then
        mensagem="${mensagem}(${escopo})"
    fi
    mensagem="${mensagem}: ${resumo}"
    
    echo ""
    linha
    echo "MENSAGEM DE COMMIT:"
    linha
    if [ "$SUPORTA_CORES" = true ]; then
        echo -e "${CYAN}${mensagem}${NC}"
    else
        echo "${mensagem}"
    fi
    linha
    echo ""
    
    success "Esta seria a mensagem do seu commit!"
    echo ""
    info "No commit real, voce ainda poderia:"
    echo "  - Adicionar corpo detalhado (multiplas linhas)"
    echo "  - Revisar no editor antes de confirmar"
    echo "  - Gerar template de PR automaticamente"
    
    pause
    menu_principal
}

# ============================================
# TESTE 6: TAMANHO DE ARQUIVO
# ============================================

testar_tamanho_arquivo() {
    clear
    titulo "DETECCAO DE TAMANHO DE ARQUIVO"
    
    info "Testando deteccao de tamanho em diferentes sistemas operacionais..."
    echo ""
    
    subtitulo "Sistema Operacional Detectado:"
    echo "  OSTYPE: ${OSTYPE}"
    
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "  Sistema: macOS"
        echo "  Comando: stat -f%z"
    elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" || "$OSTYPE" == "win32" ]]; then
        echo "  Sistema: Windows (Git Bash)"
        echo "  Comando: stat -c%s"
    else
        echo "  Sistema: Linux"
        echo "  Comando: stat -c%s"
    fi
    
    echo ""
    subtitulo "Criando arquivos de teste..."
    
    mkdir -p /tmp/hooks-test
    
    # Arquivo pequeno
    dd if=/dev/zero of=/tmp/hooks-test/pequeno.txt bs=1K count=10 2>/dev/null
    success "Criado: pequeno.txt (10 KB)"
    
    # Arquivo médio
    dd if=/dev/zero of=/tmp/hooks-test/medio.txt bs=1M count=5 2>/dev/null
    success "Criado: medio.txt (5 MB)"
    
    # Arquivo grande (simulado)
    echo ""
    info "Simulando arquivo de 60 MB (acima do limite de 50MB)..."
    warning "Este arquivo geraria um AVISO para usar Git LFS"
    
    echo ""
    info "Simulando arquivo de 110 MB (acima do limite de 100MB)..."
    error "Este arquivo BLOQUEARIA o commit!"
    echo "  Sugestoes mostradas:"
    echo "    1. Usar Git LFS"
    echo "    2. Adicionar ao .gitignore"
    echo "    3. Dividir arquivo"
    
    rm -rf /tmp/hooks-test
    
    pause
    menu_principal
}

# ============================================
# INSTRUÇÕES COMMIT REAL
# ============================================

instrucoes_commit_real() {
    clear
    titulo "COMO FAZER UM COMMIT REAL"
    
    info "Para testar os hooks de verdade, siga estes passos:"
    echo ""
    
    subtitulo "PASSO 1: Crie um arquivo de teste"
    echo ""
    echo "  echo \"Teste\" > teste.txt"
    echo ""
    
    subtitulo "PASSO 2: Adicione ao stage"
    echo ""
    echo "  git add teste.txt"
    echo ""
    
    subtitulo "PASSO 3: Faca o commit"
    echo ""
    echo "  git commit"
    echo ""
    info "Neste momento, o hook prepare-commit-msg sera executado!"
    echo ""
    
    subtitulo "O QUE VAI ACONTECER:"
    echo ""
    echo "  1. Analise do arquivo teste.txt"
    echo "  2. Validacoes (se for CSV/MD)"
    echo "  3. Pergunta tipo de commit (1-7)"
    echo "  4. Pergunta ID da tarefa (opcional)"
    echo "  5. Pergunta escopo (opcional)"
    echo "  6. Pergunta resumo (obrigatorio)"
    echo "  7. Pergunta corpo (opcional)"
    echo "  8. Mostra revisao final"
    echo "  9. Pergunta se quer revisar manualmente"
    echo " 10. Cria o commit!"
    echo ""
    
    subtitulo "PARA DESFAZER O COMMIT DE TESTE:"
    echo ""
    echo "  git reset HEAD~1  (volta 1 commit, mantem arquivo)"
    echo "  rm teste.txt      (remove arquivo de teste)"
    echo ""
    
    warning "IMPORTANTE: Este e um commit REAL no seu repositorio!"
    info "Use apenas para testes em branch separada."
    
    pause
    menu_principal
}

# ============================================
# SAIR
# ============================================

sair() {
    clear
    echo ""
    success "Obrigado por testar os hooks!"
    echo ""
    info "Para usar de verdade:"
    echo "  git add ."
    echo "  git commit"
    echo ""
    info "Para ver os fluxos detalhados:"
    echo "  cat .hooks/FLUXO-COMMIT.md"
    echo "  cat .hooks/FLUXO-PR.md"
    echo ""
    exit 0
}

# ============================================
# EXECUÇÃO
# ============================================

menu_principal
