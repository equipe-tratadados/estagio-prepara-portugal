# Contributing - Como Trabalhar Neste Repositório

Guia de trabalho para membros do Grupo 1 — Coleta e Tratamento de Dados.

---

## Índice

1. [Estrutura do repositório](#estrutura-do-repositorio)
2. [Branches](#branches)
3. [Commits](#commits)
4. [Tasks e IDs](#tasks-e-ids)
5. [Pull Requests](#pull-requests)
6. [Fluxo de trabalho](#fluxo-de-trabalho)
7. [Padrão de arquivos CSV](#padrao-de-arquivos-csv)
8. [Regras gerais](#regras-gerais)
9. [Mais Detalhes](#mais-detalhes)

---

>### Antes de Começar:
>
>Confirme se consegues acessar o [novo Repositório](https://github.com/equipe-tratadados/estagio-prepara-portugal) e o [Notion](https://app.notion.com/p/Grupo-1-Coleta-e-Tratamento-de-Dados-3733ffc30f5b804c960feeaa5c97ec45?pvs=18) do Grupo 1 
>
>Caso contrário entre em contato com a líder do grupo para conferir se houve algum erro no partilhamento do acesso.

## <a name="estrutura-do-repositorio"></a>Estrutura do repositório

```
repositorio/
│
├── data/
│   ├── 1-raw/          ← dados originais, tal como chegam da fonte (nunca editar)
│   ├── 2-clean/        ← dados em tratamento
│   ├── 3-delivery/     ← CSVs validados e prontos a entregar
│   └── metadata/
│
├── scripts/
│   ├── coleta/         ← scripts de recolha de dados
│   └── limpeza/        ← scripts de tratamento e padronização
│
├── docs/
│   ├── biblioteca.md   ← catálogo de fontes identificadas
│   ├── log.md          ← registo de cada ficheiro descarregado
│   └── dicionario.md   ← descrição dos datasets entregues
│
├── notebooks/          ← exploração e prototipagem
├── reports/            ← relatórios de análise e de validação dos dados
│   ├── analise-exploratoria/
│   └── validacao/
│
├── CONTRIBUTING.md     ← este ficheiro
└── README.md           ← "página inicial" do repositório
```

**Regra fundamental:** nunca editar ficheiros em `data/1-raw/`. Os dados originais são imutáveis.

---

## <a name="branches"></a>Branches

Cada tarefa ou conjunto de alterações relacionadas deve ter a sua própria branch. Nunca trabalhar diretamente em `main`.

### Convenção de nomes

| Tipo de trabalho | Prefixo | Exemplo |
| --- | --- | --- |
| Adicionar dados novos | `dados/` | `dados/ine-populacao-2024` |
| Limpeza de um ficheiro | `limpeza/` | `limpeza/ine-populacao-2024` |
| Atualizar documentação | `docs/` | `docs/contributing` |
| Correção rápida | `fix/` | `fix/encoding-csv-ine` |

### Fluxo básico

```bash
# 1. Criar e mudar para a nova branch
git checkout -b dados/nome-do-dataset

# 2. Fazer o trabalho e commitar
git add .
git commit -m "[dados] adiciona dataset INE população 2024"

# 3. Enviar para o GitHub
git push origin dados/nome-do-dataset

# 4. Abrir Pull Request para main no GitHub
```

Antes de fazer merge em `main`, pelo menos um membro da equipa deve rever o Pull Request.

---

## <a name="commits"></a>Commits

### Formato
 
```
tipo: descrição curta no presente
```
 
A descrição deve ser curta e clara, referenciar a task relacionada quando relevante.
 
### Tipos disponíveis
 
| Tipo | Quando usar |
| --- | --- |
| `dados` | Adicionar ou atualizar ficheiros em `data/` |
| `limpeza` | Scripts ou alterações em `data/2-clean/` |
| `script` | Adicionar ou modificar scripts em `scripts/` |
| `docs` | Alterações em arquivos `.md` como `docs/`, `reports/`, `README.md` ou `CONTRIBUTING.md` |
| `fix` | Correção de erros |
| `entrega` | Mover ficheiros para `data/3-delivery/` |
 
### Exemplos
 
```
dados: adiciona dataset INE população por município 2024
limpeza: remove linhas duplicadas no ficheiro PORDATA
script: cria script de download automático INE
docs: atualiza log com download de 2024-06-05
fix: corrige encoding UTF-8 no CSV de saúde
entrega: move dataset emprego para 3-delivery
dados: DP-012 adiciona dataset INE população 2024
```
 
---

## <a name="tasks-e-ids"></a>Tasks e IDs

Os IDs das tasks são definidos pelo líder geral do projeto e seguem a estrutura CRISP-DM:

| Prefixo | Fase |
| --- | --- |
| `BU-` | Business Understanding |
| `DU-` | Data Understanding |
| `DP-` | Data Preparation |

Exemplo: `DP-012` — tarefa 12 da fase de Data Preparation.

O Grupo 1 **recebe** os IDs, não os cria. Ao referenciar uma task num commit ou Pull Request, incluir o ID no início da descrição quando relevante:

```
[dados] DP-012 adiciona dataset INE população 2024
```

---
 
## <a name="pull-requests"></a>Pull Requests
 
Antes de pedir review, garante que o teu trabalho está pronto. Ao abrir uma Pull Request no GitHub, o campo de descrição é preenchido automaticamente com um template, é só preencher os campos e marcar as caixas de seleção ou escrever "Não se aplica" à frente.
 
### Título
 
O título da PR deve seguir o mesmo formato dos commits:
 
```
tipo: descrição curta do que foi feito
```
 
Exemplos:
```
dados: adiciona dataset INE população por município 2024
limpeza: padroniza colunas do ficheiro PORDATA emprego
```
 
### Revisão
 
Pelo menos um membro da equipa deve aprovar a PR antes do merge em `main`. Quem revê deve verificar se o checklist foi preenchido e se os ficheiros estão conforme o padrão.
 
---

## <a name="fluxo-de-trabalho"></a>Fluxo de trabalho

> Em definição — a validar com a equipa.
> 

O fluxo semanal do Grupo 1 cobre as fases de Data Understanding, Data Preparation e Evaluation do CRISP-DM. 

---

## <a name="padrao-de-arquivos-csv"></a>Padrão de arquivos CSV

| Parâmetro | Valor a usar | O que significa  |
| --- | --- | --- |
| **Codificação (encoding)** | UTF-8 (sem BOM) | Garante que acentos e caracteres não viram símbolos estranhos |
| **Separador** | Ponto e vírgula `;` | É o que separa cada coluna dentro do ficheiro |
| **Decimais** | Ponto `.` (ex.: `1234.56`) | Números com casas decimais usam ponto, não vírgula |
| **Datas** | `AAAA-MM-DD` (ex.: `2024-03-15`) | Sempre ano-mês-dia, com 4 dígitos no ano |
| **Células vazias** | Deixar mesmo vazio | Não escrever "N/A", "null", "-" nem "sem dados" |
| **Nomes das colunas** | snake_case, em inglês, sem acentos | Tudo minúsculo, palavras ligadas por `_`, ex.: `resident_count` |
| **Extensão do ficheiro** | `.csv` | O tipo do ficheiro |

### ✅Exemplo de um CSV CORRETO

**Visto como tabela** (para se perceber bem cada coluna):

| year | nationality | resident_count | employment_rate | irs_contribution_eur |
| --- | --- | --- | --- | --- |
| 2024 | Brazil | 400000 | 0.62 | 1250.50 |

**Por dentro do ficheiro** (é assim que fica escrito, separado por `;`):

```
year;nationality;resident_count;employment_rate;irs_contribution_eur
2024;Brazil;400000;0.62;1250.50
```

## <a name="regras-gerais"></a>Regras gerais

- `data/1-raw/` é só de leitura, nunca editar, só adicionar.
- Atualizar sempre o `docs/log.md` após cada download.
- Atualizar o `docs/dicionario.md` antes de mover um dataset para `data/3-delivery/`.

## <a name="mais-detalhes"></a>Mais Detalhes

Para mais detalhe sobre as convenções de dados, consultar **[Documentação técnica](https://app.notion.com/p/Documenta-o-T-cnica-59c3ffc30f5b82989fe68156f65ac527?source=copy_link)** no Notion da equipe:

- `Padrão CSV` - regras completas de formato para ficheiros CSV
- `Padrão MD` - regras de escrita para ficheiros Markdown

