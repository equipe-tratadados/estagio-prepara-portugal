# 🗺️ Padronização de nomes de Colunas

Este documento estabelece o padrão obrigatório para nomes de colunas, tipos de dados e formatação em todos os ficheiros limpos (`data/2-clean/`) do projeto. 

**Regras de Ouro:**
1. **Snake Case & Inglês:** Todas as colunas devem ser escritas em `snake_case` e em inglês.
2. **Sem Símbolos:** Nunca usar `<`, `>`, `%` ou `€` nos nomes das colunas.
3. **Preservar Escala:** Guardar os valores exatamente na escala da fonte original (não transformar taxas em absolutos ou vice-versa na limpeza). Documentar a unidade no log da task.
4. **Entre em contato caso não encontre uma correspondência aqui.**

---

## 1. Tempo, Geografia e Divisões Administrativas

| Termo Original (PT) | Coluna Padrão (EN) | Tipo | Notas / Boas Práticas |
| :--- | :--- | :--- | :--- |
| Anos / Ano | `year` | `int` | Sempre 4 dígitos (Ex: `2024`). |
| País / Países | `country` | `str` | Nome do país por extenso. |
| Nacionalidade | `nationality` | `str` | Usar se o foco for o estatuto legal/cidadania, não o território. |
| Continente / Região | `continent` | `str` | Agregadores geográficos macro (Europa, África, etc.). |
| Concelho | `municipality` | `str` | Termo oficial para concelhos em Portugal. |
| Distrito | `district` | `str` | Divisão distrital clássica. |
| Divisão Mista | `region` | `str` | Usar apenas se a fonte misturar distritos e concelhos na mesma coluna. |

---

## 2. Demografia, Filtros e Categorias

| Termo Original (PT) | Coluna Padrão (EN) | Tipo | Notas / Boas Práticas |
| :--- | :--- | :--- | :--- |
| Género / Sexo | `gender` | `str` | **Valores permitidos nas linhas:** padronizar para `male` e `female` pós-unpivot. |
| Motivo / Finalidade | `application_reason` | `str` | Razão do pedido (ex: `work`, `study`, `family_reunification`). Evitar `type` ou `category`. |
| Estatuto Profissional | `employment_status` | `str` | Estado laboral (ex: `employed`, `unemployed`, `self_employed`). |
| Escalão Etário / Idade | `age_group` / `age` | `str` / `int` | Grupos (ex: `0-14`, `15-64`) ou idades absolutas. |
| Estado Civil | `marital_status` | `str` | Valores: `single`, `married`, `divorced`, `widowed`. |
| Nível de Escolaridade | `education_level` | `str` | Seguir classificação ISCED (ex: `higher_education`). |
| Ano de Chegada | `arrival_year` | `int` | Ano em que o imigrante entrou no país (4 dígitos). |

---

## 3. Contagens Volumétricas (Valores Absolutos)

| Termo Original (PT) | Coluna Padrão (EN) | Tipo | Notas / Boas Práticas |
| :--- | :--- | :--- | :--- |
| População Estrangeira | `resident_foreign_population` | `int` | Contagem absoluta de residentes estrangeiros. |
| População Total | `total_population` | `int` | População total da região (evitar usar apenas `total`). |
| N.º de Pessoas / Contagem | `resident_count` | `int` | Termo genérico para contagens absolutas de indivíduos. |
| Imigrantes (Fluxo) | `immigrants` | `int` | Entradas absolutas num determinado ano. |
| Emigrantes (Fluxo) | `emigrants` | `int` | Saídas absolutas num determinado ano. |

---

## 4. Economia, Trabalho e Segurança Social

| Termo Original (PT) | Coluna Padrão (EN) | Tipo | Notas / Boas Práticas |
| :--- | :--- | :--- | :--- |
| PIB (Produto Interno Bruto) | `gdp` | `float` | Valor macroeconómico. Se for por pessoa, usar `gdp_per_capita`. |
| Setor de Atividade | `economic_sector` | `str` | Ramos da economia ou divisões CAE (ex: `agriculture`, `services`). |
| Valor de Contribuições | `social_security_contributions` | `float` | Montante financeiro totalizado (em Euros). |
| N.º de Contribuintes | `social_security_contributors` | `int` | Contagem de CPFs/NIFs individuais que descontaram. |
| Beneficiários | `social_security_beneficiaries` | `int` | Pessoas a receber prestações ou apoios sociais. |

---

## 5. Taxas e Proporções

| Termo Original (PT) | Coluna Padrão (EN) | Tipo | Notas / Boas Práticas |
| :--- | :--- | :--- | :--- |
| Taxa Bruta de Imigração | `immigration_rate` | `float` | Rácio por habitante (ex: por 1.000 residentes). |
| Taxa de Crescimento | `growth_rate` | `float` | Variação percentual ou rácio de crescimento anual. |
| Peso / Proporção (%) | `population_share` | `float` | Percentagem de um grupo face ao todo (ex: 0.15 para 15%). |

---

## 6. Estatuto Legal, Documentação e Fronteiras

| Termo Original (PT) | Coluna Padrão (EN) | Tipo | Notas / Boas Práticas |
| :--- | :--- | :--- | :--- |
| Tipo de Visto / Título | `permit_type` | `str` | Tipo de autorização (ex: `residence`, `student_visa`). |
| Pedidos de Asilo | `asylum_applications` | `int` | Contagem absoluta de requerentes de proteção. |
| Estatuto de Refugiado | `refugee_status` | `str`/`int` | Flag/Filtro ou contagem de pessoas com o estatuto. |
| Aquisição de Cidadania | `naturalization_count` | `int` | Contagem de novos cidadãos nacionais por ano. |
| Recusas de Entrada | `entry_refusals` | `int` | Casos de barragem na fronteira (contagem absoluta). |
| Afastamentos / Devoluções | `deportations` | `int` | Fluxo de retornos forçados ou expulsões. |

---

## 7. Rota e Percurso Migratório

| Termo Original (PT) | Coluna Padrão (EN) | Tipo | Notas / Boas Práticas |
| :--- | :--- | :--- | :--- |
| País de Nascimento | `country_of_birth` | `str` | Sítio de nascimento (pode diferir da nacionalidade). |
| Último País de Residência | `previous_country_of_residence` | `str` | Útil para identificar rotas migratórias e escalas. |
| Reagrupamento Familiar | `family_reunification` | `str`/`int` | Indica se a entrada está associada a vínculo familiar. |