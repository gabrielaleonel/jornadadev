// Exercício 5 — CRUD com mBrowse para a tabela ZA1 (Pets)
// Mesmos campos e mesmos botões do aRotina do AxCadastro (Ex. 3).
// Diferença: mBrowse dá controle total de tela, botões, legendas e filtros.

#include "protheus.ch"

USER FUNCTION STTIP002()

   LOCAL aRotina := {}

   dbSelectArea("ZA1")              // Abre a tabela ZA1
   dbSetOrder(1)                    // Índice 1 = ZA1_FILIAL + ZA1_COD

   // Botões padrão de CRUD (mesmos do AxCadastro)
   // aRotina: {"Texto", "Função", 0, Tipo}  → 1=Pesq 2=Vis 3=Inc 4=Alt 5=Del 6=Custom
   AADD(aRotina, {"Pesquisar", "AxPesqui", 0, 1})
   AADD(aRotina, {"Visualizar", "AxVisual", 0, 2})
   AADD(aRotina, {"Incluir",    "AxInclui", 0, 3})
   AADD(aRotina, {"Alterar",    "AxAltera", 0, 4})
   AADD(aRotina, {"Excluir",    "AxExclui", 0, 5})

   // mBrowse(nTop,nLeft,nBottom,nRight,cAlias,...cTitulo,aColors,...aRotina,...lAbort)
   mBrowse(1, 1, 22, 75, "ZA1", , , , , "Pets", , , , aRotina, , .F.)

RETURN NIL
