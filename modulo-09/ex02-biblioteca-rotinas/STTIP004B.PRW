// STTIP004B.PRW — Listagem GERAL de Interações (SZ2)
// Cópia da STTIP004 SEM o cFiltro — usada no menu (Ex. 4):
// "Interações (todas)" → mostra todas as interações, de todos os contatos

#include "protheus.ch"

USER FUNCTION STTIP004B()

   LOCAL aRotina := {}

   PRIVATE cCadastro := "Interações (todas)"

   dbSelectArea("SZ2")
   dbSetOrder(1)                      // Z2_FILIAL + Z2_CONTAT + Z2_SEQUEN

   // Botões padrão de CRUD
   AADD(aRotina, {"Pesquisar",  "AxPesqui", 0, 1})
   AADD(aRotina, {"Visualizar", "AxVisual", 0, 2})
   AADD(aRotina, {"Incluir",    "AxInclui", 0, 3})
   AADD(aRotina, {"Alterar",    "AxAltera", 0, 4})
   AADD(aRotina, {"Excluir",    "AxExclui", 0, 5})

   // SEM cFiltro → mostra todas as interações
   mBrowse(1, 1, 22, 75, "SZ2", , , , , "Interações (todas)", , , , aRotina, , .F.)

RETURN NIL
