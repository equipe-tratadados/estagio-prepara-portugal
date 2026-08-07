# Documentação de Entrega — Dados SEF/AIMA para o Dashboard de Imigração
## **Parte 1 de [4] — 3 arquivos**
**Guia de Integração e Dicionário de Dados**

Este documento serve como guia de suporte para o Grupo 2 no desenvolvimento do Dashboard de Imigração. Contém as especificações técnicas, limitações conhecidas e a estrutura de colunas para os **3 ficheiros** de dados tratados incluídos nesta entrega.

---

## Resumo
* **Origem dos Dados:** SEF (RIFA, 2015-2022) e AIMA (RMA, 2023-2024).
* **Formatos Comuns:** CSV, separador ponto e vírgula (`;`), codificação `UTF-8 sem BOM`.
* **Objetivo:** Alimentar os painéis de evolução temporal e distribuição demográfica da população estrangeira residente em Portugal.
* **Pergunta:** Resposta a pergunta 1, Subtema 1. 

---

## Detalhe dos Ficheiros

### 1. `residents_permits_nationality_and_gender_2015_2024.csv`
**Descrição:** Dataset combinado de residentes estrangeiros e autorizações concedidas em Portugal, segregado por nacionalidade e género, abrangendo o período de 2015 a 2024. Reúne o histórico do SEF (RIFA, 2015-2022) e da AIMA (RMA, 2023-2024).

#### Especificações Técnicas
* **Formato:** CSV | **Separador:** `;` | **Codificação:** UTF-8 sem BOM | **Decimais:** Ponto (`.`)
* **Volume:** 3.760 linhas (Formato longo: uma linha por ano/nacionalidade/género)
* **Identificadores de Controle:** Fontes: `F001 + F002` | Dados Id: `D111`

#### Dicionário de Colunas
| Coluna | Tipo | Descrição / Valores Possíveis |
| :--- | :--- | :--- |
| `year` | Inteiro | Ano de referência (2015 a 2024). |
| `nationality` | Texto | Nome da nacionalidade (padronizada via script). |
| `gender` | Texto | Género (`Masculino` / `Feminino`). |
| `permits_granted` | Inteiro | Número de autorizações de residência concedidas no respetivo ano. |
| `resident_count` | Inteiro | Stock total de população residente ativa no final do ano. |
| `source_id` | Texto | Código da fonte original no ficheiro (`F001` = SEF / `F002` = AIMA). |
| `source` | Texto | Identificação por extenso da fonte original (`SEF + AIMA — combinado`). |

#### Limitações & Avisos Importantes
* **Padronização:** A nomenclatura de todas as nacionalidades foi uniformizada via script automatizado para evitar duplicados por grafia.
* **Granularidade:** Não inclui dados de faixas etárias, motivos de concessão de residência ou distribuição geográfica.
* **Alerta de Inconsistência de Revisão:** O indicador agregado de população residente foi revisto pela AIMA entre o RMA 2023 e o RMA 2024 (ver Ficheiro 3). **Atenção:** Não está confirmado se esta revisão se propaga a este ficheiro ao nível detalhado de nacionalidade/género. Os valores de 2023 aqui presentes foram extraídos diretamente do RMA 2023 (D022), sem ajustes retroativos.

**Responsável:** Tabata Zardi (coleta e limpeza)

---

### 2. `series_resident_population_evolution_1980_2024.csv`
**Descrição:** Série mestra consolidada de evolução da população estrangeira residente em Portugal de 1980 a 2024. Para garantir a máxima precisão, foi utilizado para cada ano o valor mais recente e atualizado disponível (AIMA RMA 2024 sempre que há cobertura; RMA 2023 nos restantes casos).

#### Especificações Técnicas
* **Formato:** CSV | **Separador:** `;` | **Codificação:** UTF-8 sem BOM
* **Volume:** 45 linhas (um registo por ano, de 1980 a 2024)
* **Identificadores de Controle:** Fonte Id: `F002` | Report Id: `R001` (RMA 2023) e `R002` (RMA 2024)

#### Dicionário de Colunas
| Coluna | Tipo | Descrição |
| :--- | :--- | :--- |
| `year` | Inteiro | Ano de referência (1980 a 2024). |
| `resident_count` | Inteiro | População residente total calculada para a série mestra. |
| `report_id` | Texto | `R001` (RMA 2023) ou `R002` (RMA 2024). Identifica o dataset/relatório de origem do valor (Não confundir com o ID da instituição). |
| `source_id` | Texto | Identificador da instituição responsável (`F002` para AIMA). |
| `revised` | Booleano | `True` para anos que registaram alterações face à versão do relatório anterior (aplica-se a 2017-2023); `False` onde não há histórico comparativo. |
| `difference_absolute` | Inteiro | Cálculo da diferença: $RMA2024 - RMA2023$ (apenas nos anos em que ambas as versões estão disponíveis). |
| `methodology_break` | Booleano | `True` a partir do ano de 2024, indicando uma quebra metodológica profunda na contagem oficial. |

#### Limitações & Avisos Metodológicos
* **Dados Históricos (1980-2016):** Não possuem dados de revisão disponíveis (a cobertura do RMA 2024 só se inicia em 2017). Para estes anos, assume-se a classificação **"sem revisão conhecida"**, e não "confirmado sem revisão".
* **Quebra Metodológica (2024):** A partir de 2024 (`methodology_break = True`), o RMA 2024 passou a incluir no stock de residentes: beneficiários de Proteção Temporária, processos de Manifestação de Interesse já atendidos mas sem título emitido, e renovações pendentes já pagas — além dos titulares habituais de título válido.
* **Magnitude do Desvio:** A revisão dos anos de 2022 e 2023 é de grande magnitude (+27% e +25%, respetivamente). Para o detalhe analítico ano a ano, utilize o Ficheiro 3.

**Responsável:** Tabata Zardi (coleta e limpeza)

---

### 3. `comparison_rma2023_rma2024.csv`
**Descrição:** Ficheiro de referência, controlo técnico e auditoria. Apresenta lado a lado as duas versões do indicador de população residente para monitorizar a proveniência e o impacto real das revisões feitas pela AIMA.
* **🛑 Regra de Visualização:** **NÃO utilizar este ficheiro diretamente no gráfico principal do dashboard.** A série temporal correta e contínua para gráficos está no **Ficheiro 2**.

#### Especificações Técnicas
* **Formato:** CSV | **Separador:** `;` | **Codificação:** UTF-8 sem BOM
* **Volume:** 45 linhas (1980-2024)
* **Identificadores de Controle:** Fonte Id: `F002` | Report Id: `R001` e `R002`

#### Dicionário de Colunas
| Coluna | Tipo | Descrição |
| :--- | :--- | :--- |
| `year` | Inteiro | Ano de referência (1980 a 2024). |
| `resident_count_rma_2023` | Inteiro | Volume de população residente segundo o relatório RMA 2023 (nulo se o relatório não cobrir o ano). |
| `resident_count_rma_2024` | Inteiro | Volume de população residente segundo o relatório RMA 2024 (nulo se o relatório não cobrir o ano). |
| `difference_absolute` | Inteiro | Desvio absoluto entre relatórios ($RMA2024 - RMA2023$). Mede a revisão e não o crescimento populacional. |
| `difference_percentual` | Decimal | Variação percentual relativa da revisão entre as duas versões. |
| `material_revision_5pct` | Booleano | `True` sempre que a variação percentual absoluta for $> 5\%$ (atualmente verificado em 2022 e 2023). |
| `notes` | Texto | Notas explicativas sobre a causa da revisão, referenciando o Sumário Executivo do RMA 2024 (Estrutura de Missão / RCM 87/2024). |
| `source_id` | Texto | Código da instituição original no ficheiro (`F002`). |
| `source` | Texto | Nome da entidade por extenso (`AIMA - Agência para a Integração, Migrações e Asilo`). |

#### Limitações Conhecidas
* Destina-se exclusivamente a consultas pontuais, tooltips de contexto ou tabelas de auditoria do dashboard.
* Anos que não tenham dados em ambos os relatórios apresentarão valores nulos (`null`/`NaN`) na coluna em falta.

**Responsável:** Tabata Zardi (coleta e limpeza)

---

### 4. `rma_2024_annex_foreign_population_by_municipality_2024.csv`

**Descrição:** Distribuição da população estrangeira residente por concelho, em Portugal, referente ao ano de 2024. Este conjunto de dados foi extraído diretamente do Anexo do Relatório de Migrações e Asilo (RMA) 2024 da AIMA.

#### Especificações Técnicas

* **Formato:** CSV | **Separador:** `;` | **Codificação:** UTF-8
* **Volume:** 308 linhas (um registo por concelho)
* **Identificadores de Controlo:** Fonte Id: `F002` | Dados Id: `D025`

#### Dicionário de Colunas

| Coluna | Tipo | Descrição |
| --- | --- | --- |
| `district` | Texto | Nome do distrito ao qual o concelho pertence. |
| `municipality` | Texto | Nome do concelho (município) de referência. |
| `resident_foreign_population` | Inteiro | Volume total de população estrangeira residente no concelho no final de 2024. |
| `source_id` | Texto | Código da fonte no ficheiro (`F002`). |
| `source` | Texto | Nome da fonte por extenso (`AIMA - Agência para a Integração, Migrações e Asilo`). |

#### Limitações e Avisos Importantes

* **Elevada Agregação:** O ficheiro disponibiliza apenas dados agregados por concelho. Não existe qualquer nível de desagregação por nacionalidade de origem, género ou faixa etária.
* **Falta de Evolução Temporal:** O dataset representa uma fotografia estática do ano de 2024, não existindo uma série histórica comparável integrada neste ficheiro.

**Responsável:** Tabata Zardi (coleta e limpeza)

---
*Documento preparado e validado para envio à equipe de visualização.*