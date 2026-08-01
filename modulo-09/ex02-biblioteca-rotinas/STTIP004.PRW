// STTIP004.PRW — Rotina de Interações (SZ2)
// Abre a lista de interações FILTRADA pelo contato selecionado
// (chamada pelo botão "Interações" da rotina de Contatos - STTIP003)

#include "protheus.ch"

USER FUNCTION STTIP004()

   LOCAL cCodigo
   LOCAL cFiltro := ""
   LOCAL aRotina := {}

   PRIVATE cCadastro := "Interações"

   // O botão é clicado com a SZ1 ainda aberta: pega o contato selecionado
   cCodigo := SZ1->Z1_CODIGO

   // Filtra a SZ2 pelo contato (cFiltro vai como último parâmetro do mBrowse)
   cFiltro := "Z2_CONTAT == '" + cCodigo + "'"

   dbSelectArea("SZ2")
   dbSetOrder(1)                      // Z2_FILIAL + Z2_CONTAT + Z2_SEQUEN

   // Botões padrão de CRUD
   AADD(aRotina, {"Pesquisar",  "AxPesqui", 0, 1})
   AADD(aRotina, {"Visualizar", "AxVisual", 0, 2})
   AADD(aRotina, {"Incluir",    "AxInclui", 0, 3})
   AADD(aRotina, {"Alterar",    "AxAltera", 0, 4})
   AADD(aRotina, {"Excluir",    "AxExclui", 0, 5})

   // mBrowse com cFiltro (19º parâmetro) — só as interações do contato
   mBrowse(1, 1, 22, 75, "SZ2", , , , , "Interações", , , , aRotina, , .F., , , cFiltro)

RETURN NIL
