// STTZZ2.PRW — Rotina de manutenção da ZZ2 (Ocorrências do Fornecedor)
//
// USER FUNCTION STTZZ2()      — mBrowse geral de todas as ocorrências
// USER FUNCTION STTZZ2FLT()   — versão filtrada por controle (chamada pelo
//                               botão "Ocorrências" da STTZZ1)
//
// Legenda de cores comparando o % de não conformidade com a tolerância
// do certificado (ZZ1_TOLERA):
//   Vermelho (BR_RED)  → % NC > ZZ1_TOLERA (acima da tolerância)
//   Verde (BR_GREEN)   → dentro da tolerância — ".T." por último
//   Dica: % NC = (ZZ2_QTDNOK / (ZZ2_QTDOK + ZZ2_QTDNOK)) * 100
//
// As duas rotinas reutilizam MontaBrowseZZ2() (mesma tela) — zero duplicação.

#Include "protheus.ch"

User Function STTZZ2()

   // Listagem geral — sem filtro
   MontaBrowseZZ2("", "Ocorrências de Fornecedores")

Return NIL

// ------------------------------------------------------------------
// STTZZ2FLT(cCodigoZZ1) — exibe apenas as ZZ2 do controle selecionado.
//   Quando acionada pelo botão da STTZZ1, a ZZ1 ainda está aberta:
//   se o parâmetro vier vazio, pega o controle selecionado.
// ------------------------------------------------------------------
User Function STTZZ2FLT(cCodigoZZ1)

   Local cFiltro := ""

   If Empty(cCodigoZZ1)
      cCodigoZZ1 := ZZ1->ZZ1_CODIGO
   EndIf

   // Filtra a ZZ2 pelo controle (cFiltro vai como último parâmetro do mBrowse)
   cFiltro := "ZZ2_CONFOR == '" + cCodigoZZ1 + "'"

   MontaBrowseZZ2(cFiltro, "Ocorrências do Controle " + cCodigoZZ1)

Return NIL

// ------------------------------------------------------------------
// MontaBrowseZZ2(cFiltro, cTitulo) — monta a tela da ZZ2
//   Função STATIC compartilhada pelas duas rotinas públicas.
// ------------------------------------------------------------------
Static Function MontaBrowseZZ2(cFiltro, cTitulo)

   Local aRotina := {}
   Local aColors := {}

   Private cCadastro := cTitulo

   dbSelectArea("ZZ2")                        // abre a tabela ZZ2
   dbSetOrder(1)                              // ZZ2_FILIAL + ZZ2_CONFOR + data + hora

   // Botões padrão de CRUD
   AAdd(aRotina, {"Pesquisar",  "AxPesqui", 0, 1})
   AAdd(aRotina, {"Visualizar", "AxVisual", 0, 2})
   AAdd(aRotina, {"Incluir",    "AxInclui", 0, 3})
   AAdd(aRotina, {"Alterar",    "AxAltera", 0, 4})
   AAdd(aRotina, {"Excluir",    "AxExclui", 0, 5})

   // Legenda: % não conforme acima da tolerância do certificado = vermelho
   AAdd(aColors, {"U_PercNaoConforme(ZZ2->ZZ2_QTDOK, ZZ2->ZZ2_QTDNOK) > U_ToleranciaControle(ZZ2->ZZ2_CONFOR)", "BR_RED"})
   AAdd(aColors, {".T.", "BR_GREEN"})         // dentro da tolerância (padrão)

   // mBrowse com aColors e cFiltro (19º parâmetro)
   mBrowse(1, 1, 22, 75, "ZZ2", , , , , cTitulo, aColors, , , aRotina, , .F., , , cFiltro)

Return NIL
