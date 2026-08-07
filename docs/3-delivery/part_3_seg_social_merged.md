# Documentação de Entrega - Dados Segurança Social/MTSSS para o Dashboard de Imigração

## **Parte 3 de [4] - 3 ficheiros**
### Ficheiros para Visualização (3 ficheiros merged)

**Guia de Integração e Dicionário de Dados**

Este documento serve como guia de suporte para o Grupo 2 no desenvolvimento do Dashboard de Imigração. Contém as especificações técnicas, limitações conhecidas e a estrutura de colunas para os **3 ficheiros** de dados tratados incluídos nesta entrega (Segurança Social - F014).

---

## Resumo

- **Origem dos Dados:** Segurança Social / MTSSS (F014).
- **Formatos Comuns:** CSV, separador ponto e vírgula (`;`), codificação `UTF-8`.
- **Objetivo:** Quantificar a contribuição financeira dos imigrantes para a Segurança Social e as prestações sociais recebidas, por distrito e por perfil demográfico, com contexto do total de trabalhadores registados em Portugal.
- **Pergunta:** Resposta à Pergunta 1, Subtema 2. 
**Quanto pagaram os imigrantes à Segurança Social em cada ano entre 2015 e 2025, e quanto receberam em prestações sociais no mesmo período?**

---

## Relação entre Ficheiros e Como Utilizá-los no Looker Studio

Os três ficheiros foram desenhados para funcionar em conjunto via *data blending* no Looker Studio:

- **Ficheiro 1** é o ficheiro principal para responder à Pergunta 1 — contribuições vs. prestações por distrito e ano.
- **Ficheiro 2** fornece o detalhe demográfico (género e faixa etária), mas **não tem valores monetários** - essa é uma limitação da fonte original.
- **Ficheiro 3** é uma tabela de contexto para calcular o peso dos imigrantes no total de trabalhadores. **Não deve ser utilizado isoladamente** para responder à Pergunta 1.

---

## Detalhe dos Ficheiros

### 1. `ss_foreigners_contribution_benefit_by_district_2015_2025.csv`

**Descrição:** Dataset consolidado com contribuições pagas e prestações sociais recebidas por trabalhadores estrangeiros registados na Segurança Social, por distrito e ano, entre 2015 e 2025. Inclui contagem de contribuintes e beneficiários, novos registos anuais, e indicadores financeiros calculados. Resulta do merge de 5 ficheiros limpos provenientes do relatório *Pessoas Estrangeiras na Segurança Social* (F014).

#### Especificações Técnicas

- **Formato:** CSV | **Separador:** `;` | **Codificação:** UTF-8 | **Decimais:** Ponto (`.`)
- **Volume:** 231 linhas (um registo por ano × distrito)
- **Identificadores de Controlo:** Fonte Id: `F014` | Dados Id: `D130` | Dados de origem: `D116, D118, D119, D121, D122`

#### Dicionário de Colunas

| Coluna | Tipo | Descrição |
| --- | --- | --- |
| `year` | Inteiro | Ano de referência (2015 a 2025). |
| `district` | Texto | Distritos de Portugal  |
| `contribution_amount` | Decimal | Total em € das contribuições pagas por trabalhadores estrangeiros nesse distrito e ano. |
| `benefit_amount` | Decimal | Total em € das prestações sociais recebidas por estrangeiros nesse distrito e ano. |
| `contributors_count` | Inteiro | Número de trabalhadores estrangeiros que efetuaram contribuições. |
| `beneficiaries_count` | Inteiro | Número de trabalhadores estrangeiros que receberam prestações sociais. |
| `new_registrations_count` | Inteiro | Número de novos registos de trabalhadores estrangeiros na SS nesse ano e distrito. |
| `net_balance` | Decimal | **Campo calculado.** Saldo líquido: `contribution_amount − benefit_amount`. Valor positivo indica contribuição líquida positiva para a SS. |
| `avg_contribution_per_contributor` | Decimal | **Campo calculado.** Contribuição média por pessoa: `contribution_amount / contributors_count` (€ por contribuinte). |
| `avg_benefit_per_beneficiary` | Decimal | **Campo calculado.** Prestação média por pessoa: `benefit_amount / beneficiaries_count` (€ por beneficiário). |
| `contribution_benefit_ratio` | Decimal | **Campo calculado.** Rácio entre contribuições e prestações: `contribution_amount / benefit_amount`. Indica quantos € são pagos por cada € recebido. |
| `source_id` | Texto | Identificador da fonte (`"F014"`). |
| `source` | Texto | Nome da entidade de origem (`"Segurança Social"`). |

#### Limitações e Avisos Importantes

- **Sem desagregação por nacionalidade de origem:** Os dados cobrem todos os trabalhadores estrangeiros em conjunto, sem distinção por país de origem.
- **Campos calculados:** `net_balance`, `avg_contribution_per_contributor`, `avg_benefit_per_beneficiary` e `contribution_benefit_ratio` foram calculados durante o processo de merge e não constavam na fonte original. Para recalcular, utilizar o script `build_ss_datasets.py` e os 14 arquivos individuais.
- **Grain district × year:** Este ficheiro não permite análise demográfica por género ou faixa etária — utilizar o Ficheiro 2 para essa dimensão.

**Responsáveis: <br>
Coleta e limpeza dos ficheiros individuais:** Ana Cláudia Aquino<br>
**Merge, modelagem e campos calculados:** Tabata Zardi

---

### 2. `ss_foreigners_contributors_beneficiaries_by_gender_age_2015_2025.csv`

**Descrição:** Dataset consolidado com o número de contribuintes e beneficiários estrangeiros da Segurança Social, desagregado por género e faixa etária, entre 2015 e 2025. Inclui também o volume de novos registos por perfil demográfico. Resulta do merge de 3 ficheiros limpos provenientes do relatório *Pessoas Estrangeiras na Segurança Social* (F014).

#### Especificações Técnicas

- **Formato:** CSV | **Separador:** `;` | **Codificação:** UTF-8
- **Volume:** 132 linhas (um registo por ano × género × faixa etária)
- **Identificadores de Controlo:** Fonte Id: `F014` | Dados Id: `D131` | Dados de origem: `D117, D120, D123`

#### Dicionário de Colunas

| Coluna | Tipo | Descrição |
| --- | --- | --- |
| `year` | Inteiro | Ano de referência (2015 a 2025). |
| `gender` | Texto | Género do trabalhador (`FEMININO` / `MASCULINO`). |
| `age_group` | Texto | Faixa etária (`"<20"`, `"20-29"`, `"30-39"`, `“40-49”`, `“50-59”`,`"60+"`). |
| `contributors_count` | Inteiro | Número de trabalhadores estrangeiros contribuintes com esse perfil demográfico. |
| `beneficiaries_count` | Inteiro | Número de trabalhadores estrangeiros beneficiários com esse perfil demográfico. |
| `new_registrations_count` | Inteiro | Número de novos registos de trabalhadores estrangeiros na SS com esse perfil. |
| `source_id` | Texto | Identificador da fonte (`"F014"`). |
| `source` | Texto | Nome da entidade de origem (`"Segurança Social"`). |

#### Limitações e Avisos Importantes

- **⚠️ Sem valores monetários:** A fonte original não disponibiliza montantes de contribuições ou prestações desagregados por género e faixa etária. Este ficheiro contém exclusivamente contagens de pessoas. Para valores em €, utilizar o Ficheiro 1.
- **Sem desagregação por distrito:** O grain deste ficheiro é `year × gender × age_group`. Não é possível cruzar diretamente género/idade com distrito sem uma fonte adicional.
- **Sem desagregação por nacionalidade de origem:** Cobre todos os trabalhadores estrangeiros em conjunto.
- **Dados de 2025 potencialmente parciais:** Mesma ressalva que o Ficheiro 1.

**Responsáveis: <br>
Coleta e limpeza dos ficheiros individuais:** Ana Cláudia Aquino<br>
**Merge, modelagem e campos calculados:** Tabata Zardi

---

### 3. `ss_total_workers_context_by_district_2010_2025.csv`

**Descrição:** Dataset consolidado com indicadores do total de trabalhadores registados na Segurança Social em Portugal (dependentes e independentes), por distrito e ano, entre 2010 e 2025. Destina-se exclusivamente a fornecer o denominador para calcular o **peso relativo dos trabalhadores estrangeiros** no total nacional. Resulta do merge de 6 ficheiros limpos provenientes do relatório *Gestão de Remunerações — Dados Anuais* (F014).

- **🛑 Regra de Utilização:** **NÃO utilizar este ficheiro isoladamente** para responder à Pergunta 1. Os dados cobrem a **totalidade dos trabalhadores**, independentemente da nacionalidade. A série temporal mais longa (2010–2025) serve para contextualização e não para substituir os dados de estrangeiros do Ficheiro 1 (2015–2025).

#### Especificações Técnicas

- **Formato:** CSV | **Separador:** `;` | **Codificação:** UTF-8 | **Decimais:** Ponto (`.`)
- **Volume:** 336 linhas (um registo por ano × distrito)
- **Identificadores de Controlo:** Fonte Id: `F013` | Dados Id: `D132` | Dados de origem: `D124, D125, D126, D127, D128, D129`

#### Dicionário de Colunas

| Coluna | Tipo | Descrição |
| --- | --- | --- |
| `year` | Inteiro | Ano de referência (2010 a 2025). |
| `district` | Texto | Distritos de Portugal. |
| `employees_count` | Inteiro | Número de trabalhadores **dependentes** (por conta de outrem) registados na SS. |
| `self_employed_count` | Inteiro | Número de trabalhadores **independentes** (conta própria / recibos verdes) registados na SS. |
| `employee_contribution_amount` | Decimal | Total em € das contribuições pagas por trabalhadores dependentes (inclui quota do trabalhador e da entidade patronal). |
| `self_employed_contribution_amount` | Decimal | Total em € das contribuições pagas por trabalhadores independentes. |
| `remuneration_amount` | Decimal | Total em € das remunerações pagas a trabalhadores dependentes (base de cálculo das contribuições). |
| `employers_count` | Inteiro | Número de entidades patronais registadas no distrito. **Atenção:** representa empresas/entidades empregadoras, não trabalhadores. |
| `total_workers` | Inteiro | **Campo calculado.** Total de trabalhadores registados: `employees_count + self_employed_count`.  |
| `total_contribution_amount` | Decimal | **Campo calculado.** Total de contribuições: `employee_contribution_amount + self_employed_contribution_amount`.  |
| `source_id` | Texto | Identificador da fonte (`"F014"`). |
| `source` | Texto | Nome da entidade de origem (`"Segurança Social"`). |

#### Limitações e Avisos Importantes

- **Sem desagregação por nacionalidade:** Cobre a totalidade dos trabalhadores registados em Portugal, incluindo nacionais e estrangeiros em conjunto. Qualquer cruzamento com os Ficheiros 1 ou 2 é da responsabilidade do Grupo 2 no Looker Studio.
- **`employers_count` não é contagem de trabalhadores:** Este campo representa o número de entidades patronais (empresas, organismos), não de pessoas empregadas.
- **Cobertura temporal mais longa (2010–2025):** O período 2010–2014 só existe neste ficheiro e não tem equivalente nos dados de estrangeiros (Ficheiro 1 começa em 2015).
- **Campos calculados:** `total_workers` e `total_contribution_amount` foram calculados durante o merge e não constavam na fonte original.

**Responsáveis: <br>
Coleta e limpeza dos ficheiros individuais:** Ana Cláudia Aquino<br>
**Merge, modelagem e campos calculados:** Tabata Zardi

---

*Documento preparado e validado para envio à equipa de visualização por Tabata Zardi.*
