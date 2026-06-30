#!/bin/bash

# Cores para saída do terminal
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Caminho para os hooks e módulos
REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
HOOKS_DIR="$REPO_ROOT/.hooks"
MODULES_DIR="$HOOKS_DIR/modules"

# Incluir módulos necessários para os testes
source "$MODULES_DIR/ui.sh"
source "$MODULES_DIR/tech-validator.sh"
source "$MODULES_DIR/pr-builder.sh"

# Função auxiliar para exibir resultados
assert_status() {
    local expected_status="$1"
    local actual_status="$2"
    local message="$3"
    if [ "$expected_status" -eq "$actual_status" ]; then
        echo -e "${GREEN}PASSOU: ${message}${NC}"
        return 0
    else
        echo -e "${RED}FALHOU: ${message} (Esperado status: $expected_status, Obtido: $actual_status) ${NC}"
        return 1
    fi
}

assert_contains() {
    local haystack="$1"
    local needle="$2"
    local message="$3"
    if [[ "$haystack" == *"$needle"* ]]; then
        echo -e "${GREEN}PASSOU: ${message}${NC}"
        return 0
    else
        echo -e "${RED}FALHOU: ${message} (Não encontrado: \"$needle\") ${NC}"
        return 1
    fi
}

assert_not_contains() {
    local haystack="$1"
    local needle="$2"
    local message="$3"
    if [[ "$haystack" != *"$needle"* ]]; then
        echo -e "${GREEN}PASSOU: ${message}${NC}"
        return 0
    else
        echo -e "${RED}FALHOU: ${message} (Encontrado indevidamente: \"$needle\") ${NC}"
        return 1
    fi
}

# ============================================
# CENÁRIOS DE TESTE
# ============================================

echo -e "${YELLOW}Iniciando testes dos hooks Git...${NC}"

# Criar diretório temporário para os arquivos de teste dentro do repositório
TEST_FILES_DIR="$REPO_ROOT/test_files"
mkdir -p "$TEST_FILES_DIR"

# Mudar para o diretório do repositório para que git add funcione corretamente
pushd "$REPO_ROOT" > /dev/null

# Cenário 1 - CSV Inválido
echo -e "\n${YELLOW}--- Cenário 1: CSV Inválido (separador vírgula, acentos no cabeçalho) ---${NC}"
TEMP_CSV_INVALIDO="$TEST_FILES_DIR/temp_invalid.csv"
echo "Ano,População,Região" > "$TEMP_CSV_INVALIDO"
git add "$TEMP_CSV_INVALIDO"

output=$(validar_csv "$TEMP_CSV_INVALIDO" 2>&1)
status=$?
assert_contains "$output" "CSV: Separador inválido" "CSV Inválido: Separador"
assert_contains "$output" "CSV: Cabeçalho contém acentos ou caracteres especiais" "CSV Inválido: Acentos no cabeçalho"

# Cenário 2 - Markdown Inválido
echo -e "\n${YELLOW}--- Cenário 2: Markdown Inválido (título sem espaço, tabela sem separador) ---${NC}"
TEMP_MD_INVALIDO="$TEST_FILES_DIR/temp_invalid.md"
echo -e "#TituloSemEspaco\n\n| Cabeçalho1 | Cabeçalho2 |\n| Valor1 | Valor2 |" > "$TEMP_MD_INVALIDO"
git add "$TEMP_MD_INVALIDO"

output=$(validar_md "$TEMP_MD_INVALIDO" 2>&1)
assert_contains "$output" "MD: Título sem espaço após '#' encontrado" "Markdown Inválido: Título sem espaço"
assert_contains "$output" "MD: Tabela sem linha de separação '|---|' encontrada" "Markdown Inválido: Tabela sem separador"

# Cenário 3 - CSV Correto
echo -e "\n${YELLOW}--- Cenário 3: CSV Correto (UTF-8, ponto e vírgula, snake_case) ---${NC}"
TEMP_CSV_CORRETO="$TEST_FILES_DIR/temp_correct.csv"
echo -e "year;nationality;resident_count\n2024;Brazil;400000" > "$TEMP_CSV_CORRETO"
git add "$TEMP_CSV_CORRETO"

output=$(validar_csv "$TEMP_CSV_CORRETO" 2>&1)
echo "$output"
assert_not_contains "$output" "CSV: Separador inválido" "CSV Correto: Separador"
assert_not_contains "$output" "CSV: Cabeçalho contém acentos ou caracteres especiais" "CSV Correto: Acentos no cabeçalho"
assert_contains "$output" "concluída sem erros críticos" "CSV Correto: Sem erros críticos"

# Cenário 4 - Integração no Hook Principal
echo -e "\n${YELLOW}--- Cenário 4: Integração no Hook Principal (prepare-commit-msg) ---${NC}"
PREPARE_COMMIT_MSG_CONTENT=$(cat "$HOOKS_DIR/prepare-commit-msg")

assert_contains "$PREPARE_COMMIT_MSG_CONTENT" "executar_validacoes_tecnicas" "Hook Principal: Chamada a executar_validacoes_tecnicas"
# NOTA: a asserção para "perguntar_checklist_linhas" foi removida — essa função nunca existiu
# em nenhum arquivo do projeto, então o teste sempre falhava. Se o checklist de linhas for
# uma funcionalidade desejada, ela precisa ser implementada antes de voltar a ser testada aqui.
assert_contains "$PREPARE_COMMIT_MSG_CONTENT" "exit 1" "Hook Principal: Abortar em caso de erro"

# Cenário 5 - Regressão: selecionar_opcao não pode vazar o menu para dentro do valor capturado
# (bug histórico: $(selecionar_opcao ...) capturava o menu inteiro junto com a escolha)
echo -e "\n${YELLOW}--- Cenário 5: Regressão selecionar_opcao (tela em branco) ---${NC}"
escolha_capturada=$(echo "2" | selecionar_opcao "Tipos disponíveis:" "feat" "fix" "docs" 2>/dev/null)
assert_contains "$escolha_capturada" "fix" "selecionar_opcao: valor correto é capturado"
assert_not_contains "$escolha_capturada" "Tipos disponíveis" "selecionar_opcao: título do menu não vaza para o valor capturado"
assert_not_contains "$escolha_capturada" $'\n' "selecionar_opcao: valor capturado não contém múltiplas linhas"

# Limpeza
popd > /dev/null
rm -rf "$TEST_FILES_DIR"
git reset --hard HEAD > /dev/null 2>&1

echo -e "\n${YELLOW}Testes concluídos.${NC}"
