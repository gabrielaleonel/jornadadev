// STTIP003.PRW — Rotina de Contatos (SZ1)
// mBrowse com legendas coloridas + botão customizado "Interações"
// (abre a STTIP004 filtrada pelo contato selecionado)

#include "protheus.ch"

USER FUNCTION STTIP003()

   LOCAL aRotina := {}
   LOCAL aColors := {}

   PRIVATE cCadastro := "Contatos"    // título do cadastro

   dbSelectArea("SZ1")                // abre a tabela de Contatos
   dbSetOrder(1)                      // Z1_FILIAL + Z1_CODIGO

   // Botões padrão de CRUD + botão customizado (tipo 6)
   AADD(aRotina, {"Pesquisar",  "AxPesqui", 0, 1})
   AADD(aRotina, {"Visualizar", "AxVisual", 0, 2})
   AADD(aRotina, {"Incluir",    "AxInclui", 0, 3})
   AADD(aRotina, {"Alterar",    "AxAltera", 0, 4})
   AADD(aRotina, {"Excluir",    "AxExclui", 0, 5})
   AADD(aRotina, {"Interações", "U_STTIP004", 0, 6})   // abre interações do contato

   // Legendas coloridas (avaliadas de cima p/ baixo; ".T." por último)
   AADD(aColors, {"!Empty(SZ1->Z1_ASSUNTO)", "BR_GREEN"})   // contato com assunto
   AADD(aColors, {".T.", "BR_RED"})                          // sem assunto (padrão)

   // mBrowse(nTop,nLeft,nBottom,nRight,cAlias,...cTitulo,aColors,...aRotina,...lAbort)
   mBrowse(1, 1, 22, 75, "SZ1", , , , , "Contatos", aColors, , , aRotina, , .F.)

RETURN NIL
