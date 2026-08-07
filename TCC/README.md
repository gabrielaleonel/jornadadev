# TCC — Controle ISO 9001 (Harbour/ADVPL)

> **Aluna:** Gabriela Oliveira · Programa START — TOTVS Paulista
> **Módulo:** Compras (SIGACOM) · **Entrega:** TCC — Trabalho de Conclusão de Curso

---

## 1. Descrição do sistema

A **Indústria XYZ** precisa monitorar as **não conformidades na entrada de materiais** dos seus fornecedores para manter a certificação **ISO 9001**. O sistema registra:

- os **certificados de qualidade** dos fornecedores; e
- as **ocorrências de não conformidade** em cada entrega.

Para isso foram criadas duas tabelas customizadas (`Z` = personalização de cliente):

| Tabela | Descrição | Vinculada a |
|--------|-----------|-------------|
| **ZZ1** — Controle de Fornecimento | certificado + tolerância + totais por controle | Cadastro de Fornecedores (**SA2**) |
| **ZZ2** — Ocorrências do Fornecedor | ocorrências por entrega (produto, quantidades, valores) | **ZZ1**, **SA2** e Cadastro de Produtos (**SB1**) |

> ⚠️ **Sem ambiente Protheus disponível:** este repositório entrega o dicionário em **CSV** (pasta `Dados-e-Dicionario/`), os fontes `.PRW` **escritos e comentados** (`fontes/`) e a documentação completa. Prints são descritos por escrito em `evidencias/descricao-das-telas.md` (conforme orientação da atividade, a correção lê código e texto, não imagem).

---

## 2. Estrutura do repositório (TCC/)

```
TCC/
├── README.md                       ← este documento
├── README.pdf                      ← modelo de entrega da atividade (validação por IA)
├── rubrica-validacao.pdf           ← rubrica de avaliação (Rev. 1.0)
├── AUTOAVALIACAO.md                ← autoavaliação contra a rubrica
├── Dados-e-Dicionario/
│   ├── converte-dicionario.prg     ← exporta o dicionário/DBFs para CSV
│   ├── converte-dicionario.pdf     ← versão em PDF do utilitário de exportação
│   ├── sx2990.csv                  ← SX2 — tabelas (ZZ1, ZZ2 — Compartilhadas)
│   ├── sx3990.csv                  ← SX3 — campos (tipos, tamanhos, virtuais, X3_VALID)
│   ├── six990.csv                  ← SIX — índices (3 + 3)
│   ├── sx7990.csv                  ← SX7 — gatilhos
│   ├── sxb990.csv                  ← SXB — consultas padrão
│   ├── sigacom.xnu.txt             ← menu do SIGACOM (texto)
│   ├── sa2990.csv                  ← massa de fornecedores (SA2)
│   ├── sb1990.csv                  ← massa de produtos (SB1)
│   ├── zz1990.csv                  ← massa da ZZ1
│   └── zz2990.csv                  ← massa da ZZ2
├── fontes/
│   ├── STTZZLIB.PRW                ← biblioteca de funções comuns (+ classe POO)
│   ├── STTZZ1.PRW                  ← rotina mBrowse da ZZ1
│   └── STTZZ2.PRW                  ← rotinas mBrowse da ZZ2 (geral + filtrada)
└── evidencias/
    └── descricao-das-telas.md      ← passo a passo + resultado esperado das telas
```

---

## 3. Layout das tabelas

As duas tabelas são **compartilhadas** (SX2 → flag de compartilhamento), como pede o enunciado. O prefixo `ZZ`/`ZZ1`/`ZZ2` segue a convenção de tabela customizada do Protheus.

### 3.1 ZZ1 — Controle de Fornecimento

| Campo | Título | Tipo | Tam | Dec | Contexto | Observação |
|-------|--------|------|-----|-----|----------|------------|
| ZZ1_FILIAL | Filial | C | 2 | 0 | Real | Obrigatório |
| ZZ1_CODIGO | Código | C | 6 | 0 | Real | Chave |
| ZZ1_FORNEC | Cód. Fornecedor | C | 6 | 0 | Real | `X3_VALID` → existe na SA2 |
| ZZ1_LOJAFO | Loja Fornecedor | C | 2 | 0 | Real | |
| ZZ1_NOMEFO | Nome Fornecedor | C | 40 | 0 | **Virtual** | busca na SA2 |
| ZZ1_CERTIF | Dados Certificado | C | 256 | 0 | Real | |
| ZZ1_VALCER | Val. Certificado | D | 8 | 0 | Real | `X3_VALID` → ≥ data atual na inclusão |
| ZZ1_TOLERA | Tolerância (%) | N | 5 | 2 | Real | `X3_VALID` → entre 0 e 100 |
| ZZ1_TOTOK | Qtd. Conforme | N | 12 | 2 | Real | |
| ZZ1_TOTNOK | Qtd. Não Conforme | N | 12 | 2 | Real | |

**Índices (SIX):**

| Ordem | Expressão | Descrição |
|-------|-----------|-----------|
| 1 | `ZZ1_FILIAL + ZZ1_CODIGO` | Chave primária |
| 2 | `ZZ1_FILIAL + ZZ1_FORNEC + ZZ1_LOJAFO` | Por fornecedor |
| 3 | `ZZ1_FILIAL + DTOS(ZZ1_VALCER)` | Por validade do certificado |

### 3.2 ZZ2 — Ocorrências do Fornecedor

| Campo | Título | Tipo | Tam | Dec | Contexto | Observação |
|-------|--------|------|-----|-----|----------|------------|
| ZZ2_FILIAL | Filial | C | 2 | 0 | Real | Obrigatório |
| ZZ2_CONFOR | Controle (→ZZ1) | C | 6 | 0 | Real | `X3_VALID` → existe na ZZ1 |
| ZZ2_FORNEC | Cód. Fornecedor | C | 6 | 0 | Real | preenchido por gatilho |
| ZZ2_LOJAFO | Loja Fornecedor | C | 2 | 0 | Real | preenchido por gatilho |
| ZZ2_NOMEFO | Nome Fornecedor | C | 40 | 0 | **Virtual** | busca na SA2 |
| ZZ2_DATA | Data Ocorrência | D | 8 | 0 | Real | `X3_VALID` → não futura; gatilho na inclusão |
| ZZ2_HORA | Hora | C | 5 | 0 | Real | gatilho na inclusão |
| ZZ2_CODPRO | Produto | C | 15 | 0 | Real | `X3_VALID` → existe na SB1 |
| ZZ2_QTDOK | Qtde. Conforme | N | 12 | 0 | Real | |
| ZZ2_QTDNOK | Qtde. Não Conforme | N | 12 | 0 | Real | |
| ZZ2_VLRUNI | Valor Unitário | N | 12 | 2 | Real | |
| ZZ2_TOTOK | R$ Conforme | N | 12 | 2 | **Virtual** | `QTDOK × VLRUNI` |
| ZZ2_TOTNOK | R$ Não Conforme | N | 12 | 2 | **Virtual** | `QTDNOK × VLRUNI` |

**Índices (SIX):**

| Ordem | Expressão | Descrição |
|-------|-----------|-----------|
| 1 | `ZZ2_FILIAL + ZZ2_CONFOR + DTOS(ZZ2_DATA) + ZZ2_HORA` | Chave primária |
| 2 | `ZZ2_FILIAL + ZZ2_FORNEC + ZZ2_LOJAFO + DTOS(ZZ2_DATA)` | Por fornecedor e data |
| 3 | `ZZ2_FILIAL + DTOS(ZZ2_DATA)` | Por data |

> Os CSVs correspondentes ficam em `Dados-e-Dicionario/` (SX2, SX3 e SIX).

---

## 4. Campos virtuais (X3_RELACAO no SX3)

Campos virtuais **não são gravados** no arquivo; o valor é calculado na exibição.

| Campo | Relação (X3_RELACAO) |
|-------|----------------------|
| ZZ1_NOMEFO | `POSICIONE("SA2",1,xFilial("SA2")+M->ZZ1_FORNEC+M->ZZ1_LOJAFO,"A2_NOME")` |
| ZZ2_NOMEFO | `POSICIONE("SA2",1,xFilial("SA2")+M->ZZ2_FORNEC+M->ZZ2_LOJAFO,"A2_NOME")` |
| ZZ2_TOTOK | `M->ZZ2_QTDOK * M->ZZ2_VLRUNI` |
| ZZ2_TOTNOK | `M->ZZ2_QTDNOK * M->ZZ2_VLRUNI` |

---

## 5. Gatilhos (SX7)

Regras disparadas automaticamente na digitação (fase 3 — formulário aberto):

| Tabela | Campo Origem | Campo Destino | Regra |
|--------|--------------|---------------|-------|
| ZZ1 | ZZ1_FORNEC | ZZ1_NOMEFO | `POSICIONE("SA2",1,xFilial("SA2")+M->ZZ1_FORNEC+M->ZZ1_LOJAFO,"A2_NOME")` |
| ZZ2 | ZZ2_CONFOR | ZZ2_FORNEC | `POSICIONE("ZZ1",1,xFilial("ZZ1")+M->ZZ2_CONFOR,"ZZ1_FORNEC")` |
| ZZ2 | ZZ2_CONFOR | ZZ2_LOJAFO | `POSICIONE("ZZ1",1,xFilial("ZZ1")+M->ZZ2_CONFOR,"ZZ1_LOJAFO")` |
| ZZ2 | ZZ2_CONFOR | ZZ2_NOMEFO | `POSICIONE("SA2",1,xFilial("SA2")+M->ZZ2_FORNEC+M->ZZ2_LOJAFO,"A2_NOME")` |
| ZZ2 | ZZ2_DATA | ZZ2_DATA | `IF(INCLUI, dDataBase, ZZ2->ZZ2_DATA)` — grava a data na inclusão |
| ZZ2 | ZZ2_HORA | ZZ2_HORA | `IF(INCLUI, Time(), ZZ2->ZZ2_HORA)` — grava a hora na inclusão |

**Teste:** ao informar o **controle** numa ocorrência, fornecedor/loja/nome são preenchidos sozinhos; data e hora entram automaticamente na inclusão.

---

## 6. Validações de dados (X3_VALID no SX3)

Todas implementadas em `STTZZLIB.PRW` (reuso — zero duplicação), usando `ExistCpo`/`Posicione`:

| Tabela | Campo | Validação (função) | Regra |
|--------|-------|--------------------|-------|
| ZZ1 | ZZ1_FORNEC | `U_VALZZ1FORNEC()` | deve existir na **SA2** (`ExistCpo("SA2", filial+cód+loja, 1)`) |
| ZZ1 | ZZ1_VALCER | `U_VALZZ1VALCER()` | na inclusão, `ZZ1_VALCER >= dDataBase` |
| ZZ1 | ZZ1_TOLERA | `U_VALZZ1TOLERA()` | `0 <= ZZ1_TOLERA <= 100` |
| ZZ2 | ZZ2_CONFOR | `U_VALZZ2CONFOR()` | deve existir na **ZZ1** |
| ZZ2 | ZZ2_CODPRO | `U_VALZZ2CODPRO()` | deve existir na **SB1** |
| ZZ2 | ZZ2_DATA | `U_VALZZ2DATA()` | na inclusão, `ZZ2_DATA <= dDataBase` (não futura) |

Cada função mostra `MsgAlert` amigável e retorna `.F.`, bloqueando a gravação.

---

## 7. Consultas padrão (SXB)

| Código | Descrição | Campos |
|--------|-----------|--------|
| ZZ1 | Busca de Controle de Fornecimento | `ZZ1_CODIGO`, `ZZ1_NOMEFO`, `ZZ1_VALCER` |
| SA2 | Busca de Fornecedor | `A2_COD`, `A2_LOJA`, `A2_NOME` |
| SB1 | Busca de Produto | `B1_COD`, `B1_DESC`, `B1_UM` |

---

## 8. Menu no SIGACOM

Estrutura adicionada ao menu de Compras (descrita em `Dados-e-Dicionario/sigacom.xnu.txt`):

```
Compras (SIGACOM)
└── Cadastros
    └── Controle ISO 9001
        ├── Controle de Fornecimento (ZZ1)    → USER FUNCTION STTZZ1
        └── Ocorrências de Fornecedores (ZZ2) → USER FUNCTION STTZZ2
```

---

## 9. Rotinas desenvolvidas

### 9.1 `STTZZ1.PRW` — Controle de Fornecimento

`USER FUNCTION STTZZ1()` — mBrowse sobre a **ZZ1** com:

- botões padrão de CRUD (Pesquisar/Visualizar/Incluir/Alterar);
- botão **Excluir** → `U_EXCLZZ1()` exclusão protegida por transação, que só ocorre se `U_VALEXCZZ1()` confirmar que não há ZZ2 vinculada;
- botão **Ocorrências** → `U_STTZZ2FLT()` abre a **ZZ2 filtrada** pelo controle selecionado;
- botão **Gravar** → `U_STTZZ1GRAVAR()` gravação protegida por **BEGIN SEQUENCE**;
- botão **Certificado** → `U_CERTZZ1()` detalhe usando a **classe POO**.

**Legenda** (avaliada de cima para baixo):

| Cor | Condição | Significado |
|-----|----------|-------------|
| 🔴 Vermelho | `ZZ1_VALCER < dDataBase` | certificado **vencido** |
| 🟡 Amarelo | `ZZ1_VALCER <= dDataBase + 30` | certificado **vence em 30 dias** |
| 🟢 Verde | `.T.` (último) | certificado **ok** |

### 9.2 `STTZZ2.PRW` — Ocorrências do Fornecedor

- `USER FUNCTION STTZZ2()` — mBrowse geral de todas as ocorrências (menu).
- `USER FUNCTION STTZZ2FLT(cCodigoZZ1)` — mesma tela **filtrada** por `ZZ2_CONFOR`, chamada pelo botão da STTZZ1.
- As duas rotinas compartilham a função STATIC `MontaBrowseZZ2()` (mesma tela, zero duplicação).

**Legenda** (calcula o % de não conformidade vs. tolerância do certificado):

| Cor | Condição | Significado |
|-----|----------|-------------|
| 🔴 Vermelho | `%NC > ZZ1_TOLERA` | **acima** da tolerância |
| 🟢 Verde | `.T.` (último) | **dentro** da tolerância |

> `%NC = (ZZ2_QTDNOK / (ZZ2_QTDOK + ZZ2_QTDNOK)) * 100` — função `U_PercNaoConforme()`.

### 9.3 `STTZZLIB.PRW` — Biblioteca de funções comuns

| Função | Responsabilidade |
|--------|------------------|
| `U_NomeFornecedor(cFornec, cLoja)` | nome do fornecedor via `POSICIONE` na SA2 |
| `U_NomeProduto(cCodPro)` | descrição do produto via `POSICIONE` na SB1 |
| `U_PercNaoConforme(nOk, nNok)` | calcula o % de não conformidade |
| `U_CertificadoVencendo(dValCer)` | `.T.` se vence em até 30 dias |
| `U_ToleranciaControle(cConfor)` | tolerância (%) do controle ZZ1 |
| `U_ProxCodigoZZ1()` | próximo código do controle (GetSXENum) |
| `U_GravarLogTCC(cFuncao, oErro)` | log técnico de erros em `tcc_erros.log` |
| `U_VALZZ1FORNEC/VALCER/TOLERA` | validações da ZZ1 |
| `U_VALZZ2CONFOR/CODPRO/DATA` | validações da ZZ2 |
| `U_VALEXCZZ1()` | integridade referencial na exclusão da ZZ1 |
| `ClsFornecimento` | **classe ADVPL (POO)** que representa um controle ZZ1 |

---

## 10. Tratamento de erros (BEGIN SEQUENCE)

Todas as operações de banco usam o padrão ensinado no Módulo 9:

```advpl
BeginTran()                            // inicia a transação
Begin Sequence
   ...validações e RecLock/MsUnLock...  // gravação com lock
   CommitTran()                         // só confirma se não houver erro
Recover With oErro
   RollBackTran()                       // desfaz TUDO
   MsgStop("Erro ao salvar: " + oErro:Description, "Atenção")   // msg amigável
   U_GravarLogTCC("STTZZ1GRAVAR", oErro)                         // log técnico
End Sequence
```

Exemplo completo: `U_STTZZ1GRAVAR()` em `STTZZ1.PRW`.

---

## 11. Diferenciais implementados

- ✅ **Cabeçalho de documentação e comentários** em todos os fontes.
- ✅ **Zero duplicação** — tudo que repete virou função na `STTZZLIB`; as duas telas da ZZ2 usam a mesma `MontaBrowseZZ2()`.
- ✅ **Legenda da ZZ2** comparando % de não conformidade com `ZZ1_TOLERA`.
- ✅ **Classe ADVPL** `ClsFornecimento` (POO) — usada no botão "Certificado" da STTZZ1.
- ✅ **Impedir exclusão** de ZZ1 que tenha ZZ2 vinculada (`U_VALEXCZZ1()`).
- ✅ **Validação de consistência** em todos os campos de entrada.

---

## 12. Instalação (importar o dicionário)

Para reproduzir em um ambiente Protheus com o Configurador (SIGACFG):

1. **Abrir o SIGACFG** (ambiente de desenvolvimento) → *Dicionário de Dados*.
2. **Tabelas (SX2):** incluir `ZZ1` e `ZZ2`, descrições conforme a seção 3, ambas **Compartilhadas**. Conferir os nomes dos arquivos físicos (`ZZ1990.DBF`, `ZZ2990.DBF`) com o `Dados-e-Dicionario/sx2990.csv`.
3. **Campos (SX3):** incluir os campos das tabelas com tipos, tamanhos e decimais da seção 3. Nos campos **virtuais**, preencher a `X3_RELACAO` (seção 4). Nos campos validados, preencher a `X3_VALID` (seção 6). Conferir com `sx3990.csv`.
4. **Índices (SIX):** nas tabelas, definir os índices da seção 3. Conferir com `six990.csv`.
5. **Gatilhos (SX7):** incluir as regras da seção 5. Conferir com `sx7990.csv`.
6. **Consultas (SXB):** incluir as 3 consultas da seção 7. Conferir com `sxb990.csv`.
7. **Menu:** no *Menu do Sistema* do SIGACOM, criar `Cadastros → Controle ISO 9001` apontando para `STTZZ1` e `STTZZ2`. Conferir com `sigacom.xnu.txt`.
8. **Rodar a rotina de fórmulas** para o framework reconhecer as tabelas novas.
9. **Importar a massa de teste** dos CSVs `sa2990/sb1990/zz1990/zz2990` (ou rodar `U_ConverteDicionario()` do `converte-dicionario.prg`, que também exporta).
10. **Compilar** os fontes `STTZZLIB.PRW`, `STTZZ1.PRW` e `STTZZ2.PRW` no projeto.

---

## 13. Massa de teste e resultado esperado

A massa foi preparada para demonstrar **todas as legendas**:

| Controle | Fornecedor | Validade | Tolerância | Legenda ZZ1 esperada |
|----------|------------|----------|------------|----------------------|
| 000001 | Alfa | 30/06/2026 (vencido) | 2,00 % | 🔴 Vermelho |
| 000002 | Beta | 20/08/2026 (≤ 30 dias) | 5,00 % | 🟡 Amarelo |
| 000003 | Gama | 15/03/2027 (ok) | 1,00 % | 🟢 Verde |

| Controle | Entrega | Qtd OK | Qtd NOK | % NC | Tolerância | Legenda ZZ2 esperada |
|----------|---------|--------|---------|------|-----------|----------------------|
| 000001 | 15/07 | 100 | 10 | 9,09 % | 2,00 % | 🔴 Vermelho (acima) |
| 000001 | 16/07 | 200 | 20 | 9,09 % | 2,00 % | 🔴 Vermelho (acima) |
| 000002 | 01/08 | 950 | 50 | 5,00 % | 5,00 % | 🟢 Verde (no limite) |
| 000003 | 28/07 | 40 | 0 | 0,00 % | 1,00 % | 🟢 Verde |

> A descrição passo a passo de cada tela (o que aparece e o resultado esperado) está em **`evidencias/descricao-das-telas.md`**.

---

## 14. Como rodar

Sem o ambiente Protheus, a validação é feita pela leitura do código:

```powershell
# Estrutura de entrega (conferência)
tree TCC

# (Com ambiente) exportar o dicionário para CSV
#  1. Abrir o projeto no DevStudio e incluir converte-dicionario.prg
#  2. Compilar (F9) e rodar no SmartClient: U_ConverteDicionario()
```

---

## 15. Referências

- Modelo de entrega (validação automática por IA): `README.pdf`
- Rubrica de avaliação: `rubrica-validacao.pdf` (Rev. 1.0)
- Autoavaliação: `AUTOAVALIACAO.md`

> "Programar é como montar um quebra-cabeça: cada exercício é uma peça que encaixa no grande mapa da lógica." 🧩
