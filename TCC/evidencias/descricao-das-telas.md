# Descrição das telas — TCC Controle ISO 9001

> **Aluna:** Gabriela Oliveira · Programa START — TOTVS Paulista
> **Sem ambiente Protheus:** este documento descreve, passo a passo, o que aparece em cada tela e o resultado esperado. A correção lê código e texto, não imagem (conforme orientação da atividade).

---

## 1. Menu no SIGACOM

**Passo:** abrir o SIGACOM → menu **Compras** → **Cadastros** → **Controle ISO 9001**.

**Resultado esperado:**

```
Compras (SIGACOM)
└── Cadastros
    └── Controle ISO 9001
        ├── Controle de Fornecimento (ZZ1)    → USER FUNCTION STTZZ1
        └── Ocorrências de Fornecedores (ZZ2) → USER FUNCTION STTZZ2
```

As duas opções chamam as rotinas corretas (configuração no `.xnu`, descrita em `Dados-e-Dicionario/sigacom.xnu.txt`).

---

## 2. STTZZ1 — mBrowse do Controle de Fornecimento (ZZ1)

**Passo:** menu → **Controle de Fornecimento** (chama `STTZZ1()`).

**Tela:** grade (mBrowse) sobre a **ZZ1**, ordenada por `ZZ1_FILIAL + ZZ1_CODIGO` (índice 1).

**Botões disponíveis:** Pesquisar, Visualizar, Incluir, Alterar, **Excluir**, **Ocorrências**, **Gravar**, **Certificado**.

**Legenda de cores** (condições avaliadas de cima para baixo — a 1ª verdadeira vence):

| Cor | Condição | Significado |
|-----|----------|-------------|
| 🔴 Vermelho | `ZZ1_VALCER < dDataBase` | certificado **vencido** |
| 🟡 Amarelo | `ZZ1_VALCER <= dDataBase + 30` | vence em até **30 dias** |
| 🟢 Verde | `.T.` (padrão) | certificado **ok** |

**Resultado esperado com a massa de teste** (hoje = 07/08/2026):

| Controle | Fornecedor | Validade | Legenda esperada |
|----------|------------|----------|------------------|
| 000001 | Fornecedor Alfa Ltda | 30/06/2026 | 🔴 Vermelho |
| 000002 | Metalurgica Beta SA | 20/08/2026 | 🟡 Amarelo (hoje + 30 = 06/09) |
| 000003 | Quimica Gama Ind. e Com. | 15/03/2027 | 🟢 Verde |

A coluna **Nome Fornecedor** (`ZZ1_NOMEFO`, campo virtual) exibe o nome da SA2 automaticamente.

---

## 3. Inclusão / alteração da ZZ1 (formulário)

**Passo:** botão **Incluir** (ou **Alterar** em um registro) → abre o formulário do AxCadastro.

**Campos do formulário:**

| Campo | Comportamento |
|-------|---------------|
| ZZ1_CODIGO | vazio na inclusão → preenchido automaticamente por `U_ProxCodigoZZ1()` (GetSXENum) |
| ZZ1_FORNEC | obrigatório; **gatilho SX7** preenche `ZZ1_NOMEFO` com o nome da SA2 |
| ZZ1_LOJAFO | loja do fornecedor |
| ZZ1_CERTIF | dados do certificado (texto) |
| ZZ1_VALCER | validade do certificado |
| ZZ1_TOLERA | tolerância em % |
| ZZ1_TOTOK / ZZ1_TOTNOK | totais acumulados (conforme / não conforme) |

**Validações ao tentar gravar** (X3_VALID → funções da `STTZZLIB.PRW`):

| Campo | Condição de erro | Mensagem |
|-------|------------------|----------|
| ZZ1_FORNEC | vazio | "Informe o código do fornecedor!" |
| ZZ1_FORNEC | não existe na SA2 | "Fornecedor não cadastrado na SA2!" |
| ZZ1_VALCER | < hoje (na inclusão) | "A validade do certificado não pode ser inferior à data atual!" |
| ZZ1_TOLERA | fora de 0–100 | "A tolerância deve estar entre 0 e 100%!" |

**Resultado esperado:** a gravação é **bloqueada** com `MsgAlert` até o campo ser corrigido.

---

## 4. Botão Gravar (U_STTZZ1GRAVAR) — transação

**Passo:** preencher o formulário corretamente → botão **Gravar**.

**Resultado esperado:** executa `BeginTran()` → validações → `RecLock("ZZ1")` → `MsUnLock()` → `CommitTran()`. Registro gravado na ZZ1.

**Em caso de erro:** `Recover` → `RollBackTran()` (desfaz tudo) → `MsgStop("Erro ao salvar o Controle de Fornecimento: ...")` → `U_GravarLogTCC()` registra a ocorrência no log.

---

## 5. Botão Certificado (U_CERTZZ1) — classe POO

**Passo:** selecionar um controle → botão **Certificado**.

**Resultado esperado:** `MsgInfo` montado pela classe `ClsFornecimento` (POO):

```
Fornecedor:  <nome via SA2>
Certificado: <ZZ1_CERTIF>
Validade:    <ZZ1_VALCER>
Tolerância:  <ZZ1_TOLERA> %
Situação:    <CERTIFICADO VENCIDO | VENCE EM ATÉ 30 DIAS | CERTIFICADO OK>
```

**Com a massa:** 000001 → "CERTIFICADO VENCIDO"; 000002 → "VENCE EM ATÉ 30 DIAS"; 000003 → "CERTIFICADO OK".

---

## 6. Botão Excluir (U_EXCLZZ1) — integridade referencial

**Passo:** selecionar o controle **000001** → botão **Excluir**.

**Resultado esperado:** `U_VALEXCZZ1()` detecta ocorrências (ZZ2) vinculadas → `MsgAlert("Não é possível excluir: existem ocorrências (ZZ2) vinculadas a este controle!")` e a exclusão é **bloqueada**.

**Controle sem ZZ2:** exclui normalmente, protegido por `BeginTran`/`Recover`/`RollBackTran`.

---

## 7. Botão Ocorrências (U_STTZZ2FLT) — ZZ2 filtrada

**Passo:** selecionar o controle **000001** → botão **Ocorrências**.

**Resultado esperado:** `STTZZ2FLT()` monta o filtro `ZZ2_CONFOR == '000001'` e abre o mBrowse da ZZ2 com título **"Ocorrências do Controle 000001"**, exibindo **somente** as 2 ocorrências daquele controle (15/07 e 16/07).

---

## 8. STTZZ2 — mBrowse geral das Ocorrências (ZZ2)

**Passo:** menu → **Ocorrências de Fornecedores** (chama `STTZZ2()`, sem filtro).

**Tela:** grade (mBrowse) sobre a **ZZ2**, ordenada por `ZZ2_CONFOR + data + hora` (índice 1), com todos os registros.

**Campos virtuais exibidos:** `ZZ2_NOMEFO` (nome na SA2), `ZZ2_TOTOK` (`QTDOK × VLRUNI`) e `ZZ2_TOTNOK` (`QTDNOK × VLRUNI`).

**Legenda de cores** (compara o % de não conformidade com a tolerância do certificado):

| Cor | Condição | Significado |
|-----|----------|-------------|
| 🔴 Vermelho | `U_PercNaoConforme(QTDOK, QTDNOK) > U_ToleranciaControle(CONFOR)` | **acima** da tolerância |
| 🟢 Verde | `.T.` (padrão) | **dentro** da tolerância |

**Resultado esperado com a massa de teste:**

| Controle | Data | Qtd OK | Qtd NOK | % NC | Tolerância | Legenda |
|----------|------|--------|---------|------|-----------|---------|
| 000001 | 15/07/2026 | 100 | 10 | 9,09 % | 2,00 % | 🔴 Vermelho |
| 000001 | 16/07/2026 | 200 | 20 | 9,09 % | 2,00 % | 🔴 Vermelho |
| 000002 | 01/08/2026 | 950 | 50 | 5,00 % | 5,00 % | 🟢 Verde (no limite) |
| 000003 | 28/07/2026 | 40 | 0 | 0,00 % | 1,00 % | 🟢 Verde |

> % NC = (QTDNOK / (QTDOK + QTDNOK)) × 100 — função `U_PercNaoConforme()`.

---

## 9. Inclusão / alteração da ZZ2

**Passo:** botão **Incluir** na tela da ZZ2.

**Comportamento dos gatilhos (SX7):**

| Campo | Comportamento |
|-------|---------------|
| ZZ2_CONFOR | informado → gatilhos preenchem `ZZ2_FORNEC`, `ZZ2_LOJAFO` e `ZZ2_NOMEFO` a partir da ZZ1/SA2 |
| ZZ2_DATA | preenchida automaticamente na inclusão (hoje) |
| ZZ2_HORA | preenchida automaticamente na inclusão (hora atual) |

**Validações** (X3_VALID):

| Campo | Condição de erro | Mensagem |
|-------|------------------|----------|
| ZZ2_CONFOR | vazio ou inexistente na ZZ1 | "Informe o controle de fornecimento (ZZ1)!" / "Controle de fornecimento não cadastrado na ZZ1!" |
| ZZ2_CODPRO | não existe na SB1 | "Produto não cadastrado na SB1!" |
| ZZ2_DATA | futura (na inclusão) | "A data da ocorrência não pode ser futura!" |

**Resultado esperado:** ao informar o controle, fornecedor/loja/nome entram sozinhos; data e hora entram na inclusão; gravação com validações bloqueando erros.

---

## 10. Tratamento de erros (todas as rotinas)

**Padrão aplicado em toda gravação/exclusão (Módulo 9):**

```advpl
BeginTran()
Begin Sequence
   ... validações + RecLock/MsUnLock ...
   CommitTran()
Recover With oErro
   RollBackTran()                         // desfaz TUDO
   MsgStop("Erro ao salvar: " + oErro:Description, "Atenção")
   U_GravarLogTCC("ROTINA", oErro)        // grava em <temp>\tcc_erros.log
End Sequence
```

**Resultado esperado:** nenhuma gravação parcial; usuário recebe mensagem amigável; erro técnico fica registrado no arquivo `tcc_erros.log` (data + hora + função + descrição).

---

## Resumo do resultado esperado

| Tela | Ação | Resultado |
|------|------|-----------|
| Menu SIGACOM | Cadastros → Controle ISO 9001 | 2 opções apontando para STTZZ1/STTZZ2 |
| STTZZ1 | listar controles | legenda vermelho/amarelo/verde pela validade |
| STTZZ1 | incluir fornecedor inválido | bloqueio com MsgAlert |
| STTZZ1 | Gravar | registro salvo em transação (ou MsgStop + rollback + log) |
| STTZZ1 | Certificado | MsgInfo da classe POO com situação do certificado |
| STTZZ1 | Excluir 000001 | bloqueado por integridade referencial (ZZ2 vinculada) |
| STTZZ1 | Ocorrências | ZZ2 filtrada pelo controle selecionado |
| STTZZ2 | listar ocorrências | legenda vermelho/verde pelo % NC × tolerância |
| STTZZ2 | informar controle | gatilhos preenchem fornecedor, data e hora sozinhos |
