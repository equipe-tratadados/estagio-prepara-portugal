# Log de Coleta

> **📖 Como usar este log**
>
> 1. Este é um ficheiro **partilhado por todo o grupo**. Não crie ficheiros de log separados, todos escrevem aqui.
> 2. **Cada arquivo baixado para o projeto = uma linha nova** nesta tabela. Acrescente a linha por baixo das que já existem.
> 3. Preencha **todas** as colunas. Se uma coluna não se aplicar, escreva "Não aplicável" ou "Nenhuma", nunca deixe em branco.
> 4. Na coluna **Ficheiro**, ponha o nome do arquivo como link para onde ele está no GitHub, no formato `nome.csv`.
> 5. A coluna **Data de coleta** é o dia em que realmente fez o download do ficheiro (AAAA-MM-DD), não a data do relatório original.
> 6. Em **Transformações** e **Limitações** com vários itens, separe-os com `<br>` para não partir a tabela.
> 7. Faça commit assim que acrescentar uma linha, para que o resto do grupo veja o registo atualizado.

> ### Tabela de Exemplo:
>
>| Fonte Id | Ficheiro | Fonte | URL | Data de coleta | Período dos dados | Transformações aplicadas | Limitações conhecidas | Responsável |
>| :------- | :------- | :---- | :-- | :------------- | :---------------- | :----------------------- | :-------------------- | :---------- |
>| F001 | residents_by_nationality_2024.csv | AIMA, Relatório de Imigração e Asilo 2024 | https://www.aima.gov.pt/... | 2026-05-26 | 2015 a 2024 | - Removidas linhas de totais e subtotais<br>- Coluna "País de origem" renomeada para "nationality"<br>- Valores monetários convertidos de milhares para euros (×1000) | Dados de 2024 são preliminares (publicação definitiva em set/2026) | [nome do estagiário] |

## 📝 Log de Coleta (a preencher)

| Fonte Id | Ficheiro | Fonte | URL | Data de coleta | Período dos dados | Transformações aplicadas | Limitações conhecidas | Responsável |
| :------- | :------- | :---- | :-- | :------------- | :---------------- | :----------------------- | :-------------------- | :---------- |
| F012 | pool_imigrantes_cidadania.csv | Eurostat | https://ec.europa.eu/eurostat/databrowser/view/migr_imm1ctz/default/table?lang=en | 18-06-2026 | 2015–2024 | Nenhuma | Os dados têm comparabilidade limitada entre países devido a diferenças metodológicas e quebras na série temporal, e não capturam imigração irregular nem garantem cobertura completa de todas as cidadanias de origem | Nubia Almeida |
| F012 | emprego_setor_nacionalidade.csv | Eurostat | https://ec.europa.eu/eurostat/databrowser/view/lfsa_egan2/default/table?lang=en | 18-06-2026 | 2016–2025 | Nenhuma | Os dados excluem imigrantes de cidadanias específicas. | Nubia Almeida |
| F012 | pib_pais_anual.csv | Eurostat | https://ec.europa.eu/eurostat/databrowser/view/NAMA_10_GDP/default/table?lang=en | 18-06-2026 | 2016–2025 | Nenhuma | O indicador não captura informalidade económica nem bem-estar, limitando interpretações além do crescimento macroeconómico. | Nubia Almeida |
| F012 | pib_pais_trimestral.csv | Eurostat | https://ec.europa.eu/eurostat/databrowser/view/namq_10_gdp/default/table?lang=en | 18-06-2026 | 2023–2026 | Nenhuma | Não informada. | Nubia Almeida |
| F017 | number_immigrants_arriving_country.csv | Eurostat | https://ec.europa.eu/eurostat/databrowser/view/migr_pop3ctb/default/table?lang=en | 18-06-2026 | 2016–2025 | Nenhuma | Requer filtragem (ex.: total vs. subcategorias de idade, sexo e nacionalidade); necessita limpeza e normalização para séries temporais comparáveis. | Nubia Almeida |
| F018 | populacao_imigrante_pais.csv | Eurostat | https://ec.europa.eu/eurostat/databrowser/view/tps00176/default/table?lang=en | 18-06-2026 | 2013–2024 | Nenhuma | Não mede diretamente taxa de crescimento (exige cálculo adicional como variação percentual ou CAGR); possíveis diferenças metodológicas entre países. | Nubia Almeida |
