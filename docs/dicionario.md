# Dicionário de Dados

> **📖 Como usar este dicionário**
>
> 1. Este é um ficheiro **partilhado por todo o grupo**. Todos os conjuntos de dados recolhidos devem ser registados aqui.
> 2. **Cada CSV recolhido e arrumado = uma linha nova** nesta tabela. Acrescente a linha por baixo das que já existem.
> 3. Preencha **todas** as colunas. Se uma coluna não se aplicar, escreva "Não aplicável", nunca deixe em branco.
> 4. Na coluna **Ficheiro**, ponha o nome do CSV como link para onde ele está no GitHub, no formato `[nome.csv](caminho/no/github)`. (ex.: `[residents_by_nationality_2024.csv](data/raw/aima/residents_by_nationality_2024.csv)`)
> 5. A coluna **Estado** deve refletir a situação real do ficheiro. Use apenas os estados da legenda abaixo e atualize-o sempre que o estado mudar.
> 6. **Nunca apague linhas** sem autorização dos revisores. Se um ficheiro deixar de ser utilizado no projeto, mude o estado para ⏸️ Bloqueado e acrescente uma nota breve na coluna **Estado** (ex.: `substituído por residents_v2.csv`).
> 7. Cada CSV listado aqui **tem obrigatoriamente** uma linha correspondente no `log.md` central. Se não tiver, registe-a antes de acrescentar aqui.
> 8. **Só entram aqui ficheiros que cumprem todas as regras da `biblioteca.md`**. Um CSV que não esteja arrumado segundo essas regras não deve ser listado.
> 9. Atualize esta tabela **assim que um CSV for publicado** no repositório. Não deixe para depois.
> 10. Faça commit assim que acrescentar ou atualizar uma linha, para que o resto do grupo veja o registo atualizado.

> ### Tabela de Exemplo:
>
>| Fonte Id | Ficheiro | Fonte | Período | Colunas principais | Estado | Responsável |
>| :------- | :------- | :---- | :------ | :----------------- | :----- | :---------- |
>| F001 | [residents_by_nationality_2024.csv](data/raw/aima/residents_by_nationality_2024.csv) | AIMA | 2015–2024 | year, nationality, resident_count | ✅ Pronto | [nome do estagiário] |

---

### Legenda dos estados

| Legenda | Significado |
| :------ | :---------- |
| ✅ Pronto | Recolhido, arrumado segundo a `biblioteca.md` e registado no `log.md` |
| 🟡 Em revisão | Recolhido mas ainda a validar |
| 🔄 Em coleta | Ainda a ser recolhido |
| ⏸️ Bloqueado | À espera de acesso à fonte ou substituído |

---

## 📝 Dicionário de Dados (a preencher)

| Fonte Id | Ficheiro | Fonte | Período | Colunas principais | Estado | Responsável |
| :------- | :------- | :---- | :------ | :----------------- | :----- | :---------- |
| F007 | [portugal_gdp_quarterly_current_prices_1995_2026.csv](/data/2-clean/ine/portugal_gdp_quarterly_current_prices_1995_2026.csv) | INE | 1995-2026 | year; quarter; period; country; gdp_million_eur; source_id; source; unit; price_basis; seasonal_adjusted; notes | 🟡 Em revisão | [Antony Ferreira](https://github.com/antonyfferreira) |
| F007 | [portugal_gdp_quarterly_yoy_growth_1996_2026.csv](/data/1-raw/ine/portugal_gdp_quarterly_yoy_growth_1996_2026.csv) | INE | 1996-2026 | year; quarter; period; country; gdp_yoy_growth_pct; source_id; source; unit; price_basis; seasonal_adjusted; notes | 🟡 Em revisão | [Antony Ferreira](https://github.com/antonyfferreira) |
| F007 | [portugal_gdp_quarterly_chain_volume_1995_2026.csv](/data/1-raw/ine/portugal_gdp_quarterly_chain_volume_1995_2026.csv) | INE | 1995-2026 | year; quarter; period; country; gdp_chain_volume_million_eur; source_id; source; unit; price_basis; seasonal_adjusted; notes | 🟡 Em revisão | [Antony Ferreira](https://github.com/antonyfferreira) |
| F007 | [portugal_gdp_quarterly_chain_volume_yoy_growth_1996_2026.csv](/data/2-clean/ine/portugal_gdp_quarterly_chain_volume_yoy_growth_1996_2026.csv) | INE | 1996-2026 | year; quarter; period; country; gdp_chain_vol_yoy_growth_pct; source_id; source; unit; price_basis; seasonal_adjusted; notes | 🟡 Em revisão | [Antony Ferreira](https://github.com/antonyfferreira) |
| F007 | [portugal_gdp_real_per_capita_yoy_growth_1996_2025.csv](/data/2-clean/ine/portugal_gdp_real_per_capita_yoy_growth_1996_2025.csv) | INE | 1996-2025 | year; country; gdp_real_pc_yoy_growth_pct; source_id; source; unit; price_basis; data_flag; notes | 🟡 Em revisão | [Antony Ferreira](https://github.com/antonyfferreira) |
| F007 | [portugal_gov_balance_pct_gdp_quarterly_1999_2026.csv](/data/2-clean/ine/portugal_gov_balance_pct_gdp_quarterly_1999_2026.csv) | INE | 1999-2026 | year; quarter; period; country; gov_balance_pct_gdp; source_id; source; unit; data_flag; notes | 🟡 Em revisão | [Antony Ferreira](https://github.com/antonyfferreira) |
| F009 | [portugal_gdp_annual_1960_2025.csv](/data/2-clean/pordata/portugal_gdp_annual_1960_2025.csv) | Pordata | 1960-2025 | year; country; gdp_million_eur; gdp_thousand_eur; source_id; source; unit; price_basis; notes | 🟡 Em revisão | [Antony Ferreira](https://github.com/antonyfferreira) |