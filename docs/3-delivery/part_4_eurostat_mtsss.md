# Documentação de Entrega: Dados GEP/MTSSS + Eurostat para o Dashboard de Imigração

## **Parte 4 de [4] - 1 arquivo**
**Guia de Integração e Dicionário de Dados**

Este documento serve como guia de suporte para o Grupo 2 no desenvolvimento do Dashboard de Imigração. Contém as especificações técnicas, limitações conhecidas e a estrutura de colunas para o **ficheiro harmonizado** de dados tratados incluído nesta entrega.

---

## Resumo

* **Origem dos Dados:** GEP/MTSSS (Quadros de Pessoal Q9_E e Q13_E) e Eurostat (LFS lfsa_egan2 e nama_10_a64).
* **Formatos Comuns:** CSV, separador ponto e vírgula (`;`), codificação `UTF-8`.
* **Objetivo:** Alimentar os painéis de distribuição setorial de trabalhadores imigrantes e o cruzamento com o peso de cada setor no PIB nacional.
* **Pergunta:** Resposta à Pergunta 2, Subtema 1: Em que setores de atividade económica se concentram os trabalhadores imigrantes, e qual o peso desses setores no PIB nacional?

---

## Detalhe dos Ficheiros

### 1. `immigrant_workers_gdp_by_year_cae_2014_2024.csv`

**Descrição:** Ficheiro harmonizado que cruza três fontes independentes num único dataset com grain `year × cae_section`. Contém o número de trabalhadores estrangeiros por setor de atividade económica (CAE Rev.3 / NACE Rev.2, nível de secção), o total de emprego por setor (Eurostat LFS) e o Valor Acrescentado Bruto (VAB) de cada setor (Eurostat nama_10_a64), permitindo calcular simultaneamente a concentração de imigrantes por setor e o peso económico desse setor no PIB nacional. Cobre o período de 2014 a 2024 para Portugal.

* **⚠️ Aviso de Cruzamento:** O cruzamento entre emprego estrangeiro (Quadros de Pessoal) e VAB setorial (Eurostat) é uma **inferência entre duas séries independentes**, não uma relação direta. O dashboard deve deixar claro que a correlação é observada, não causal.
* **⚠️ Aviso de Cobertura:** Os dados de VAB estão disponíveis apenas a partir de 2016. Os anos de 2014 e 2015 contêm dados de emprego estrangeiro mas com as colunas de VAB e `gva_share_pct` a nulo.

#### Especificações Técnicas

* **Formato:** CSV | **Separador:** `;` | **Codificação:** UTF-8 | **Decimais:** Ponto (`.`)
* **Volume:** 220 linhas (Formato longo: uma linha por `year × cae_section`)
* **Grain:** Uma linha por ano e por secção CAE/NACE (20 secções × 11 anos)
* **Identificadores de Controlo:** Fonte Id: `F010 / F012` | Dados Id: `D074 / D079` (2014-2015) e `D074 / D079 / D115` (2016-2024)

#### Fontes Cruzadas

| Fonte Id | Dados Id | Origem | Período | Contribuição |
| :--- | :--- | :--- | :--- | :--- |
| `F010` | `D074` | GEP/MTSSS: Quadros de Pessoal Q9_E e Q13_E | 2014-2024 | `foreign_workers_all_q9e` e `foreign_tco_q13e` |
| `F012` | `D079` | Eurostat LFS (lfsa_egan2) | 2008-2025 | `total_employment_thousand_lfs` e `foreign_tco_pct_lfs` |
| `F012` | `D115` | Eurostat nama_10_a64 (VAB por setor) | 2016-2024 | `gva_million_eur`, `gva_total_pt_million_eur` e `gva_share_pct` |

#### Dicionário de Colunas

| Coluna | Tipo | Descrição / Valores Possíveis |
| :--- | :--- | :--- |
| `year` | Inteiro | Ano de referência (2014 a 2024). |
| `country` | Texto | Código ISO do país (`PT`: constante). |
| `cae_code` | Texto | Código de secção CAE Rev.3 / NACE Rev.2 (1 letra, de `A` a `U`). |
| `cae_description_pt` | Texto | Descrição da secção em português (fonte: Quadros de Pessoal). |
| `sector_description_en` | Texto | Descrição da secção em inglês (fonte: Eurostat). |
| `foreign_workers_all_q9e` | Inteiro | Total de pessoas de nacionalidade estrangeira no setor: inclui TCO, empregadores, trabalhadores familiares não remunerados e membros de cooperativas (fonte: Q9_E). |
| `foreign_tco_q13e` | Inteiro | Trabalhadores por conta de outrem (TCO) de nacionalidade estrangeira no setor (fonte: Q13_E). |
| `total_employment_thousand_lfs` | Decimal | Total de empregados no setor em Portugal, todas as nacionalidades, em milhares de pessoas (fonte: Eurostat LFS). |
| `foreign_tco_pct_lfs` | Decimal | Peso dos TCO estrangeiros (Q13_E) no total de emprego LFS do setor, em percentagem. **Atenção:** numerador vem dos Quadros de Pessoal (setor privado) e denominador do LFS (total da economia): os universos são distintos. |
| `lfs_data_flag` | Texto | Flag de qualidade do dado LFS (`break_in_series`, `low_reliability` ou vazio para dado normal). |
| `gva_million_eur` | Decimal | VAB do setor em milhões de euros, a preços correntes (fonte: Eurostat nama_10_a64). **Nulo para 2014 e 2015.** |
| `gva_total_pt_million_eur` | Decimal | VAB total de Portugal no ano, em milhões de euros (soma de todos os setores). Usado como denominador de `gva_share_pct`. **Nulo para 2014 e 2015.** |
| `gva_share_pct` | Decimal | Peso do setor no VAB total de Portugal no ano, em percentagem. **Nulo para 2014 e 2015.** |
| `vab_data_flag` | Texto | Flag de qualidade do dado VAB Eurostat (`provisional` para dados preliminares ou vazio para dados definitivos). Em 2024, todos os setores têm `provisional`. |
| `cae_nace_level` | Texto | Nível hierárquico CAE/NACE usado neste ficheiro (`section`: constante). |
| `source_id` | Texto | Identificadores das fontes usadas na linha (`F010 / F012`: constante). |
| `dataset_id` | Texto | Identificadores dos datasets cruzados na linha (`D074 / D079` para 2014-2015; `D074 / D079 / D115` para 2016-2024). |
| `source_name` | Texto | Descrição por extenso das fontes cruzadas na linha. |
| `notes` | Texto | Observações específicas da linha (ex: anos sem VAB disponível). |

#### Cobertura por Coluna e Período

| Coluna | 2014-2015 | 2016-2024 |
| :--- | :--- | :--- |
| `foreign_workers_all_q9e` | ✅ Completo | ✅ Completo |
| `foreign_tco_q13e` | ✅ Completo | ✅ Completo |
| `total_employment_thousand_lfs` | ✅ Completo | ✅ Completo |
| `foreign_tco_pct_lfs` | ✅ Completo | ✅ Completo |
| `gva_million_eur` | ❌ Nulo | ✅ Completo |
| `gva_share_pct` | ❌ Nulo | ✅ Completo |

#### Destaques para o Dashboard

Os 5 setores com maior número de TCO estrangeiros em 2024:

| Setor | Descrição | TCO estrangeiros | Peso no VAB (2024) | % do emprego total |
| :--- | :--- | ---: | ---: | ---: |
| `N` | Atividades administrativas e serviços de apoio | 97.030 | 4,46% | 52,73% |
| `I` | Alojamento, restauração e similares | 93.337 | 6,44% | 29,35% |
| `F` | Construção | 65.624 | 5,07% | 18,25% |
| `C` | Indústrias transformadoras | 59.815 | 13,50% | 7,23% |
| `G` | Comércio por grosso e a retalho | 55.336 | 11,97% | 7,34% |

**Nota de leitura:** O setor `N` concentra o maior número de imigrantes (52,73% do emprego total no setor) mas representa apenas 4,46% do VAB. O setor `C` tem o maior peso no PIB (13,50%) mas a menor concentração relativa de imigrantes (7,23%).

#### Limitações & Avisos Importantes

* **Cobertura sectorial dos Quadros de Pessoal:** Os QP cobrem apenas empresas do setor privado obrigadas a reportar. Excluem o setor público, trabalhadores independentes e emprego informal. O LFS, pelo contrário, cobre toda a economia: os denominadores de `foreign_tco_pct_lfs` são mais amplos que os numeradores, pelo que esta percentagem é uma **estimativa por baixo** da real concentração de imigrantes.
* **Secção T ausente:** A secção `T` (empregadores domésticos) não consta nos Quadros de Pessoal e está ausente deste ficheiro.
* **Secção U sem LFS:** A secção `U` (organizações extraterritoriais) consta nos QP mas não tem correspondência no Eurostat LFS: `foreign_tco_pct_lfs` é nulo para este setor.
* **VAB a preços correntes:** O crescimento de `gva_share_pct` ao longo do tempo pode refletir inflação setorial e não apenas crescimento real.
* **Dados provisórios em 2024:** Todas as linhas de 2024 têm `vab_data_flag = provisional`: os valores de VAB estão sujeitos a revisão pelo Eurostat.
* **Sem desagregação por nacionalidade de origem:** Os Quadros de Pessoal tratam todos os trabalhadores estrangeiros como categoria única, sem distinguir nacionalidade de origem.
* **Quebra de série:** Em 2021, todos os setores têm lfs_data_flag = break_in_series devido a uma revisão metodológica. Comparações 2020→2021 devem ser feitas com cautela.

**Responsável:**  [Antony Ferreira](https://github.com/antonyfferreira)

---
