// Exercício 8 — Desafio: filtro do mês + botão
// Mostra apenas os pets NASCIDOS no mês atual e permite remover o filtro
// com um botão customizado (tipo 6). Bônus: botão "Histórico".
//
// STTIP008()  → rotina principal (mBrowse com filtro do mês)
// LIMFIL08()  → remove o filtro e reabre o browse
// HISTOR08()  → exibe dados do registro atual (bônus)

#include "protheus.ch"

STATIC lFiltroMes := .T.          // STATIC: guarda o estado do filtro entre chamadas

USER FUNCTION STTIP008()

   LOCAL cFiltro := ""
   LOCAL aRotina := {}

   PRIVATE cCadastro := "Pets"   // título do cadastro (visível para o AxCadastro)

   // Filtro pré-definido: pets nascidos no mês/ano atual
   IF lFiltroMes
      cFiltro := "Month(ZA1->ZA1_DTNASC) == Month(dDataBase) .AND. Year(ZA1->ZA1_DTNASC) == Year(dDataBase)"
   ENDIF

   dbSelectArea("ZA1")
   dbSetOrder(1)

   // Botões padrão + 2 customizados (tipo 6)
   AADD(aRotina, {"Pesquisar",    "AxPesqui", 0, 1})
   AADD(aRotina, {"Visualizar",   "AxVisual", 0, 2})
   AADD(aRotina, {"Incluir",      "AxInclui", 0, 3})
   AADD(aRotina, {"Alterar",      "AxAltera", 0, 4})
   AADD(aRotina, {"Excluir",      "AxExclui", 0, 5})
   AADD(aRotina, {"Limpar Filtro", "U_LIMFIL08", 0, 6})  // custom → remove filtro
   AADD(aRotina, {"Histórico",    "U_HISTOR08", 0, 6})    // custom → bônus

   // mBrowse(... cAlias ... cFiltro) — cFiltro no 19º parâmetro
   mBrowse(1, 1, 22, 75, "ZA1", , , , , "Pets", , , , aRotina, , .F., , , cFiltro)

RETURN NIL

// Desliga o filtro, fecha o browse atual e reabre a rotina sem filtro
USER FUNCTION LIMFIL08()

   lFiltroMes := .F.             // desativa o filtro do mês
   AxFechar()                    // fecha o browse em aberto
   STTIP008()                    // reabre mostrando todos os pets

RETURN NIL

// Bônus: mostra dados do registro atual (código e raça)
USER FUNCTION HISTOR08()

   MsgInfo("Código: " + ZA1->ZA1_COD + ;
           " - Raça: " + ZA1->ZA1_RACA, "Histórico do Pet")

RETURN NIL
