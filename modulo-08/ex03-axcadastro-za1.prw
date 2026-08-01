// Exercício 3 — CRUD com AxCadastro para a tabela ZA1 (Pets)
// Programas de Protheus: USER FUNCTION STTIP001()
// Passos: compilar (F9), acessar pelo SmartClient e incluir 2 ou 3 pets de teste.

#include "protheus.ch"

USER FUNCTION STTIP001()

   PRIVATE cCadastro := "Pets"      // Título exibido no cadastro (PRIVATE p/ ser visível p/ o AxCadastro)

   dbSelectArea("ZA1")              // Abre a tabela ZA1 (cadastro de Pets)
   dbSetOrder(1)                    // Posiciona no índice 1 = ZA1_FILIAL + ZA1_COD

   // AxCadastro(cTabela, cTitulo, bInclui, cTipo, nIndex, oObj, lAutoDel, lOnlySolver)
   // cTipo "1" = rotina de cadastro padrão (Incluir/Alterar/Excluir/Pesquisar/Visualizar)
   // lOnlySolver .F. = permite todos os botões padrão de CRUD
   AxCadastro("ZA1", "Pets", , "1", , , , .F.)

RETURN NIL
