// Exercício 4 — Validação com ExistCpo no campo ZA1_CLIENT
// Garante que o cliente informado (ZA1_CLIENT + ZA1_LOJA) existe na SA1.
//
// No Configurador (SX3), no campo ZA1_CLIENT, preencher o X3_VALID com:
//    X3_VALID = "U_VALCLI001()"

#include "protheus.ch"

USER FUNCTION VALCLI001()

   // ExistCpo(cTabela, cChave, nIndice) — verifica se a chave existe na SA1
   // A chave da SA1 é: xFilial("SA1") + A1_COD + A1_LOJA
   IF !ExistCpo("SA1", xFilial("SA1") + M->ZA1_CLIENT + M->ZA1_LOJA, 1)
      MsgAlert("Cliente não cadastrado na SA1!", "Atenção")
      RETURN .F.                        // validação falhou → não deixa gravar
   ENDIF

RETURN .T.                              // cliente existe → validação passou
