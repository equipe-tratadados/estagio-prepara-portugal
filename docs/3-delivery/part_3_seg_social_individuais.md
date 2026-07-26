# Documentação de Entrega — Dados Segurança Social / MTSSS para o Dashboard de Imigração

## **Parte 3 de [N] — Ficheiros Individuais de Origem**
**Guia de Integração e Dicionário de Dados**

Este documento serve como guia de suporte para o Grupo 2 no desenvolvimento do Dashboard de Imigração. Documenta os **14 ficheiros individuais limpos** que alimentaram os 3 ficheiros merged da entrega principal.

---

## Resumo

* **Origem dos Dados:** Segurança Social / GEP / MTSSS (F014).
* **Formato:** CSV | **Separador:** `;` | **Codificação:** UTF-8
* **Caminho base:** `data/3-delivery/seg_social/fontes_individuais/`
* **Propriedades comuns:** `source_id = F014` | `source = "Segurança Social"` | Granularidade anual.
* **Regra de utilização:** Estes ficheiros estão disponíveis para contexto, auditoria e validação. **Não utilizar diretamente no dashboard** — usar os ficheiros merged da raiz.

**Responsáveis por todos os ficheiros individuais:**
Coleta e limpeza: Ana Cláudia Aquino
Padronização (distritos, género, age_group, colunas `source_id` e `source`): Tabata Zardi

---

## Mapeamento: Ficheiros de Origem → Ficheiros Merged

| Ficheiro merged | Chave do merge | Ficheiros de origem |
| :--- | :--- | :--- |
| `ss_foreigners_contribution_benefit_by_district_2015_2025.csv` | `year × district` | D116, D118, D119, D121, D122 |
| `ss_foreigners_contributors_beneficiaries_by_gender_age_2015_2025.csv` | `year × gender × age_group` | D117, D120, D123 |
| `ss_total_workers_context_by_district_2010_2025.csv` | `year × district` | D124, D125, D126, D127, D128, D129 |

Todos os merges foram realizados via `outer merge` no script `build_ss_datasets.ipynb`.

---

## Detalhe dos Ficheiros Individuais

### Ficheiros de Estrangeiros — Série 2015–2025 (F014 / D077)
> Extraídos de `Pessoas-Estrangeiras-na-Seguranca-Social-2015-a-2025.xlsx`

---

#### 1. `ss_foreigner_contributors_by_district_2015_2025.csv` · D116
**Descrição:** Número de cidadãos estrangeiros contribuintes da Segurança Social por distrito. Alimenta a coluna `contributors_count` do ficheiro D130.

| Coluna | Tipo | Descrição |
| :--- | :--- | :--- |
| `year` | Inteiro | Ano de referência (2015 a 2025). |
| `district` | Texto | Nome do distrito (Title Case via `DISTRICT_MAP`). |
| `contributors_count` | Inteiro | Número de estrangeiros contribuintes registados. |
| `source_id` | Texto | `F014` |
| `source` | Texto | `Segurança Social` |

---

#### 2. `ss_foreigner_contributors_by_gender_age_group_2015_2025.csv` · D117
**Descrição:** Número de cidadãos estrangeiros contribuintes desagregados por género e faixa etária. Alimenta a coluna `contributors_count` do ficheiro D131.

| Coluna | Tipo | Descrição |
| :--- | :--- | :--- |
| `year` | Inteiro | Ano de referência (2015 a 2025). |
| `gender` | Texto | Género (`"Feminino"` / `"Masculino"`). |
| `age_group` | Texto | Faixa etária (`"<20"` / `"20-29"` / `"30-39"` / `"40-49"` / `"50-59"` / `"60+"`). |
| `contributors_count` | Inteiro | Número de estrangeiros contribuintes nessa combinação. |
| `source_id` | Texto | `F014` |
| `source` | Texto | `Segurança Social` |

---

#### 3. `ss_foreigner_contribution_amounts_by_district_2015_2025.csv` · D118
**Descrição:** Montante total de contribuições pagas por cidadãos estrangeiros por distrito. Alimenta a coluna `contribution_amount` do ficheiro D130.

| Coluna | Tipo | Descrição |
| :--- | :--- | :--- |
| `year` | Inteiro | Ano de referência (2015 a 2025). |
| `district` | Texto | Nome do distrito (Title Case via `DISTRICT_MAP`). |
| `contribution_amount` | Decimal | Montante total de contribuições (€). |
| `source_id` | Texto | `F014` |
| `source` | Texto | `Segurança Social` |

---

#### 4. `ss_foreigner_beneficiaries_by_district_2015_2025.csv` · D119
**Descrição:** Número de cidadãos estrangeiros beneficiários de prestações sociais por distrito. Alimenta a coluna `beneficiaries_count` do ficheiro D130.

| Coluna | Tipo | Descrição |
| :--- | :--- | :--- |
| `year` | Inteiro | Ano de referência (2015 a 2025). |
| `district` | Texto | Nome do distrito (Title Case via `DISTRICT_MAP`). |
| `beneficiaries_count` | Inteiro | Número de estrangeiros beneficiários de prestações. |
| `source_id` | Texto | `F014` |
| `source` | Texto | `Segurança Social` |

---

#### 5. `ss_foreigner_beneficiaries_by_gender_age_group_2015_2025.csv` · D120
**Descrição:** Número de cidadãos estrangeiros beneficiários de prestações desagregados por género e faixa etária. Alimenta a coluna `beneficiaries_count` do ficheiro D131.

| Coluna | Tipo | Descrição |
| :--- | :--- | :--- |
| `year` | Inteiro | Ano de referência (2015 a 2025). |
| `gender` | Texto | Género (`"Feminino"` / `"Masculino"`). |
| `age_group` | Texto | Faixa etária (`"<20"` / `"20-29"` / `"30-39"` / `"40-49"` / `"50-59"` / `"60+"`). |
| `beneficiaries_count` | Inteiro | Número de estrangeiros beneficiários nessa combinação. |
| `source_id` | Texto | `F014` |
| `source` | Texto | `Segurança Social` |

---

#### 6. `ss_foreigner_benefit_amounts_by_district_2015_2025.csv` · D121
**Descrição:** Montante total de prestações sociais recebidas por cidadãos estrangeiros por distrito. Alimenta a coluna `benefit_amount` do ficheiro D130.

| Coluna | Tipo | Descrição |
| :--- | :--- | :--- |
| `year` | Inteiro | Ano de referência (2015 a 2025). |
| `district` | Texto | Nome do distrito (Title Case via `DISTRICT_MAP`). |
| `benefit_amount` | Decimal | Montante total de prestações sociais recebidas (€). |
| `source_id` | Texto | `F014` |
| `source` | Texto | `Segurança Social` |

---

#### 7. `ss_foreigner_new_registrations_by_district_2015_2025.csv` · D122
**Descrição:** Número de novas inscrições de cidadãos estrangeiros na Segurança Social por distrito. Alimenta a coluna `new_registrations_count` do ficheiro D130.

| Coluna | Tipo | Descrição |
| :--- | :--- | :--- |
| `year` | Inteiro | Ano de referência (2015 a 2025). |
| `district` | Texto | Nome do distrito (Title Case via `DISTRICT_MAP`). |
| `new_registrations_count` | Inteiro | Número de novas inscrições de estrangeiros. |
| `source_id` | Texto | `F014` |
| `source` | Texto | `Segurança Social` |

---

#### 8. `ss_foreigner_new_registrations_by_gender_age_group_2015_2025.csv` · D123
**Descrição:** Número de novas inscrições de cidadãos estrangeiros desagregadas por género e faixa etária. Alimenta a coluna `new_registrations_count` do ficheiro D131.

| Coluna | Tipo | Descrição |
| :--- | :--- | :--- |
| `year` | Inteiro | Ano de referência (2015 a 2025). |
| `gender` | Texto | Género (`"Feminino"` / `"Masculino"`). |
| `age_group` | Texto | Faixa etária (`"<20"` / `"20-29"` / `"30-39"` / `"40-49"` / `"50-59"` / `"60+"`). |
| `new_registrations_count` | Inteiro | Número de novas inscrições nessa combinação. |
| `source_id` | Texto | `F014` |
| `source` | Texto | `Segurança Social` |

---

### Ficheiros de Contexto Total — Série 2010–2025 (F014 / D076)
> Extraídos de `Gestao-de-Remuneracoes-Dados-Anuais-2010-a-2025.xls`

---

#### 9. `ss_employees_by_district_2010_2025.csv` · D126
**Descrição:** Número total de trabalhadores por conta de outrem registados na Segurança Social por distrito (nacionais e estrangeiros). Alimenta a coluna `employees_count` do ficheiro D132.

| Coluna | Tipo | Descrição |
| :--- | :--- | :--- |
| `year` | Inteiro | Ano de referência (2010 a 2025). |
| `district` | Texto | Nome do distrito (Title Case via `DISTRICT_MAP`). |
| `employees_count` | Inteiro | Número de trabalhadores por conta de outrem registados. |
| `source_id` | Texto | `F014` |
| `source` | Texto | `Segurança Social` |

---

#### 10. `ss_self_employed_by_district_2010_2025.csv` · D128
**Descrição:** Número total de trabalhadores independentes registados na Segurança Social por distrito. Alimenta a coluna `self_employed_count` do ficheiro D132.

| Coluna | Tipo | Descrição |
| :--- | :--- | :--- |
| `year` | Inteiro | Ano de referência (2010 a 2025). |
| `district` | Texto | Nome do distrito (Title Case via `DISTRICT_MAP`). |
| `self_employed_count` | Inteiro | Número de trabalhadores independentes registados. |
| `source_id` | Texto | `F014` |
| `source` | Texto | `Segurança Social` |

---

#### 11. `ss_employee_contribution_amounts_by_district_2010_2025.csv` · D124
**Descrição:** Montante total de contribuições dos trabalhadores por conta de outrem por distrito. Alimenta a coluna `employee_contribution_amount` do ficheiro D132.

| Coluna | Tipo | Descrição |
| :--- | :--- | :--- |
| `year` | Inteiro | Ano de referência (2010 a 2025). |
| `district` | Texto | Nome do distrito (Title Case via `DISTRICT_MAP`). |
| `employee_contribution_amount` | Decimal | Montante de contribuições dos trabalhadores por conta de outrem (€). |
| `source_id` | Texto | `F014` |
| `source` | Texto | `Segurança Social` |

---

#### 12. `ss_self_employed_contribution_amounts_by_district_2010_2025.csv` · D129
**Descrição:** Montante total de contribuições dos trabalhadores independentes por distrito. Alimenta a coluna `self_employed_contribution_amount` do ficheiro D132.

| Coluna | Tipo | Descrição |
| :--- | :--- | :--- |
| `year` | Inteiro | Ano de referência (2010 a 2025). |
| `district` | Texto | Nome do distrito (Title Case via `DISTRICT_MAP`). |
| `self_employed_contribution_amount` | Decimal | Montante de contribuições dos trabalhadores independentes (€). |
| `source_id` | Texto | `F014` |
| `source` | Texto | `Segurança Social` |

---

#### 13. `ss_employee_remuneration_amounts_by_district_2010_2025.csv` · D125
**Descrição:** Montante total de remunerações declaradas pelos trabalhadores por conta de outrem por distrito. Alimenta a coluna `remuneration_amount` do ficheiro D132.

| Coluna | Tipo | Descrição |
| :--- | :--- | :--- |
| `year` | Inteiro | Ano de referência (2010 a 2025). |
| `district` | Texto | Nome do distrito (Title Case via `DISTRICT_MAP`). |
| `remuneration_amount` | Decimal | Montante total de remunerações declaradas pelos trabalhadores dependentes (€). |
| `source_id` | Texto | `F014` |
| `source` | Texto | `Segurança Social` |

---

#### 14. `ss_employers_base_remuneration_by_district_2010_2025.csv` · D127
**Descrição:** Contagem de entidades patronais com remunerações base declaradas, por distrito. Fonte original: *Entidades Empregadoras com Remunerações Base Declaradas por Distrito Sede da Entidade Empregadora e Ano de Referência da Remuneração*. Alimenta a coluna `employers_count` do ficheiro D132.

| Coluna | Tipo | Descrição |
| :--- | :--- | :--- |
| `year` | Inteiro | Ano de referência (2010 a 2025). |
| `district` | Texto | Nome do distrito (Title Case via `DISTRICT_MAP`). |
| `employers_count` | Inteiro | Número de entidades patronais com remunerações base declaradas. **Atenção:** não é contagem de trabalhadores — é o número de empresas/entidades empregadoras. |
| `source_id` | Texto | `F014` |
| `source` | Texto | `Segurança Social` |

---

## Limitações Comuns a Todos os Ficheiros

* **Granularidade apenas anual** — sem desagregação mensal ou trimestral.
* **Sem desagregação por nacionalidade** — os ficheiros de estrangeiros tratam o universo de cidadãos estrangeiros como um todo.
* **Herança de limitações das fontes originais** — todos os ficheiros herdam as limitações dos Excel de origem disponibilizados pela Segurança Social (D076 e D077), incluindo eventuais lacunas de cobertura geográfica ou temporal.

---

## Campos Calculados — Explicação Detalhada (Ficheiro D130)

#### `net_balance` — Saldo líquido
Quanto os imigrantes deixaram na Segurança Social, depois de descontar o que receberam.
```
net_balance = contribution_amount − benefit_amount
```
> Exemplo: Em 2015, em Aveiro, pagaram €13,8M e receberam €3,4M → `net_balance = €10,4M`. Valor positivo significa que o grupo contribuiu mais do que recebeu.

#### `avg_contribution_per_contributor` — Contribuição média por pessoa
Em média, quanto pagou cada imigrante contribuinte nesse ano e distrito.
```
avg_contribution_per_contributor = contribution_amount / contributors_count
```
> Exemplo: Em 2015, em Aveiro: €13,8M ÷ 4.935 pessoas → €2.813/pessoa.

#### `avg_benefit_per_beneficiary` — Prestação média por pessoa
Em média, quanto recebeu cada imigrante beneficiário nesse ano e distrito.
```
avg_benefit_per_beneficiary = benefit_amount / beneficiaries_count
```
> Exemplo: Em 2015, em Aveiro: €3,4M ÷ 2.333 pessoas → €1.494/pessoa.

#### `contribution_benefit_ratio` — Rácio contribuições/prestações
Por cada €1 recebido em prestações, quantos euros foram pagos em contribuições.
```
contribution_benefit_ratio = contribution_amount / benefit_amount
```
> Exemplo: Em 2015, em Aveiro: €13,8M ÷ €3,4M → 3,98. Por cada €1 recebido, foram pagos €3,98. Quanto maior o rácio, mais "superavitário" o grupo nesse distrito e ano.

> **Nota de uso:** `net_balance` e `avg_contribution_per_contributor` são os campos mais diretos para responder à Pergunta 1. O `contribution_benefit_ratio` é especialmente útil para comparações entre distritos e anos sem distorção pelo tamanho da população.

---

## Campos Calculados — Explicação Detalhada (Ficheiro D132)

#### `total_workers` — Total de trabalhadores
Soma de trabalhadores dependentes e independentes nesse distrito e ano.
```
total_workers = employees_count + self_employed_count
```

#### `total_contribution_amount` — Total de contribuições
Soma das contribuições de trabalhadores dependentes e independentes.
```
total_contribution_amount = employee_contribution_amount + self_employed_contribution_amount
```

---

*Documento preparado e validado para envio à equipa de visualização.*