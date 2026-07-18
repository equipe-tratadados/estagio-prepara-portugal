# Documentação de Entrega — Dados INE/PORDATA para o Dashboard de Imigração
## **Parte 2 de [N] — 8 arquivos**
**Guia de Integração e Dicionário de Dados**

Este documento serve como guia de suporte para o Grupo 2 no desenvolvimento do Dashboard de Imigração. Contém as especificações técnicas, limitações conhecidas e a estrutura de colunas para os **8 ficheiros** de dados tratados incluídos nesta entrega.

---

## Resumo
* **Origem dos Dados:** Instituto Nacional de Estatística (INE) e Pordata.
* **Formatos Comuns:** CSV, separador ponto e vírgula (`;`), codificação `UTF-8`.
* **Objetivo:** Fornecer o contexto macroeconómico (PIB, saldo das administrações públicas) e indicadores demográficos complementares (taxa bruta de imigração e população estrangeira histórica) para cruzamento de dados.
* **Pergunta:** Resposta a pergunta 1, Subtema 1. 

---

## Detalhe dos Ficheiros

### 1. `portugal_gdp_quarterly_current_prices_1995_2026.csv`

**Descrição:** Série trimestral do PIB de Portugal a preços correntes, base 2021, abrangendo o período de 1995 a 2026. Extraído do indicador INE "PIB a preços correntes" (indOcorrCod=0013428).

#### Especificações Técnicas

* **Formato:** CSV | **Separador:** `;` | **Codificação:** UTF-8
* **Volume:** 125 linhas (um trimestre por linha, de 1995-Q1 a 2026-Q1)
* **Identificadores de Controlo:** Fonte Id: `F007` | Dados Id: `D066`

#### Dicionário de Colunas

| Coluna | Tipo | Descrição |
| --- | --- | --- |
| `year` | Inteiro | Ano de referência. |
| `quarter` | Texto | Trimestre de referência (ex: Q1, Q2). |
| `period` | Texto | Identificador do período composto. |
| `country` | Texto | País de referência (Portugal). |
| `gdp_million_eur` | Decimal | Valor do PIB em milhões de euros. |
| `source_id` | Texto | Código da fonte no ficheiro (`F007`). |
| `source` | Texto | Nome da fonte por extenso (`INE - Instituto Nacional de Estatística`). |
| `unit` | Texto | Unidade de medida utilizada. |
| `price_basis` | Texto | Ano-base dos preços (Base 2021). |
| `seasonal_adjusted` | Texto | Indicador de ajuste sazonal. |
| `notes` | Texto | Notas informativas adicionais. |

#### Limitações e Avisos Importantes

* **Sem Desagregação:** O PIB não é desagregado por nacionalidade dos trabalhadores. Qualquer correlação com a imigração terá de ser inferida entre séries independentes.
* **Ajuste Sazonal:** Os dados estão ajustados de sazonalidade, não representando os valores brutos trimestrais.
* **Mudança de Base:** Comparações com séries anteriores à Base 2021 requerem atenção metodológica.
* **Valores Nulos:** Existem 0 valores nulos no ficheiro.

**Responsável:** Antony Ferreira (coleta e limpeza)

---

### 2. `portugal_gdp_quarterly_yoy_growth_1996_2026.csv`

**Descrição:** Taxa de variação homóloga do PIB a preços correntes, base 2021, com periodicidade trimestral. Extraído do indicador INE (indOcorrCod=0013429).

#### Especificações Técnicas

* **Formato:** CSV | **Separador:** `;` | **Codificação:** UTF-8
* **Volume:** 121 linhas (um trimestre por linha, de 1996-Q1 a 2026-Q1)
* **Identificadores de Controlo:** Fonte Id: `F007` (corrigido de `FONTE-004`) | Dados Id: `D067`

#### Dicionário de Colunas

| Coluna | Tipo | Descrição |
| --- | --- | --- |
| `year` | Inteiro | Ano de referência. |
| `quarter` | Texto | Trimestre de referência. |
| `period` | Texto | Identificador do período. |
| `country` | Texto | País de referência. |
| `gdp_yoy_growth_pct` | Decimal | Taxa de variação homóloga do PIB em percentagem. |
| `source_id` | Texto | Código da fonte no ficheiro (`F007`). |
| `source` | Texto | Nome da fonte por extenso (`INE - Instituto Nacional de Estatística`). |
| `unit` | Texto | Unidade de medida (Percentagem). |
| `price_basis` | Texto | Ano-base dos preços. |
| `seasonal_adjusted` | Texto | Indicador de ajuste sazonal. |
| `notes` | Texto | Notas informativas adicionais. |

#### Limitações e Avisos Importantes

* **Sem Desagregação:** O PIB não é desagregado por nacionalidade dos trabalhadores.
* **Efeito da Inflação:** Sendo uma taxa a preços correntes, inclui o efeito da inflação e não reflete o crescimento real.
* **Início da Série:** A série começa apenas em 1996-Q1, uma vez que o ano de 1995 não tem valor por necessitar do ano anterior como base de cálculo.
* **Ajuste Sazonal:** Dados ajustados de sazonalidade.
* **Contexto Histórico:** Regista um crescimento mínimo de -14,5% (2020-Q2, impacto da COVID-19) e máximo de +17,2% (2021-Q2, recuperação pós-COVID), com um histórico de 18 trimestres em recessão.
* **Valores Nulos:** Existem 0 valores nulos no ficheiro.

**Responsável:** Antony Ferreira (coleta e limpeza)

---

### 3. `portugal_gdp_quarterly_chain_volume_1995_2026.csv`

**Descrição:** PIB em volume utilizando dados encadeados, base 2021, com periodicidade trimestral. Extraído do indicador INE (indOcorrCod=0013430).

#### Especificações Técnicas

* **Formato:** CSV | **Separador:** `;` | **Codificação:** UTF-8
* **Volume:** 125 linhas (um trimestre por linha, de 1995-Q1 a 2026-Q1)
* **Identificadores de Controlo:** Fonte Id: `F007` (adicionado, o ficheiro original não continha esta coluna) | Dados Id: `D068`

#### Dicionário de Colunas

| Coluna | Tipo | Descrição |
| --- | --- | --- |
| `year` | Inteiro | Ano de referência. |
| `quarter` | Texto | Trimestre de referência. |
| `period` | Texto | Identificador do período. |
| `country` | Texto | País de referência. |
| `gdp_chain_volume_million_eur` | Decimal | PIB em volume encadeado (milhões de euros). |
| `source_id` | Texto | Código da fonte no ficheiro (`F007`). |
| `source` | Texto | Nome da fonte por extenso (`INE - Instituto Nacional de Estatística`). |
| `unit` | Texto | Unidade de medida. |
| `price_basis` | Texto | Ano-base dos preços. |
| `seasonal_adjusted` | Texto | Indicador de ajuste sazonal. |
| `notes` | Texto | Notas informativas adicionais. |

#### Limitações e Avisos Importantes

* **Sem Desagregação:** O PIB não é desagregado por nacionalidade dos trabalhadores.
* **Crescimento Real:** O efeito da inflação foi removido através dos dados encadeados em volume, pelo que esta série não é diretamente comparável com a série de preços correntes (Ficheiro 1).
* **Ano de Referência:** Sendo o ano de referência 2021, os valores deste ano são os que convergem entre as duas séries.
* **Ajuste Sazonal:** Dados ajustados de sazonalidade.
* **Limites de Volume:** Volume mínimo registado de 39.408,786 M€ (1995-Q1) e máximo de 62.915,273 M€ (2026-Q1).
* **Valores Nulos:** Existem 0 valores nulos no ficheiro.

**Responsável:** Antony Ferreira (coleta e limpeza)

---

### 4. `portugal_gdp_quarterly_chain_volume_yoy_growth_1996_2026.csv`

**Descrição:** Taxa de variação homóloga do PIB em volume (dados encadeados), base 2021, trimestral. Extraído do indicador INE (indOcorrCod=0013431).

#### Especificações Técnicas

* **Formato:** CSV | **Separador:** `;` | **Codificação:** UTF-8
* **Volume:** 121 linhas (um trimestre por linha, de 1996-Q1 a 2026-Q1)
* **Identificadores de Controlo:** Fonte Id: `F007` | Dados Id: `D069`

#### Dicionário de Colunas

| Coluna | Tipo | Descrição |
| --- | --- | --- |
| `year` | Inteiro | Ano de referência. |
| `quarter` | Texto | Trimestre de referência. |
| `period` | Texto | Identificador do período. |
| `country` | Texto | País de referência. |
| `gdp_chain_vol_yoy_growth_pct` | Decimal | Taxa de variação homóloga real em percentagem. |
| `source_id` | Texto | Código da fonte no ficheiro (`F007`). |
| `source` | Texto | Nome da fonte por extenso (`INE - Instituto Nacional de Estatística`). |
| `unit` | Texto | Unidade de medida. |
| `price_basis` | Texto | Ano-base dos preços. |
| `seasonal_adjusted` | Texto | Indicador de ajuste sazonal. |
| `notes` | Texto | Notas informativas adicionais. |

#### Limitações e Avisos Importantes

* **Sem Desagregação:** O PIB não é desagregado por nacionalidade dos trabalhadores.
* **Taxa Real:** Representa o crescimento real, inviabilizando a comparação direta com a taxa nominal do Ficheiro 2.
* **Início da Série:** Começa em 1996-Q1 (o ano de 1995 requer o período anterior para o cálculo homólogo).
* **Ajuste Sazonal:** Dados ajustados de sazonalidade.
* **Contexto Histórico:** Apresenta um crescimento mínimo de -17,6% (2020-Q2, COVID-19) e máximo de +16,5% (2021-Q2, recuperação pós-COVID), acumulando 25 trimestres em recessão real.
* **Valores Nulos:** Existem 0 valores nulos no ficheiro.

**Responsável:** Antony Ferreira (coleta e limpeza)

---

### 5. `portugal_gdp_real_per_capita_yoy_growth_1996_2025.csv`

**Descrição:** Taxa de variação anual do PIB real per capita, base 2021, com periodicidade anual. Extraído do indicador INE (indOcorrCod=0013493).

#### Especificações Técnicas

* **Formato:** CSV | **Separador:** `;` | **Codificação:** UTF-8
* **Volume:** 30 linhas (um ano por linha, de 1996 a 2025)
* **Identificadores de Controlo:** Fonte Id: `F007` | Dados Id: `D070`

#### Dicionário de Colunas

| Coluna | Tipo | Descrição |
| --- | --- | --- |
| `year` | Inteiro | Ano de referência. |
| `country` | Texto | País de referência. |
| `gdp_real_pc_yoy_growth_pct` | Decimal | Variação anual do PIB real per capita em percentagem. |
| `source_id` | Texto | Código da fonte no ficheiro (`F007`). |
| `source` | Texto | Nome da fonte por extenso (`INE - Instituto Nacional de Estatística`). |
| `unit` | Texto | Unidade de medida. |
| `price_basis` | Texto | Ano-base dos preços. |
| `data_flag` | Texto | Sinalização/Aviso sobre o estado ou qualidade do dado. |
| `notes` | Texto | Notas informativas adicionais. |

#### Limitações e Avisos Importantes

* **Sem Desagregação:** O PIB não é desagregado por nacionalidade dos trabalhadores.
* **Alerta de Dados (2025):** O ano de 2025 apresenta a flag `nao_aplicavel`. É necessário confirmar a disponibilidade definitiva do dado com a fonte antes da sua utilização.
* **Alerta de Dados (2024):** O ano de 2024 apresenta a flag `coef_variacao_elevado`. Deve ser utilizado com especial cautela em análises estatísticas.
* **Granularidade:** Por se tratar de uma série anual, possui uma granularidade inferior aos conjuntos de dados trimestrais.
* **Contexto Histórico:** Mínimo de -8,5% (2020, COVID-19) e máximo de +6,4% (2022, recuperação pós-pandemia), registando 6 anos de crescimento negativo.
* **Valores Nulos:** Existem 0 valores nulos no ficheiro.

**Responsável:** Antony Ferreira (coleta e limpeza)

---

### 6. `portugal_gov_balance_pct_gdp_quarterly_1999_2026.csv`

**Descrição:** Saldo das administrações públicas expresso em percentagem do PIB, calculado no ano terminado no respetivo trimestre. Extraído do indicador INE (indOcorrCod=0009797).

#### Especificações Técnicas

* **Formato:** CSV | **Separador:** `;` | **Codificação:** UTF-8
* **Volume:** 105 linhas (um trimestre por linha, de 1999-Q4 a 2026-Q1)
* **Identificadores de Controlo:** Fonte Id: `F007` (corrigido de `FONTE-004`) | Dados Id: `D071`

#### Dicionário de Colunas

| Coluna | Tipo | Descrição |
| --- | --- | --- |
| `year` | Inteiro | Ano de referência. |
| `quarter` | Texto | Trimestre de referência. |
| `period` | Texto | Identificador do período. |
| `country` | Texto | País de referência. |
| `gov_balance_pct_gdp` | Decimal | Saldo das administrações públicas em percentagem do PIB. |
| `source_id` | Texto | Código da fonte no ficheiro (`F007`). |
| `source` | Texto | Nome da fonte por extenso (`INE - Instituto Nacional de Estatística`). |
| `unit` | Texto | Unidade de medida. |
| `data_flag` | Texto | Sinalização do estado do dado. |
| `notes` | Texto | Notas informativas adicionais. |

#### Limitações e Avisos Importantes

* **Sem Desagregação:** O PIB não é desagregado por nacionalidade dos trabalhadores.
* **Média Móvel (Rolling Year):** Cada valor representa o saldo acumulado nos 12 meses terminados no trimestre em questão, e não o saldo isolado desse trimestre específico.
* **Início da Série:** A série tem início em 1999-Q4, não cobrindo o período desde 1995.
* **Agregação Total:** Inclui o saldo de todas as Administrações Públicas, impossibilitando a separação entre receitas de IRS e contribuições para a Segurança Social.
* **Contexto Histórico:** O pior défice registado foi de -11,4% do PIB (2010-Q4, crise da dívida soberana) e o maior excedente fixou-se em +1,1% do PIB (2023-Q4). Acumula 88 trimestres em défice e 16 em excedente.
* **Valores Nulos:** Existem 0 valores nulos e o ficheiro encontra-se sem simbologias nos dados.

**Responsável:** Antony Ferreira (coleta e limpeza)

---

### 7. `portugal_gdp_annual_1960_2025.csv`

**Descrição:** Série anual histórica do PIB de Portugal a preços correntes, cobrindo o período de 1960 a 2025. Obtido através da Pordata (ficheiro original: `pordata_pib.xlsx`).

#### Especificações Técnicas

* **Formato:** CSV | **Separador:** `;` | **Codificação:** UTF-8
* **Volume:** 66 linhas (um ano por linha, de 1960 a 2025)
* **Identificadores de Controlo:** Fonte Id: `F009` | Dados Id: `D072`

#### Dicionário de Colunas

| Coluna | Tipo | Descrição |
| --- | --- | --- |
| `year` | Inteiro | Ano de referência. |
| `country` | Texto | País de referência. |
| `gdp_million_eur` | Decimal | Valor do PIB em milhões de euros. |
| `gdp_thousand_eur` | Decimal | Valor do PIB em milhares de euros. |
| `source_id` | Texto | Código da fonte no ficheiro (`F009`). |
| `source` | Texto | Nome da fonte por extenso (`Pordata`). |
| `unit` | Texto | Unidade de medida. |
| `price_basis` | Texto | Descrição da base de preços (Preços correntes). |
| `notes` | Texto | Notas informativas adicionais. |

#### Limitações e Avisos Importantes

* **Quebra Metodológica:** Os dados anteriores a 1995 seguem uma metodologia distinta, baseada nas Séries Longas do INE e do Banco de Portugal.
* **Dado Provisório:** O valor do ano de 2025 é provisório e encontra-se sujeito a revisões futuras.
* **Série Agregada:** Trata-se de uma série única para Portugal, sem qualquer desagregação por setor económico ou componente da despesa.
* **Preços Correntes:** Devido à ausência de um deflator nesta série, os valores não permitem uma comparação direta de crescimento real.
* **Valores Nulos:** Existem 0 valores nulos no ficheiro.

**Responsável:** Antony Ferreira (coleta e limpeza)

---

### 8. `pordata_foreign_resident_population_1960_2023.csv`

**Descrição:** Série histórica da população estrangeira residente em Portugal, discriminada por nacionalidade, entre os anos de 1960 e 2023. Obtido através da Pordata (ficheiro original: `pordata_populacao-estrangeira-com-estatuto-legal-de-residente-por-nacionalidades.xlsx`).

#### Especificações Técnicas

* **Formato:** CSV | **Separador:** `;` | **Codificação:** UTF-8
* **Identificadores de Controlo:** Fonte Id: `F009` | Dados Id: `D073`

#### Dicionário de Colunas

| Coluna | Tipo | Descrição |
| --- | --- | --- |
| `year` | Inteiro | Ano de referência. |
| `country` | Texto | País da nacionalidade de origem. |
| `resident_foreign_population` | Inteiro | Volume de população estrangeira residente com estatuto legal. |
| `source_id` | Texto | Código da fonte no ficheiro (`F009`). |
| `source` | Texto | Nome da fonte por extenso (`Pordata`). |

#### Limitações e Avisos Importantes

* **Quebra de Série:** Identificada uma quebra de série metodológica no ano de 2008.
* **Dados Incompletos (2023):** Os dados referentes ao ano de 2023 não foram disponibilizados para a totalidade dos países.
* **Escopo Limitado:** Não apresenta desagregação por motivo de concessão de residência ou por distribuição geográfica no território nacional.
* **Validação Pendente:** O total de linhas não foi totalmente confirmado no registo de origem. Recomenda-se verificar com a responsável pela limpeza antes de publicar ou utilizar em produção.

**Responsável:** Antony Ferreira (coleta) / Nubia Almeida (limpeza)

---
