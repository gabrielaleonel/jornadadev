// Exercício 7 — Desafio (opcional)
//
// 7a — U_VALEXCSZ1(): integridade referencial
//      impede excluir um Contato (SZ1) que tenha Interações (SZ2) vinculadas.
//
// 7b — U_EXECUTARSEGURO(bBloco, cMsgErro): executor seguro genérico
//      executa um bloco dentro de BEGIN SEQUENCE; em erro, exibe cMsgErro,
//      grava o log e retorna .F. (senão retorna .T.).

#include "protheus.ch"

// ------------------------------------------------------------------
// 7a — Integridade referencial
// (chamar na exclusão do Contato, ex.: X3_VALID do Z1_CODIGO ou no
//  botão Excluir da STTIP003)
// ------------------------------------------------------------------
USER FUNCTION VALEXCSZ1()

   // Existe alguma interação vinculada a este contato?
   IF ExistCpo("SZ2", xFilial("SZ2") + SZ1->Z1_CODIGO, 1)
      MsgAlert("Não é possível excluir: este contato possui interações vinculadas!", "Atenção")
      RETURN .F.                   // bloqueia a exclusão
   ENDIF

RETURN .T.                          // libera a exclusão

// ------------------------------------------------------------------
// 7b — Executor seguro genérico
//
// Uso:
//   U_EXECUTARSEGURO({|| AbrirArquivo("dados.dbf")}, "Falha ao abrir dados")
// ------------------------------------------------------------------
USER FUNCTION EXECUTARSEGURO(bBloco, cMsgErro)

   LOCAL oErro

   BEGIN SEQUENCE
      Eval(bBloco)                  // executa o bloco de código recebido
   RECOVER WITH oErro
      MsgAlert(cMsgErro + " - " + oErro:Description, "Erro")
      U_GRAVARLOG("EXECUTARSEGURO", oErro)   // grava o erro no log
      RETURN .F.                    // falhou
   END SEQUENCE

RETURN .T.                          // tudo certo
