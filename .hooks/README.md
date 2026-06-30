# 🎓 Hooks de Commit para Ciência de Dados

Sistema completo de hooks Git para padronizar commits, validar dados e facilitar colaboração em projetos de Ciência de Dados.

## 🚀 Instalação Rápida

Via terminal (qualquer sistema operacional, requer Git instalado):

```bash
# Na raiz do seu repositório
bash .hooks/install.sh
```

Ou, se preferir não usar o terminal, dê duplo clique no instalador correspondente
ao seu sistema operacional (ambos estão na raiz do repositório e apenas chamam
`.hooks/install.sh` por baixo dos panos):

| Sistema | Arquivo |
|---|---|
| macOS | `Instalar (macOS).command` |
| Windows | `Instalar (Windows).bat` (requer Git para Windows / Git Bash já instalado) |
| Linux | `Instalar (Linux).sh` — pode ser necessário marcar "permitir execução" antes do primeiro duplo clique; veja o comentário no início do arquivo |

> Não existe um único arquivo que funcione com duplo clique nos três sistemas ao
> mesmo tempo — cada SO tem seu próprio mecanismo de execução (`.bat`/`.cmd` no
> Windows, `.command` no macOS, permissão de execução + preferência do
> gerenciador de arquivos no Linux). Por isso há um launcher por sistema, todos
> chamando o mesmo `.hooks/install.sh`.
>
> O antigo `instalar.sh` na raiz (versão simplificada e não documentada) foi
> removido — use sempre `.hooks/install.sh` ou um dos launchers acima.

## ✨ O que o sistema faz

A cada `git commit`, o hook `prepare-commit-msg` conduz um fluxo interativo que:

1. **Analisa os arquivos em stage** — identifica arquivos de dados, avisa sobre arquivos grandes (> 50MB) ou bloqueia arquivos muito grandes (> 100MB), e oferece mover arquivos de dados para o Git LFS.
2. **Valida os arquivos** — checagens gerais (`file-validator.sh`) e validações técnicas de CSV/Markdown (`tech-validator.sh`): separador correto, cabeçalho sem acentos, formatação de tabelas, etc.
3. **Cria um backup/ponto de restauração** antes do commit (se `BACKUP_ENABLED=true`).
4. **Monta a mensagem de commit** seguindo a Convenção do Angular, perguntando: tipo, ID da tarefa, escopo, resumo e corpo.
5. **Prepara o template de Pull Request**, se aplicável (tipo de mudança, descrição, screenshots, dependências).
6. **Pergunta se você quer revisar manualmente** a mensagem final antes de confirmar.

Para commits triviais, existe um **modo rápido** (`quick-mode.sh`) que pula a maior parte do fluxo.

## 🧩 Estrutura

```
.hooks/
├── install.sh              # Instalador oficial (dependências, LFS, template de PR)
├── prepare-commit-msg      # Hook principal — roda o fluxo interativo
├── commit-msg               # Hook de validação da mensagem final
├── post-commit, post-merge, post-checkout, pre-push
├── modules/
│   ├── config.sh             # Configurações gerais (limites, tipos de commit, flags)
│   ├── ui.sh                 # Funções de interface (menus, cores, prompts)
│   ├── file-manager.sh       # Análise e seleção de arquivos em stage
│   ├── file-validator.sh     # Validações gerais de arquivo (tamanho, etc.)
│   ├── tech-validator.sh     # Validações técnicas de CSV/Markdown
│   ├── commit-builder.sh     # Construção da mensagem de commit
│   ├── pr-builder.sh         # Construção do template de PR
│   ├── lfs-helper.sh         # Integração com Git LFS
│   ├── mlflow-helper.sh      # Integração com MLflow/DVC
│   ├── backup-manager.sh     # Backup e pontos de restauração
│   ├── notifier.sh           # Notificações (Slack/Teams)
│   ├── quick-mode.sh         # Modo rápido para commits triviais
│   ├── plugin-system.sh      # Sistema de plugins
│   ├── logger.sh             # Log de auditoria
│   └── rollback.sh           # Rollback de commits/backups
├── plugins/
│   └── example-plugin.sh     # Exemplo de plugin
├── logs/                      # Criado na instalação
└── backups/                   # Criado na instalação
```

## ⚙️ Configuração

Todas as configurações ficam em `.hooks/modules/config.sh`. Principais flags:

| Variável | Padrão | Descrição |
|---|---|---|
| `LIMITE_AVISO_MB` | `50` | Avisa se um arquivo em stage for maior que isso |
| `LIMITE_BLOQUEIO_MB` | `100` | Bloqueia o commit se um arquivo for maior que isso |
| `VALIDACAO_TECNICA_OBRIGATORIA` | `true` | Se `true`, erros de validação de CSV/Markdown podem cancelar o commit (o usuário ainda pode optar por ignorar quando perguntado) |
| `BACKUP_ENABLED` | `true` | Cria backup/ponto de restauração antes de cada commit |
| `QUICK_MODE_ENABLED` | `true` | Habilita o modo rápido para commits pequenos |
| `MLFLOW_ENABLED`, `DVC_ENABLED` | `true` | Integrações com MLflow/DVC |
| `NOTIFICAR_SLACK`, `NOTIFICAR_TEAMS` | `false` | Notificações por webhook |

## 🧪 Testes

```bash
bash testar_hooks.sh
```

Roda uma bateria de testes sobre as validações de CSV/Markdown e checagens estruturais dos hooks principais.

## 🤝 Contribuindo

Convenções do projeto (ver comentários em `modules/ui.sh` para mais detalhes):

- Funções de **interface** (menus, mensagens de sucesso/erro/aviso) sempre escrevem em `stderr`, nunca em `stdout` — isso evita que sejam capturadas por engano quando chamadas dentro de `$(...)`.
- Funções que **retornam um valor** (como `selecionar_opcao` e `human_readable`) usam `stdout` exclusivamente para o valor em si, sem nenhum texto decorativo misturado.
- Novas validações técnicas devem ser adicionadas em `tech-validator.sh` e registradas em `executar_validacoes_tecnicas`, que já é chamada pelo hook principal.
