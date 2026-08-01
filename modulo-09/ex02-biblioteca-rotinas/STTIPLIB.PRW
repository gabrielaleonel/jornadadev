// STTIPLIB.PRW — Biblioteca de funções do projeto Contatos/Interações
// Funções: NomeCliente(), ProxCodigoSZ1(), ProxSequenSZ2(),
//          DescTipoInteracao(), GRAVARLOG() (adicionada no Ex. 6)

#include "protheus.ch"

// ------------------------------------------------------------------
// NomeCliente(cCodigo) — retorna o nome do cliente pela SA1
// ------------------------------------------------------------------
USER FUNCTION NomeCliente(cCodigo)

   LOCAL cNome := ""

   IF !Empty(cCodigo)
      // POSICIONE: busca na SA1 pela chave (filial + código) e devolve A1_NOME
      cNome := POSICIONE("SA1", 1, xFilial("SA1") + cCodigo, "A1_NOME")
   ENDIF

RETURN cNome

// ------------------------------------------------------------------
// ProxCodigoSZ1() — retorna o próximo código do contato (Z1_CODIGO)
// ------------------------------------------------------------------
USER FUNCTION ProxCodigoSZ1()

   LOCAL nCod := 1

   // GetSXENum devolve o próximo sequencial do campo e atualiza o contador
   nCod := GetSXENum("SZ1", "Z1_CODIGO")

RETURN StrZero(nCod, 6)          // formata com zeros à esquerda (C6)

// ------------------------------------------------------------------
// ProxSequenSZ2() — retorna o próximo sequencial da interação (Z2_SEQUEN)
// ------------------------------------------------------------------
USER FUNCTION ProxSequenSZ2()

   LOCAL nSeq := 1

   nSeq := GetSXENum("SZ2", "Z2_SEQUEN")

RETURN StrZero(nSeq, 4)          // formata com zeros à esquerda (C4)

// ------------------------------------------------------------------
// DescTipoInteracao(cTipo) — descrição do tipo de interação (E/L/R/V/W)
// ------------------------------------------------------------------
USER FUNCTION DescTipoInteracao(cTipo)

   LOCAL cDesc := ""

   DO CASE
      CASE cTipo == "E" ; cDesc := "E-mail"
      CASE cTipo == "L" ; cDesc := "Ligação"
      CASE cTipo == "R" ; cDesc := "Reunião"
      CASE cTipo == "V" ; cDesc := "Visita"
      CASE cTipo == "W" ; cDesc := "WhatsApp"
      OTHERWISE          ; cDesc := cTipo
   ENDCASE

RETURN cDesc

// ------------------------------------------------------------------
// GRAVARLOG(cFuncao, oErro) — registra erro em arquivo texto
// (função pedida no Exercício 6, adicionada à biblioteca)
// ------------------------------------------------------------------
USER FUNCTION GRAVARLOG(cFuncao, oErro)

   LOCAL cArqLog
   LOCAL nHandle
   LOCAL cLinha

   cArqLog := GetTempPath() + "sttip_erros.log"   // caminho do log
   nHandle := FOpen(cArqLog, 4)                   // 4 = abre p/ gravação
   IF nHandle == -1
      nHandle := FCreate(cArqLog, 0)              // cria se não existir
   ENDIF

   IF nHandle > -1
      cLinha := DToC(dDataBase) + " " + Time() + " | " + cFuncao + " | " + oErro:Description + CRLF
      FSeek(nHandle, 0, 2)                        // vai para o final (append)
      FWrite(nHandle, cLinha)
      FClose(nHandle)
   ENDIF

RETURN NIL
