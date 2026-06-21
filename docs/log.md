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
|          |          |       |     |                |                   |     
| Fonte Id | Ficheiro                                    | Fonte                                                       | URL                                                                                                            
| F012    | data/1-raw/eurostat/pib_pais_trimestral.csv | Eurostat – Gross Domestic Product (GDP) and main components | [https://ec.europa.eu/eurostat/databrowser/product/view/namq_10_gdp](https://ec.europa.eu/eurostat/databrowser/product/view/namq_10_gdp) | 18-06-2026     | 2023–2026         | Nenhuma                  | Não informadas.       | Nubia Almeida (https://github.com/asalmenubia)) |
|                       |             |
| Fonte Id | Ficheiro | Fonte | URL                                                                                                                                                                    | Data de coleta | Período dos dados | Transformações aplicadas | 
| F012     | data/1-raw/eurostat/pool_imigrantes_cidadania.csv | Eurostat – Immigration by citizenship | [https://ec.europa.eu/eurostat/databrowser/view/migr_imm1ctz/default/table?lang=en](https://ec.europa.eu/eurostat/databrowser/view/migr_imm1ctz/default/table?lang=en) | 18-06-2026     | 2015–2024         | Nenhuma                  | Não informadas        | Nubia Almeida ([https://github.com/asalmenubia](https://github.com/asalmenubia)) |

| Fonte Id | Ficheiro                                         | Fonte                                               | URL                                                                                                                                                            | Data de coleta | Período dos dados | Transformações aplicadas | Limitações conhecidas                                                                                                                                 | Responsável                                                                      |
| -------- | ------------------------------------------------ | --------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- | ----------------- | ------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------- |
| F017     | data/1-raw/eurostat/populacao_imigrante_pais.csv | Eurostat – Number of immigrants arriving by country | [https://ec.europa.eu/eurostat/databrowser/view/tps00176/default/table?lang=en](https://ec.europa.eu/eurostat/databrowser/view/tps00176/default/table?lang=en) | 18-06-2026     | 2013–2024         | Nenhuma                  | Não mede diretamente taxa de crescimento (exige cálculo adicional como variação percentual ou CAGR); possíveis diferenças metodológicas entre países. | Nubia Almeida ([https://github.com/asalmenubia](https://github.com/asalmenubia)) |

 Fonte Id | Ficheiro                                         | Fonte                                               | URL                                                                                                                                                            | Data de coleta | Período dos dados | Transformações aplicadas | Limitações conhecidas                                                                                                                                 | Responsável                                                                      |
| -------- | ------------------------------------------------ | --------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- | ----------------- | ------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------- |
| Fonte Id | Ficheiro                                            | Fonte                                           | URL                                                                                                                                                                | Data de coleta | Período dos dados | Transformações aplicadas | Limitações conhecidas | Responsável                                                                      |
| -------- | --------------------------------------------------- | ----------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------ | -------------- | ----------------- | ------------------------ | --------------------- | -------------------------------------------------------------------------------- |
| F012     | data/1-raw/eurostat/emprego_setor_nacionalidade.csv | Eurostat – Employment by sector and nationality | [https://ec.europa.eu/eurostat/databrowser/view/lfsa_egan2/default/table?lang=en](https://ec.europa.eu/eurostat/databrowser/view/lfsa_egan2/default/table?lang=en) |                | 2016–2025         | Nenhuma                  | Não informada         | Nubia Almeida ([https://github.com/asalmenubia](https://github.com/asalmenubia)) |

| Fonte Id | Ficheiro                               | Fonte                         | URL                                                                                                                                                                  | Data de coleta | Período dos dados | Transformações aplicadas | Limitações conhecidas | Responsável                                                                      |
| -------- | -------------------------------------- | ----------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- | ----------------- | ------------------------ | --------------------- | -------------------------------------------------------------------------------- |
| F012     | data/1-raw/eurostat/pib_pais_anual.csv | Eurostat – PIB anual por país | [https://ec.europa.eu/eurostat/databrowser/view/NAMA_10_GDP/default/table?lang=en](https://ec.europa.eu/eurostat/databrowser/view/NAMA_10_GDP/default/table?lang=en) | 18-06-2026     | 2016–2025         | Nenhuma                  | Não informada         | Nubia Almeida ([https://github.com/asalmenubia](https://github.com/asalmenubia)) |






