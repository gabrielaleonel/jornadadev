// Exercício 6 — Gravação à prova de falhas
//
// U_STTIP003SALVAR() — blinda o "salvar" do cadastro de Contatos (SZ1):
//   1. Valida Z1_CLIENTE e Z1_ASSUNTO com IF (Break() se faltar)
//   2. Grava dentro de BeginTran() + BEGIN SEQUENCE, com RecLock/MsUnLock
//   3. No RECOVER: RollBackTran(), mensagem amigável e U_GRAVARLOG()
//   4. Só chama CommitTran() se tudo deu certo
//
// U_GRAVARLOG(cFuncao, oErro) — também adicionada à STTIPLIB.PRW (Ex. 2)

#include "protheus.ch"

USER FUNCTION STTIP003SALVAR()

   LOCAL oErro

   BeginTran()                        // (2) inicia a transação

   BEGIN SEQUENCE
      // (1) Validações manuais — Break() desvia direto para o RECOVER
      IF Empty(M->Z1_CLIENTE)
         Break("Informe o cliente do contato!")
      ENDIF

      IF Empty(M->Z1_ASSUNTO)
         Break("Informe o assunto!")
      ENDIF

      // Gravação física com lock
      RecLock("SZ1", .T.)             // .T. = inclusão · .F. = alteração
      SZ1->Z1_FILIAL  := xFilial("SZ1")
      SZ1->Z1_CODIGO  := M->Z1_CODIGO
      SZ1->Z1_NOME    := M->Z1_NOME
      SZ1->Z1_CLIENTE := M->Z1_CLIENTE
      SZ1->Z1_ASSUNTO := M->Z1_ASSUNTO
      MsUnLock()

      CommitTran()                    // (4) só confirma se chegou aqui sem erro

   RECOVER WITH oErro
      // (3) Deu errado: desfaz TUDO e avisa de forma amigável
      RollBackTran()
      MsgStop("Erro ao salvar o contato: " + oErro:Description, "Atenção")
      U_GRAVARLOG("STTIP003SALVAR", oErro)
   END SEQUENCE

RETURN NIL

// ------------------------------------------------------------------
// U_GRAVARLOG(cFuncao, oErro) — registra o erro em arquivo texto
// (mesma função adicionada à STTIPLIB.PRW no Exercício 2)
// ------------------------------------------------------------------
USER FUNCTION GRAVARLOG(cFuncao, oErro)

   LOCAL cArqLog
   LOCAL nHandle
   LOCAL cLinha

   cArqLog := GetTempPath() + "sttip_erros.log"
   nHandle := FOpen(cArqLog, 4)
   IF nHandle == -1
      nHandle := FCreate(cArqLog, 0)
   ENDIF

   IF nHandle > -1
      cLinha := DToC(dDataBase) + " " + Time() + " | " + cFuncao + " | " + oErro:Description + CRLF
      FSeek(nHandle, 0, 2)
      FWrite(nHandle, cLinha)
      FClose(nHandle)
   ENDIF

RETURN NIL
