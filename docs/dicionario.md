# Dicionário de Dados

> **📖 Como usar este dicionário**
>
> 1. Este é um ficheiro **partilhado por todo o grupo**. Todos os conjuntos de dados recolhidos devem ser registados aqui.
> 2. **Cada CSV recolhido e arrumado = uma linha nova** nesta tabela. Acrescente a linha por baixo das que já existem.
> 3. Preencha **todas** as colunas. Se uma coluna não se aplicar, escreva "Não aplicável", nunca deixe em branco.
> 4. Na coluna **Ficheiro**, ponha o nome do CSV como link para onde ele está no GitHub, no formato `[nome.csv](caminho/no/github)`. (ex.: `[residents_by_nationality_2024.csv](/data/raw/aima/residents_by_nationality_2024.csv)`)
> 5. A coluna **Estado** deve refletir a situação real do ficheiro. Use apenas os estados da legenda abaixo e atualize-o sempre que o estado mudar.
> 6. **Nunca apague linhas** sem autorização dos revisores. Se um ficheiro deixar de ser utilizado no projeto, mude o estado para ⏸️ Bloqueado e acrescente uma nota breve na coluna **Estado** (ex.: `substituído por residents_v2.csv`).
> 7. Cada CSV listado aqui **tem obrigatoriamente** uma linha correspondente no `log.md` central. Se não tiver, registe-a antes de acrescentar aqui.
> 8. **Só entram aqui ficheiros que cumprem todas as regras da `biblioteca.md`**. Um CSV que não esteja arrumado segundo essas regras não deve ser listado.
> 9. Atualize esta tabela **assim que um CSV for publicado** no repositório. Não deixe para depois.
> 10. Faça commit assim que acrescentar ou atualizar uma linha, para que o resto do grupo veja o registo atualizado.

> ### Tabela de Exemplo:
>
>| Fonte Id | Dados Id | Ficheiro | Fonte | Período | Colunas principais | Estado | Responsável |
>| :------- | :------- | :------- | :---- | :------ | :----------------- | :----- | :---------- |
>| F001 | D002 | [residents_by_nationality_2024.csv](/data/raw/aima/residents_by_nationality_2024.csv) | AIMA | 2015–2024 | year, nationality, resident_count | ✅ Pronto | [nome do estagiário] |

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

| Fonte Id | Dados Id | Ficheiro | Fonte | Período | Colunas principais | Estado | Responsável |
| :------- | :------- | :------- | :---- | :------ | :----------------- | :----- | :---------- |
| F001 | D014 | [rifa_2015_pg65_residents_by_nationality_gender.csv](/data/2-clean/sef/rifa_2015_pg65_residents_by_nationality_gender.csv) | SEF - RIFA 2015 | 2015 | nationality, resident_count_male, resident_count_female, permits_granted_male, permits_granted_female | 🟡 Em revisão | [Tabata Zardi](https://github.com/zarditab) |
| F001 | D015 | [rifa_2016_pg71_residents_by_nationality_gender.csv](/data/2-clean/sef/rifa_2016_pg71_residents_by_nationality_gender.csv) | SEF - RIFA 2016 | 2016 | nationality, resident_count_male, resident_count_female, permits_granted_male, permits_granted_female | 🟡 Em revisão | [Tabata Zardi](https://github.com/zarditab) |
| F001 | D016 | [rifa_2017_pg71_residents_by_nationality_gender.csv](/data/2-clean/sef/rifa_2017_pg71_residents_by_nationality_gender.csv) | SEF - RIFA 2017 | 2017 | nationality, resident_count_male, resident_count_female, permits_granted_male, permits_granted_female | 🟡 Em revisão | [Tabata Zardi](https://github.com/zarditab) |
| F001 | D017 | [rifa_2018_pg81_residents_by_nationality_gender.csv](/data/2-clean/sef/rifa_2018_pg81_residents_by_nationality_gender.csv) | SEF - RIFA 2018 | 2018 | nationality, resident_count_male, resident_count_female, permits_granted_male, permits_granted_female | 🟡 Em revisão | [Tabata Zardi](https://github.com/zarditab) |
| F001 | D018 | [rifa_2019_pg84_residents_by_nationality_gender.csv](/data/2-clean/sef/rifa_2019_pg84_residents_by_nationality_gender.csv) | SEF - RIFA 2019 | 2019 | nationality, resident_count_male, resident_count_female, permits_granted_male, permits_granted_female | 🟡 Em revisão | [Tabata Zardi](https://github.com/zarditab) |
| F001 | D019 | [rifa_2020_pg86_residents_by_nationality_gender.csv](/data/2-clean/sef/rifa_2020_pg86_residents_by_nationality_gender.csv) | SEF - RIFA 2020 | 2020 | nationality, resident_count_male, resident_count_female, permits_granted_male, permits_granted_female | 🟡 Em revisão | [Tabata Zardi](https://github.com/zarditab) |
| F001 | D020 | [rifa_2021_pg96_residents_by_nationality_gender.csv](/data/2-clean/sef/rifa_2021_pg96_residents_by_nationality_gender.csv) | SEF - RIFA 2021 | 2021 | nationality, resident_count_male, resident_count_female, permits_granted_male, permits_granted_female | 🟡 Em revisão | [Tabata Zardi](https://github.com/zarditab) |
| F001 | D021 | [rifa_2022_pg56_residents_by_nationality_gender.csv](/data/2-clean/sef/rifa_2022_pg56_residents_by_nationality_gender.csv) | SEF - RIFA 2022 | 2022 | nationality, resident_count_male, resident_count_female, permits_granted_male, permits_granted_female | 🟡 Em revisão | [Tabata Zardi](https://github.com/zarditab) |
| F002 | D022 | [rma_2023_pg36_residents_by_nationality_gender.csv](/data/2-clean/aima/rma_2023_pg36_residents_by_nationality_gender.csv) | AIMA - RMA 2023 | 2023 | nationality, resident_count_male, resident_count_female, permits_granted_male, permits_granted_female | 🟡 Em revisão | [Tabata Zardi](https://github.com/zarditab) |
| F002 | D024 | [rma_2024_pg37_residents_by_nationality_gender.csv](/data/2-clean/aima/rma_2024_pg37_residents_by_nationality_gender.csv) | AIMA - RMA 2024 | 2024 | nationality, resident_count_male, resident_count_female, permits_granted_male, permits_granted_female | 🟡 Em revisão | [Tabata Zardi](https://github.com/zarditab) |
| F002 | D025 | [rma_2024_annex_foreign_population_by_municipality.csv](/data/2-clean/aima/rma_2024_annex_foreign_population_by_municipality.csv) | AIMA - População Estrangeira Residente por Concelho 2024 | 2024 | district, municipality, resident_foreign_population | 🟡 Em revisão | [Tabata Zardi](https://github.com/zarditab) |
| F001, F002 | D111 | [residents_permits_nationality_and_gender_2015_2024.csv](/data/2-clean/aima_sef/residents_permits_nationality_and_gender_2015_2024.csv) | SEF (RIFA) + AIMA (RMA) — combinado | 2015–2024 | year, nationality, gender, permits_granted, resident_count | 🟡 Em revisão | [Tabata Zardi](https://github.com/zarditab) |
| F002 | D113 | [series_resident_population_evolution_1980_2024.csv](/data/2-clean/aima_sef/series_resident_population_evolution_1980_2024.csv) | AIMA RMA 2023 (D023) + RMA 2024 (D112) — combinado | 1980–2024 | year, resident_count, report_id, source_id, revised, difference_absolute, methodology_break | 🟡 Em revisão | [Tabata Zardi](https://github.com/zarditab) |
| F002 | D114 | [comparison_rma2023_rma2024.csv](/data/2-clean/aima_sef/comparison_rma2023_rma2024.csv) | AIMA RMA 2023 (D023) + RMA 2024 (D112) — comparação/auditoria | 1980–2024 | year, resident_count_rma_2023, resident_count_rma_2024, difference_absolute, difference_percentual, material_revision_5pct, notes | 🟡 Em revisão | [Tabata Zardi](https://github.com/zarditab) |