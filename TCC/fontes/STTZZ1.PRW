// STTZZ1.PRW — Rotina de manutenção da ZZ1 (Controle de Fornecimento)
//
// USER FUNCTION STTZZ1() — mBrowse sobre a ZZ1 com:
//   - Botões padrão de CRUD (Pesquisar/Visualizar/Incluir/Alterar)
//   - Botão "Excluir"     → exclusão protegida + integridade referencial (ZZ2)
//   - Botão "Ocorrências" → abre a STTZZ2 filtrada pelo controle selecionado
//   - Botão "Gravar"      → gravação protegida por transação (BEGIN SEQUENCE)
//   - Botão "Certificado" → detalhe do certificado usando a classe POO
//   - Legenda de cores pela validade do certificado (ZZ1_VALCER):
//       Vermelho (BR_RED)    → ZZ1_VALCER < dDataBase (certificado vencido)
//       Amarelo (BR_YELLOW)  → ZZ1_VALCER <= dDataBase + 30 (vence em 30 dias)
//       Verde (BR_GREEN)     → demais (certificado ok) — ".T." por último

#Include "protheus.ch"

User Function STTZZ1()

   Local aRotina := {}
   Local aColors := {}

   Private cCadastro := "Controle ISO 9001"   // título do cadastro (visível p/ o AxCadastro)

   dbSelectArea("ZZ1")                        // abre a tabela ZZ1
   dbSetOrder(1)                              // ZZ1_FILIAL + ZZ1_CODIGO

   // Botões padrão de CRUD + customizados (tipo 6)
   AAdd(aRotina, {"Pesquisar",   "AxPesqui", 0, 1})
   AAdd(aRotina, {"Visualizar",  "AxVisual", 0, 2})
   AAdd(aRotina, {"Incluir",     "AxInclui", 0, 3})
   AAdd(aRotina, {"Alterar",     "AxAltera", 0, 4})
   AAdd(aRotina, {"Excluir",     "U_EXCLZZ1", 0, 6})       // exclusão com integridade referencial
   AAdd(aRotina, {"Ocorrências", "U_STTZZ2FLT", 0, 6})    // abre ZZ2 filtrada pelo controle
   AAdd(aRotina, {"Gravar",      "U_STTZZ1GRAVAR", 0, 6}) // gravação com transação
   AAdd(aRotina, {"Certificado", "U_CERTZZ1", 0, 6})      // detalhe via classe POO

   // Legendas avaliadas de cima para baixo; a 1ª condição verdadeira vence
   AAdd(aColors, {"ZZ1->ZZ1_VALCER < dDataBase",                  "BR_RED"})    // vencido
   AAdd(aColors, {"ZZ1->ZZ1_VALCER <= dDataBase + 30",            "BR_YELLOW"}) // vence em 30 dias
   AAdd(aColors, {".T.",                                          "BR_GREEN"})  // padrão

   // mBrowse(nTop,nLeft,nBottom,nRight,cAlias,...,cTitulo,aColors,...,aRotina,...lAbort)
   mBrowse(1, 1, 22, 75, "ZZ1", , , , , "Controle ISO 9001", aColors, , , aRotina, , .F.)

Return NIL

// ------------------------------------------------------------------
// STTZZ1GRAVAR() — gravação do Controle de Fornecimento protegida
//   por BEGIN SEQUENCE: valida, grava com RecLock e, em erro,
//   desfaz a transação, avisa o usuário de forma amigável e loga.
// ------------------------------------------------------------------
User Function STTZZ1GRAVAR()

   Local lInclui := INCLUI
   Local oErro

   BeginTran()                                // inicia a transação

   Begin Sequence
      // Validações campo a campo (reuso da biblioteca STTZZLIB — zero duplicação)
      If !U_VALZZ1FORNEC() .Or. !U_VALZZ1VALCER() .Or. !U_VALZZ1TOLERA()
         Break("Corrija os campos destacados para salvar!")
      EndIf

      // Gravação física com lock (inclusão ou alteração)
      RecLock("ZZ1", lInclui)

      If lInclui
         ZZ1->ZZ1_FILIAL := xFilial("ZZ1")
         // se o código vier vazio, gera o próximo sequencial do campo
         ZZ1->ZZ1_CODIGO := If(Empty(M->ZZ1_CODIGO), U_ProxCodigoZZ1(), M->ZZ1_CODIGO)
      EndIf

      ZZ1->ZZ1_FORNEC  := M->ZZ1_FORNEC
      ZZ1->ZZ1_LOJAFO  := M->ZZ1_LOJAFO
      ZZ1->ZZ1_CERTIF  := M->ZZ1_CERTIF
      ZZ1->ZZ1_VALCER  := M->ZZ1_VALCER
      ZZ1->ZZ1_TOLERA  := M->ZZ1_TOLERA
      ZZ1->ZZ1_TOTOK   := M->ZZ1_TOTOK
      ZZ1->ZZ1_TOTNOK  := M->ZZ1_TOTNOK
      MsUnLock()

      CommitTran()                           // só confirma se chegou aqui sem erro

   Recover With oErro
      // Deu errado: desfaz TUDO e avisa de forma amigável
      RollBackTran()
      MsgStop("Erro ao salvar o Controle de Fornecimento: " + oErro:Description, "Atenção")
      U_GravarLogTCC("STTZZ1GRAVAR", oErro)
   End Sequence

Return NIL

// ------------------------------------------------------------------
// EXCLZZ1() — exclusão de um Controle de Fornecimento.
//   Só exclui se não houver ocorrências (ZZ2) vinculadas (integridade
//   referencial via U_VALEXCZZ1) e protege a exclusão com transação.
// ------------------------------------------------------------------
User Function EXCLZZ1()

   Local oErro

   // Bloqueia a exclusão se houver ZZ2 vinculada (mensagem na biblioteca)
   If !U_VALEXCZZ1()
      Return .F.
   EndIf

   BeginTran()

   Begin Sequence
      RecLock("ZZ1", .F.)                // lock para exclusão
      dbDelete()
      MsUnLock()

      CommitTran()

   Recover With oErro
      RollBackTran()
      MsgStop("Erro ao excluir o Controle de Fornecimento: " + oErro:Description, "Atenção")
      U_GravarLogTCC("STTZZ1EXCLUIR", oErro)
   End Sequence

Return .T.

// ------------------------------------------------------------------
// CERTZZ1() — detalhe do certificado do controle selecionado
//   Demonstra o uso da classe ADVPL ClsFornecimento (POO).
// ------------------------------------------------------------------
User Function CERTZZ1()

   Local oControle
   Local cSituacao := ""

   oControle := ClsFornecimento():New(ZZ1->ZZ1_CODIGO)

   If oControle:CertificadoVencido()
      cSituacao := "CERTIFICADO VENCIDO"
   ElseIf oControle:CertificadoVencendo()
      cSituacao := "VENCE EM ATÉ 30 DIAS"
   Else
      cSituacao := "CERTIFICADO OK"
   EndIf

   MsgInfo("Fornecedor:  " + oControle:NomeFornecedor() + CRLF + ;
          "Certificado: " + oControle:cCertif + CRLF + ;
          "Validade:    " + DToC(oControle:dValCer) + CRLF + ;
          "Tolerância:  " + AllTrim(Str(oControle:nTolera)) + " %" + CRLF + ;
          "Situação:    " + cSituacao, ;
          "Certificado - Controle " + oControle:cCodigo)

Return NIL
