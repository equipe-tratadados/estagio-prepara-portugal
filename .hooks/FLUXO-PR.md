# 📋 Fluxo de Perguntas para Pull Request

Este documento mostra o fluxo de construção do template de Pull Request durante o commit.

## 🎯 Diagrama do Fluxo da PR

```mermaid
flowchart TD
    Start([📝 Construção da PR iniciada]) --> TipoPR
    
    TipoPR[📋 TIPO DE ALTERAÇÃO<br/>Escolha o número:]
    TipoPR --> OpTipoPR["1. Adição de dados<br/>2. Limpeza/Tratamento de dados existentes<br/>3. Script novo/atualizado<br/>4. Documentação<br/>5. Correção<br/>6. Entrega"]
    
    OpTipoPR --> DescricaoPR[📝 DESCRIÇÃO DA PR<br/>1-2 frases sobre o que foi feito]
    DescricaoPR --> ChecklistCondicional{Qual tipo escolhido?}
    
    ChecklistCondicional -->|1,2,6: Dados/Limpeza/Entrega| CheckDados[✅ Checklist de Dados:<br/>□ data/1-raw/ inalterado<br/>□ CSV: UTF-8, ';', AAAA-MM-DD]
    ChecklistCondicional -->|3: Script| CheckScript[✅ Checklist de Script:<br/>□ Testei localmente]
    ChecklistCondicional -->|4: Docs| CheckDocs[✅ Checklist de Docs:<br/>□ Links e Markdown OK]
    ChecklistCondicional -->|5: Correção| CheckCorrection[✅ Checklist Geral]
    
    CheckDados --> VerificaEntrega{É entrega?}
    VerificaEntrega -->|Sim| CheckEntrega[✅ Checklist adicional:<br/>□ Atualizei docs/dicionario.md]
    CheckEntrega --> Screenshots
    VerificaEntrega -->|Não| Screenshots
    
    CheckScript --> Screenshots
    CheckDocs --> Screenshots
    CheckCorrection --> Screenshots
    
    Screenshots[📸 SCREENSHOTS opcional<br/>Links ou descrição de imagens<br/>Default: N/A]
    Screenshots --> Dependencias
    
    Dependencias[🔗 DEPENDÊNCIAS opcional<br/>Links para PRs relacionadas<br/>Default: N/A]
    Dependencias --> MontaTemplate
    
    MontaTemplate[📄 MONTA TEMPLATE FINAL] --> TemplateCompleto
    
    TemplateCompleto["## 📌 Descrição da PR
    [descrição inserida]
    
    ## Tipo de alteração
    - [x] **[tipo escolhido]**
    
    ## Checklist de qualidade
    #### Obrigatório para TODAS as PRs:
    - [ ] A branch está atualizada com main
    
    [Checklists condicionais específicos]
    
    ## Tarefa relacionada:
    [ID_TAREFA capturado no commit]
    
    ## Screenshots
    [screenshots]
    
    ## Dependências
    [dependências]"]
    
    TemplateCompleto --> SalvaRascunho[💾 Salva em .github/pr-drafts/<br/>pr-YYYYMMDD_HHMMSS.md]
    SalvaRascunho --> Notificacao[ℹ️ Mostra caminho do rascunho<br/>e instrução para copiar]
    Notificacao --> Fim
    
    Fim([✅ Rascunho de PR criado!<br/>Template original preservado])
    
    style Start fill:#4CAF50
    style Fim fill:#4CAF50
    style TipoPR fill:#2196F3
    style DescricaoPR fill:#2196F3
    style MontaTemplate fill:#FF9800
    style SalvaRascunho fill:#9C27B0
```

## 📊 Detalhamento das Perguntas

### 1️⃣ **Tipo de Alteração** (Obrigatório)

**Pergunta:** "Tipo de mudança:"

**Opções (alinhadas com CONTRIBUTING.md):**
1. **Adição de dados** - Adicionar novos datasets
2. **Limpeza/Tratamento de dados existentes** - Processar dados em data/2-clean/
3. **Script novo/atualizado** - Criar ou modificar scripts
4. **Documentação** - Mudanças em docs, reports, README
5. **Correção** - Ajuste pontual em dados ou script
6. **Entrega** - Movendo arquivos para data/3-delivery/

**Exemplo de saída:** `Adição de dados`

---

### 2️⃣ **Descrição da PR** (Opcional)

**Pergunta:** "Digite a descrição (ou ENTER para pular):"

**O que incluir:**
- Contexto da mudança
- Motivação
- Pense em quem vai revisar

**Exemplo:**
```
Esta PR adiciona o dataset de população do INE para análise
de padrões migratórios em Portugal no período 2020-2024.
```

---

### 3️⃣ **Checklists Condicionais** (Automático)

O sistema monta checklists **automaticamente** baseado no tipo escolhido:

#### 📊 Para: Adição de dados, Limpeza, Entrega

```markdown
#### Aplicável apenas para **dados** (CSV, Excel, etc.):
- [ ] Os arquivos em `data/1-raw/` permanecem **inalterados**
- [ ] O CSV segue o padrão: UTF-8, separador `;`, datas `AAAA-MM-DD`
```

**Se for Entrega, adiciona:**
```markdown
#### Aplicável apenas para **dados que vão para `delivery/`**:
- [ ] Atualizei `docs/dicionario.md`
```

#### 💻 Para: Script novo/atualizado

```markdown
#### Aplicável apenas para **scripts**:
- [ ] Testei localmente o funcionamento do script
```

#### 📝 Para: Documentação

```markdown
#### Aplicável apenas para **documentação**:
- [ ] Verifiquei links e formatação Markdown
```

#### 🔧 Para: Correção

Usa apenas checklist geral (branch atualizada).

---

### 4️⃣ **Screenshots** (Opcional)

**Pergunta:** "Digite a descrição (ou ENTER):"

**O que incluir:**
- Links para imagens (hospedadas no GitHub, Imgur, etc.)
- Descrição breve se não houver imagens
- Digite N/A se não aplicável

**Exemplo:**
```
![Dashboard atualizado](https://i.imgur.com/exemplo.png)

Gráfico mostra distribuição populacional por região.
```

---

### 5️⃣ **Dependências** (Opcional)

**Pergunta:** "Digite (ou ENTER):"

**O que incluir:**
- Links para outras PRs que devem ser mergeadas primeiro
- Issues relacionadas
- N/A se não houver

**Exemplo:**
```
https://github.com/equipe-tratadados/estagio-prepara-portugal/pull/42
```

---

## 📄 Template Final Gerado

### Exemplo Completo

```markdown
## 📌 Descrição da PR
<!-- Descreve em 1-2 frases o que foi feito -->

Esta PR adiciona o dataset de população do INE para análise
de padrões migratórios em Portugal no período 2020-2024.

## Tipo de alteração
- [x] **Adição de dados**

## Checklist de qualidade

#### Obrigatório para TODAS as PRs:
- [ ] A branch está atualizada com `main`

#### Aplicável apenas para **dados** (CSV, Excel, etc.):
- [ ] Os arquivos em `data/1-raw/` permanecem **inalterados**
- [ ] O CSV segue o padrão: UTF-8, separador `;`, datas `AAAA-MM-DD`

## Tarefa relacionada:
DP-012

## Screenshots (se aplicável)
![Dashboard atualizado](https://i.imgur.com/exemplo.png)

## Dependências
https://github.com/equipe-tratadados/estagio-prepara-portugal/pull/41
```

---

## 💾 Onde o Template é Salvo

### Localização
```
.github/pr-drafts/pr-20260630_184500.md
```

### Por que Rascunho?
- ✅ **NÃO sobrescreve** `.github/pull_request_template` do projeto
- ✅ Mantém template original intocado
- ✅ Gera timestamp único
- ✅ Fácil de copiar quando abrir PR no GitHub

### Mensagem Mostrada
```
✅ Rascunho da PR salvo em: .github/pr-drafts/pr-20260630_184500.md
ℹ️  Copie este conteúdo ao abrir a PR no GitHub!
ℹ️  O template padrão em .github/pull_request_template será preenchido automaticamente
```

---

## 🔄 Integração com Git Commit

O template de PR é construído **durante o commit** usando dados capturados:

### Dados Reutilizados

| De onde vem | O que captura | Onde usa na PR |
|-------------|---------------|----------------|
| `perguntar_tipo()` | Tipo de commit (dados, script, etc.) | Sugere tipo similar na PR |
| `perguntar_id_tarefa()` | ID da tarefa (DP-012) | Campo "Tarefa relacionada" |
| `perguntar_resumo()` | Resumo do commit | Pode sugerir descrição |
| Análise de arquivos | Tipo de arquivos modificados | Determina checklist condicional |

---

## 📋 Comparação: Template do Projeto vs Template Gerado

### Template Original (Preservado)
```
.github/pull_request_template
```
- ✅ Mantém formato definido pela equipe
- ✅ Usado automaticamente pelo GitHub
- ✅ Nunca é modificado pelos hooks

### Template Gerado (Rascunho)
```
.github/pr-drafts/pr-YYYYMMDD_HHMMSS.md
```
- ✅ Pré-preenchido com dados do commit
- ✅ Checklists condicionais baseados no tipo
- ✅ Inclui ID da tarefa automaticamente
- ✅ Usuário copia conteúdo ao abrir PR

---

## 🎯 Fluxo Completo: Commit → PR

```mermaid
sequenceDiagram
    participant U as Usuário
    participant H as Hook (prepare-commit-msg)
    participant CB as commit-builder.sh
    participant PRB as pr-builder.sh
    participant F as Filesystem
    
    U->>H: git commit
    H->>CB: Captura tipo: "dados"
    H->>CB: Captura ID: "DP-012"
    H->>CB: Captura resumo: "Adiciona dataset INE"
    CB->>H: Retorna mensagem de commit
    
    H->>PRB: Inicia construção da PR
    PRB->>U: Pergunta tipo de alteração
    U->>PRB: Escolhe "Adição de dados"
    PRB->>U: Pergunta descrição
    U->>PRB: Fornece descrição
    PRB->>PRB: Monta checklist condicional (dados)
    PRB->>PRB: Inclui ID_TAREFA: "DP-012"
    PRB->>F: Salva em .github/pr-drafts/pr-TIMESTAMP.md
    PRB->>U: Mostra caminho do rascunho
    
    Note over U,PRB: Template original em .github/pull_request_template<br/>permanece intocado!
    
    U->>U: Abre PR no GitHub
    U->>U: Copia conteúdo do rascunho
    U->>U: Cola no editor de PR
```

---

## ✅ Melhores Práticas

### Ao Criar uma PR

1. ✅ **Use o rascunho gerado** - Já vem pré-preenchido
2. ✅ **Revise os checklists** - Marque apenas o que se aplica
3. ✅ **Adicione screenshots** - Se mudanças visuais
4. ✅ **Referencie tarefas** - ID já está incluído
5. ✅ **Mantenha < 400 linhas** - Facilita revisão

### Para Revisores

1. ✅ **Verifique checklists** - Todos marcados?
2. ✅ **Valide arquivos de dados** - data/1-raw/ intocado?
3. ✅ **Teste scripts** - Se aplicável
4. ✅ **Revise documentação** - Links funcionam?
5. ✅ **Aprove ou solicite mudanças** - Feedback construtivo

---

## 🚀 Resultado Final

Ao final do processo:

- ✅ Commit criado com mensagem estruturada
- ✅ Rascunho de PR gerado automatically
- ✅ Template do projeto preservado
- ✅ Checklists relevantes incluídos
- ✅ ID da tarefa propagado
- ✅ Pronto para abrir PR no GitHub! 🎉
