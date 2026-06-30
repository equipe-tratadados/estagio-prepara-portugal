# 🚀 Como Executar os Scripts de Teste

## ⚠️ IMPORTANTE: Use o Git Bash, não o CMD.exe

Os scripts de teste usam **cores e formatação especial** que só funcionam no Git Bash.

---

## ✅ Método Correto (Git Bash)

### **Windows:**

1. **Abra o Git Bash:**
   - Clique com botão direito na pasta do projeto
   - Selecione **"Git Bash Here"**

2. **Execute o script de teste:**
   ```bash
   bash .hooks/testar-interface.sh
   ```

3. **Pronto!** Agora você verá as cores e formatação corretamente.

---

### **Linux/macOS:**

```bash
bash .hooks/testar-interface.sh
```

Ou torne executável:
```bash
chmod +x .hooks/testar-interface.sh
./.hooks/testar-interface.sh
```

---

##   ❌ NÃO Use o CMD.exe (Prompt de Comando)

Se você executar no **cmd.exe** do Windows, verá códigos estranhos como:
```
\033[1m1\033[0m - Testar UI/UX
```

Isso acontece porque o cmd.exe **não suporta cores ANSI**.

---

## 🧪 Scripts Disponíveis

| Script | Descrição | Como Executar |
|--------|-----------|---------------|
| `testar-interface.sh` | Teste interativo completo | `bash .hooks/testar-interface.sh` |
| `testar_hooks.sh` | Testes automatizados | `bash testar_hooks.sh` |
| `install.sh` | Instalador dos hooks | `bash .hooks/install.sh` |

---

## 🎯 Para Testar um Commit Real

**No Git Bash:**

```bash
# 1. Crie um arquivo de teste
echo "Teste" > teste.txt

# 2. Adicione ao stage
git add teste.txt

# 3. Faça o commit (hooks serão executados automaticamente)
git commit

# 4. Depois do teste, desfaça o commit
git reset HEAD~1
rm teste.txt
```

---

## 🔍 Verificar se Está no Git Bash

Execute este comando:
```bash
echo $BASH_VERSION
```

- ✅ **Se mostrar uma versão** (ex: `5.0.17`) → Você está no Git Bash
- ❌ **Se aparecer erro ou nada** → Você está no cmd.exe

---

## 📺 Diferença Visual

### **Git Bash (Correto):**
```
================================================================================
  📌 PASSO 1/4: TIPO DE COMMIT
================================================================================

  1. dados - Adicionar ou atualizar ficheiros em data/
  2. limpeza - Scripts ou alterações em data/2-clean/
```

### **CMD.exe (Incorreto):**
```
\033[0;34m================================================================================\033[0m
  \033[1m1\033[0m. \033[0;36mdados\033[0m - Adicionar ou atualizar
```

---

## 🆘 Solução Rápida

Se você viu códigos estranhos, faça isto:

1. **Feche o terminal atual** (cmd.exe)
2. **Abra o Git Bash:**
   - Pressione `Win + R`
   - Digite: `"C:\Program Files\Git\git-bash.exe"`
   - Ou clique com botão direito na pasta → "Git Bash Here"
3. **Execute novamente:**
   ```bash
   bash .hooks/testar-interface.sh
   ```

---

## ✅ Como Saber se Está Funcionando

No **Git Bash correto**, você verá:
- ✅ Cores (verde, azul, amarelo, vermelho)
- ✅ Emojis (🚀, ✅, ❌, ⚠️, 📌)
- ✅ Linhas decorativas (====, ----)
- ✅ Texto em negrito

No **cmd.exe incorreto**, você verá:
- ❌ Códigos estranhos (`\033[1m`, `\033[0;32m`)
- ❌ Formatação quebrada
- ❌ (Mas os emojis ainda aparecem)

---

## 📚 Mais Informações

- **Fluxo de Commits:** [.hooks/FLUXO-COMMIT.md](.hooks/FLUXO-COMMIT.md)
- **Fluxo de PRs:** [.hooks/FLUXO-PR.md](.hooks/FLUXO-PR.md)
- **README Principal:** [README.md](README.md)
- **Guia de Contribuição:** [CONTRIBUTING.md](CONTRIBUTING.md)

---

## 🎓 Resumo

| Quer | Use |
|------|-----|
| Testar sem commit | `bash .hooks/testar-interface.sh` no **Git Bash** |
| Fazer commit real | `git commit` (funciona em qualquer terminal) |
| Instalar hooks | `bash .hooks/install.sh` no **Git Bash** |
| Verificar testes | `bash testar_hooks.sh` no **Git Bash** |

**Lembre-se:** Sempre use **Git Bash** para scripts `.sh`, nunca cmd.exe! 🎯
