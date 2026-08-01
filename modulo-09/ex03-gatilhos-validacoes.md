# Exercício 3 — Gatilhos, campos virtuais e validações cruzadas

> Sem ambiente Protheus disponível, segue a configuração que eu faria no Configurador (SIGACFG) + o código das validações.

## 1. Campos virtuais na SZ2 (X3_RELACAO)

No SX3, os campos **Z2_CODIGO** e **Z2_ASSUNT** devem ser marcados como **Virtual**, com a relação preenchida (busca na SZ1 pelo contato):

| Campo | Virtual | Relação (X3_RELACAO) |
|-------|---------|-----------------------|
| Z2_CODIGO | Sim | `POSICIONE("SZ1", 1, xFilial("SZ1") + M->Z2_CONTAT, "Z1_CODIGO")` |
| Z2_ASSUNT | Sim | `POSICIONE("SZ1", 1, xFilial("SZ1") + M->Z2_CONTAT, "Z1_ASSUNTO")` |

O `M->Z2_CONTAT` traz o valor que está em edição na tela; o valor é calculado na exibição e **não é gravado** no arquivo.

## 2. Gatilhos automáticos na SZ2 (SX7)

No *Dicionário de Dados → Gatilhos (SX7)*, criar os gatilhos na tabela SZ2:

| Sequência | Campo | Contra-domínio | Regra |
|-----------|-------|----------------|-------|
| 001 | Z2_DATA | Z2_DATA | `dDataBase` |
| 002 | Z2_HORA | Z2_HORA | `IF(INCLUI, Time(), SZ2->Z2_HORA)` |
| 003 | Z2_USUAR | Z2_USUAR | `cNomUsr` |

- **Z2_DATA** → preenche com a data atual (`dDataBase`).
- **Z2_HORA** → na **inclusão** grava a hora atual (`Time()`); na **alteração** mantém a hora já gravada (`SZ2->Z2_HORA`), usando a variável de sistema `INCLUI` (fase 3).
- **Z2_USUAR** → grava o usuário logado (`cNomUsr`).

**Teste:** ao incluir uma interação, data/hora/usuário aparecem sozinhos.

## 3. Validação cruzada no Z2_CONTAT (X3_VALID)

No campo **Z2_CONTAT** do SX3, preencher o **X3_VALID**:

```
X3_VALID = "U_VALZ2CONT()"
```

E criar a USER FUNCTION no fonte (mesmo padrão do `ExistCpo` do Módulo 8):

```advpl
// Exercício 3 — Validação cruzada: contato precisa existir na SZ1
#include "protheus.ch"

USER FUNCTION VALZ2CONT()

   // ExistCpo("SZ1", filial + código, índice 1) → .T. se existe
   IF !ExistCpo("SZ1", xFilial("SZ1") + M->Z2_CONTAT, 1)
      MsgAlert("Contato não cadastrado na SZ1!", "Atenção")
      RETURN .F.                 // não deixa gravar
   ENDIF

RETURN .T.
```

**Teste:** informar um contato inexistente faz o sistema recusar com a mensagem.

## Passos finais

1. Salvar as alterações no SX3 (campos virtuais, X3_VALID) e no SX7 (gatilhos).
2. Rodar a rotina de fórmulas para reconhecer.
3. Testar no SmartClient (via STTIP003 → Interações): incluir interação e conferir data/hora/usuário automáticos + recusa de contato inexistente.
