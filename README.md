![Estágio](https://img.shields.io/badge/Est%C3%A1gio-Prepara_Portugal-2C5F8A?labelColor=EDE0C8) ![Status](https://img.shields.io/badge/Status-Em_desenvolvimento-C17A26?labelColor=EDE0C8) ![Grupo](https://img.shields.io/badge/Grupo_1-Coleta_%26_Tratamento-4A7C5F?labelColor=EDE0C8)

# Grupo 1 - Coleta e Tratamento de Dados

🟡 Em desenvolvimento · Grupo 1 · Coleta e Tratamento de Dados · Prepara Portugal

Trabalho de coleta, limpeza e tratamento de dados, desenvolvido no contexto do Programa de Estágio da Prepara Portugal.

---

## Contexto

O programa de estágio tem como objetivo final a construção de um **dashboard interativo sobre imigração em Portugal**, alimentado por dados reais e atualizados.

O projeto está dividido em três grupos com responsabilidades sequenciais:

| Grupo | Responsabilidade |
|---|---|
| **Grupo 1 — Coleta e Tratamento** | Identificar fontes, recolher dados, tratá-los e entregá-los limpos e documentados |
| Grupo 2 - Visualização dos Dados | Criação de dashboards e gráficos interativos |
| Grupo 3 - Produção de Conteúdo Analítico | Criação de artigos, textos e conteúdos a partir das análises realizadas. |

Este repositório é o espaço de trabalho do **Grupo 1**. Os dados que produzimos alimentam as etapas seguintes, por isso a qualidade, rastreabilidade e documentação de todo o processo é prioridade.

---

## Fluxo dos dados

Os dados percorrem três etapas dentro do repositório, correspondendo às fases do CRISP-DM:

```
data/1-raw/   →   data/2-clean/   →   data/3-delivery/
    ↑                  ↑                   ↑
Data Understanding  Data Preparation     Entrega
(fonte original,    (limpeza e          (CSVs validados
 nunca editar)       padronização)       para os outros grupos)
```

---

## Estrutura do Repositório

```
repositorio/
│
├── data/
│   ├── 1-raw/          ← dados originais, tal como chegam da fonte (nunca editar)
│   ├── 2-clean/        ← dados em tratamento
│   ├── 3-delivery/     ← CSVs validados e prontos a entregar
│   └── metadata/
│
├── scripts/
│   ├── coleta/         ← scripts de recolha de dados
│   └── limpeza/        ← scripts de tratamento e padronização
│
├── docs/
│   ├── biblioteca.md   ← catálogo de fontes identificadas (antes da coleta)
│   ├── log.md          ← registo de cada ficheiro descarregado
│   └── dicionario.md   ← descrição dos datasets entregues
│
├── notebooks/          ← exploração e prototipagem
├── reports/
│   ├── analise-exploratoria/
│   └── validacao/
│
├── CONTRIBUTING        ← como trabalhar neste repositório
└── README.md           ← este ficheiro
```

### Documentação essencial

- **[`docs/biblioteca.md`](docs/biblioteca.md)** — catálogo de fontes de dados relevantes sobre imigração em Portugal. É o ponto de partida antes de qualquer coleta: diz a toda a equipa onde está cada tipo de dado e que fontes existem para cada tema.

- **[`docs/log.md`](docs/log.md)** — log de coleta partilhado. Cada ficheiro descarregado para o projeto ocupa uma linha, com fonte, link, data, período coberto, alterações feitas e limitações conhecidas.

- **[`docs/dicionario.md`](docs/dicionario.md)** — tabela dos datasets já recolhidos, com fonte, período, colunas principais e estado atual.

---

## Mapa da documentação

| Documento | Para que serve | Onde |
|---|---|---|
| [`docs/biblioteca.md`](docs/biblioteca.md) | Catálogo de fontes a consultar antes de qualquer coleta | Repositório |
| [`docs/log.md`](docs/log.md) | Registo linha-a-linha de cada ficheiro descarregado | Repositório |
| [`docs/dicionario.md`](docs/dicionario.md) | Descrição dos datasets entregues e seu estado | Repositório |
| [`CONTRIBUTING`](CONTRIBUTING) | Regras de branches, commits e pull requests | Repositório |
| Convenções e guias | Padrões de código, nomenclatura e boas práticas | Notion |
| Tasks e acompanhamento | Trabalho em curso, sprints e responsáveis | Notion |

---

## Fontes de dados

Os dados são recolhidos exclusivamente de fontes oficiais portuguesas e européias.

---

## Equipa e contatos

| Nome | GitHub |
|---|---|
| **Ana Cláudia Sevalho** | *[@anaclaudiasevalho](https://github.com/anaclaudiasevalho-creator)* | 
| **Antony Ferreira** | *[@antonyfferreira](https://github.com/antonyfferreira)* |
| **Germano Silva** | *[@Germano-Silva](https://github.com/Germano-Silva)* |
| **Nubia Almeida** | *[@asalmenubia](https://github.com/asalmenubia)* |
| **Patricia Duarte** | *[@patriciaduarte-hub](https://github.com/patriciaduarte-hub)* |
| **Tabata Zardi** | *[@zarditab](https://github.com/zarditab)* |
| **Grupo 1** | *[@equipe-tratadados](https://github.com/equipe-tratadados)* |

Para questões internas da equipa, usa o canal no Notion ou este repositório.
Para questões relacionadas com o programa: **dadoseti@preparaportugal.com**

---

*Este repositório está em constante atualização.*
