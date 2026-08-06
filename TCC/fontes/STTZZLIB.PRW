// STTZZLIB.PRW — Biblioteca de funções comuns do TCC (Controle ISO 9001)
//
// Projeto: monitoramento das não conformidades na entrada de materiais
//          (certificados de qualidade dos fornecedores + ocorrências por entrega).
//
// Conteúdo:
//   NomeFornecedor()       - nome do fornecedor via POSICIONE na SA2
//   NomeProduto()          - descrição do produto via POSICIONE na SB1
//   PercNaoConforme()      - % de não conformidade (QTDNOK / total)
//   CertificadoVencendo()  - .T. se o certificado vence em até 30 dias
//   ToleranciaControle()   - tolerância (%) de um controle da ZZ1
//   GravarLogTCC()         - log técnico de erros em arquivo texto
//   Validações (X3_VALID)  - chamadas pelo Configurador campo a campo
//   VALEXCZZ1()            - integridade referencial na exclusão da ZZ1
//   ClsFornecimento        - classe ADVPL (POO) que representa um controle ZZ1

#Include "protheus.ch"

// ------------------------------------------------------------------
// NomeFornecedor(cFornec, cLoja) — nome do fornecedor pela SA2
// ------------------------------------------------------------------
User Function NomeFornecedor(cFornec, cLoja)

   Local cNome := ""

   If !Empty(cFornec)
      // POSICIONE: busca na SA2 pela chave (filial + código + loja) e devolve A2_NOME
      cNome := Posicione("SA2", 1, xFilial("SA2") + cFornec + cLoja, "A2_NOME")
   EndIf

Return cNome

// ------------------------------------------------------------------
// NomeProduto(cCodPro) — descrição do produto pela SB1
// ------------------------------------------------------------------
User Function NomeProduto(cCodPro)

   Local cDesc := ""

   If !Empty(cCodPro)
      cDesc := Posicione("SB1", 1, xFilial("SB1") + cCodPro, "B1_DESC")
   EndIf

Return cDesc

// ------------------------------------------------------------------
// PercNaoConforme(nOk, nNok) — % de não conformidade da entrega
//   % NC = (QTDNOK / (QTDOK + QTDNOK)) * 100
//   Se o total for zero (nenhuma quantidade informada), retorna 0.
// ------------------------------------------------------------------
User Function PercNaoConforme(nOk, nNok)

   Local nTotal := 0
   Local nPerc  := 0

   nTotal := nOk + nNok

   If nTotal > 0
      nPerc := (nNok / nTotal) * 100
   EndIf

Return nPerc

// ------------------------------------------------------------------
// CertificadoVencendo(dValCer) — .T. se o certificado vence em 30 dias
//   (validade entre hoje e hoje + 30). Certificado já vencido não conta.
// ------------------------------------------------------------------
User Function CertificadoVencendo(dValCer)

   If !Empty(dValCer) .And. dValCer >= dDataBase .And. dValCer <= dDataBase + 30
      Return .T.
   EndIf

Return .F.

// ------------------------------------------------------------------
// ToleranciaControle(cConfor) — tolerância (%) do controle ZZ1
//   Usada na legenda da ZZ2 para comparar com o % não conforme.
// ------------------------------------------------------------------
User Function ToleranciaControle(cConfor)

   Local nTol := 0

   If !Empty(cConfor)
      nTol := Posicione("ZZ1", 1, xFilial("ZZ1") + cConfor, "ZZ1_TOLERA")
   EndIf

Return nTol

// ------------------------------------------------------------------
// ProxCodigoZZ1() — próximo código do controle (ZZ1_CODIGO)
// ------------------------------------------------------------------
User Function ProxCodigoZZ1()

   Local nCod := 1

   // GetSXENum devolve o próximo sequencial do campo e atualiza o contador
   nCod := GetSXENum("ZZ1", "ZZ1_CODIGO")

Return StrZero(nCod, 6)          // formata com zeros à esquerda (C6)

// ------------------------------------------------------------------
// GravarLogTCC(cFuncao, oErro) — registra erro técnico em arquivo texto
// ------------------------------------------------------------------
User Function GravarLogTCC(cFuncao, oErro)

   Local cArqLog := ""
   Local nHandle := 0
   Local cLinha  := ""

   cArqLog := GetTempPath() + "tcc_erros.log"      // caminho do log
   nHandle := FOpen(cArqLog, 4)                    // 4 = abre p/ gravação
   If nHandle == -1
      nHandle := FCreate(cArqLog, 0)               // cria se não existir
   EndIf

   If nHandle > -1
      cLinha := DToC(dDataBase) + " " + Time() + " | " + cFuncao + " | " + oErro:Description + CRLF
      FSeek(nHandle, 0, 2)                         // vai para o final (append)
      FWrite(nHandle, cLinha)
      FClose(nHandle)
   EndIf

Return NIL

// ==================================================================
// VALIDAÇÕES DE CAMPO (X3_VALID) — chamadas pelo Configurador
// ==================================================================

// ------------------------------------------------------------------
// VALZZ1FORNEC() — ZZ1_FORNEC: deve existir na SA2
// ------------------------------------------------------------------
User Function VALZZ1FORNEC()

   If Empty(M->ZZ1_FORNEC)
      MsgAlert("Informe o código do fornecedor!", "Atenção")
      Return .F.
   EndIf

   // ExistCpo(cTabela, cChave, nIndice): chave da SA2 = filial + código + loja
   If !ExistCpo("SA2", xFilial("SA2") + M->ZZ1_FORNEC + M->ZZ1_LOJAFO, 1)
      MsgAlert("Fornecedor não cadastrado na SA2!", "Atenção")
      Return .F.
   EndIf

Return .T.

// ------------------------------------------------------------------
// VALZZ1VALCER() — ZZ1_VALCER: não pode ser inferior à data atual
//   (a exigência vale para a inclusão)
// ------------------------------------------------------------------
User Function VALZZ1VALCER()

   If INCLUI .And. !Empty(M->ZZ1_VALCER) .And. M->ZZ1_VALCER < dDataBase
      MsgAlert("A validade do certificado não pode ser inferior à data atual!", "Atenção")
      Return .F.
   EndIf

Return .T.

// ------------------------------------------------------------------
// VALZZ1TOLERA() — ZZ1_TOLERA: deve estar entre 0 e 100
// ------------------------------------------------------------------
User Function VALZZ1TOLERA()

   If !Empty(M->ZZ1_TOLERA) .And. (M->ZZ1_TOLERA < 0 .Or. M->ZZ1_TOLERA > 100)
      MsgAlert("A tolerância deve estar entre 0 e 100%!", "Atenção")
      Return .F.
   EndIf

Return .T.

// ------------------------------------------------------------------
// VALZZ2CONFOR() — ZZ2_CONFOR: deve existir na ZZ1
// ------------------------------------------------------------------
User Function VALZZ2CONFOR()

   If Empty(M->ZZ2_CONFOR)
      MsgAlert("Informe o controle de fornecimento (ZZ1)!", "Atenção")
      Return .F.
   EndIf

   If !ExistCpo("ZZ1", xFilial("ZZ1") + M->ZZ2_CONFOR, 1)
      MsgAlert("Controle de fornecimento não cadastrado na ZZ1!", "Atenção")
      Return .F.
   EndIf

Return .T.

// ------------------------------------------------------------------
// VALZZ2CODPRO() — ZZ2_CODPRO: deve existir na SB1
// ------------------------------------------------------------------
User Function VALZZ2CODPRO()

   If !Empty(M->ZZ2_CODPRO) .And. !ExistCpo("SB1", xFilial("SB1") + M->ZZ2_CODPRO, 1)
      MsgAlert("Produto não cadastrado na SB1!", "Atenção")
      Return .F.
   EndIf

Return .T.

// ------------------------------------------------------------------
// VALZZ2DATA() — ZZ2_DATA: não pode ser data futura (vale para inclusão)
// ------------------------------------------------------------------
User Function VALZZ2DATA()

   If INCLUI .And. !Empty(M->ZZ2_DATA) .And. M->ZZ2_DATA > dDataBase
      MsgAlert("A data da ocorrência não pode ser futura!", "Atenção")
      Return .F.
   EndIf

Return .T.

// ------------------------------------------------------------------
// VALEXCZZ1() — impede excluir uma ZZ1 que tenha ZZ2 vinculada
//   (integridade referencial na exclusão — chamada no X3_VALID
//    ou no botão Excluir da STTZZ1)
// ------------------------------------------------------------------
User Function VALEXCZZ1()

   // Existe alguma ocorrência vinculada a este controle? (índice 1 da ZZ2)
   If ExistCpo("ZZ2", xFilial("ZZ2") + ZZ1->ZZ1_CODIGO, 1)
      MsgAlert("Não é possível excluir: existem ocorrências (ZZ2) vinculadas a este controle!", "Atenção")
      Return .F.
   EndIf

Return .T.

// ==================================================================
// CLASSE POO — ClsFornecimento (representa um controle da ZZ1)
// ==================================================================
Class ClsFornecimento

   Data cCodigo
   Data cFornec
   Data cLoja
   Data cCertif
   Data dValCer
   Data nTolera

   Method New(cCodigo) Constructor
   Method NomeFornecedor()
   Method CertificadoVencido()
   Method CertificadoVencendo()
   Method DentroDaTolerancia(nQtdOk, nQtdNok)

EndClass

// Carrega o controle ZZ1 a partir do código
Method New(cCodigo) Class ClsFornecimento

   ::cCodigo := cCodigo

   dbSelectArea("ZZ1")
   dbSetOrder(1)
   If dbSeek(xFilial("ZZ1") + cCodigo)
      ::cFornec := ZZ1->ZZ1_FORNEC
      ::cLoja   := ZZ1->ZZ1_LOJAFO
      ::cCertif := ZZ1->ZZ1_CERTIF
      ::dValCer := ZZ1->ZZ1_VALCER
      ::nTolera := ZZ1->ZZ1_TOLERA
   EndIf

Return Self

// Nome do fornecedor do controle (reusa a função da biblioteca)
Method NomeFornecedor() Class ClsFornecimento

Return NomeFornecedor(::cFornec, ::cLoja)

// Certificado já vencido?
Method CertificadoVencido() Class ClsFornecimento

Return (!Empty(::dValCer) .And. ::dValCer < dDataBase)

// Certificado vence em até 30 dias?
Method CertificadoVencendo() Class ClsFornecimento

Return CertificadoVencendo(::dValCer)

// O % de não conformidade está dentro da tolerância do controle?
Method DentroDaTolerancia(nQtdOk, nQtdNok) Class ClsFornecimento

Return PercNaoConforme(nQtdOk, nQtdNok) <= ::nTolera
