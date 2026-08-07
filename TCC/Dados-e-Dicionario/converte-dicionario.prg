// converte-dicionario.prg — Exporta o dicionário de dados e a massa de
// teste do TCC para arquivos CSV.
//
// O objetivo é gerar os CSVs que ficam em Dados-e-Dicionario/ direto do
// ambiente de desenvolvimento (Protheus com os DBFs no RPO):
//   - SX2 (tabelas), SX3 (campos), SIX (índices), SX7 (gatilhos), SXB (consultas)
//   - SA2 (fornecedores), SB1 (produtos), ZZ1 (controle), ZZ2 (ocorrências)
//
// Como usar:
//   1. Adicionar o fonte ao projeto e compilar (DevStudio → F9).
//   2. Rodar pelo SmartClient a função: U_ConverteDicionario().
//   3. Os arquivos .CSV saem na pasta informada em cDir.
//
// Sem ambiente Protheus, os CSVs deste repositório foram montados a partir
// do Configurador (SIGACFG) e conferidos contra o enunciado — este fonte
// apenas documenta o processo de exportação.

#Include "protheus.ch"

User Function ConverteDicionario()

   Local cDir := "C:\Users\User\jornadadev\TCC\Dados-e-Dicionario\"

   // 1) Dicionário de dados
   ExportaCSV("SX2", cDir + "sx2990.csv")
   ExportaCSV("SX3", cDir + "sx3990.csv")
   ExportaCSV("SIX", cDir + "six990.csv")
   ExportaCSV("SX7", cDir + "sx7990.csv")
   ExportaCSV("SXB", cDir + "sxb990.csv")

   // 2) Massa de teste
   ExportaCSV("SA2", cDir + "sa2990.csv")
   ExportaCSV("SB1", cDir + "sb1990.csv")
   ExportaCSV("ZZ1", cDir + "zz1990.csv")
   ExportaCSV("ZZ2", cDir + "zz2990.csv")

   MsgInfo("Dicionário exportado para CSV em " + cDir, "converte-dicionario.prg")

Return NIL

// ------------------------------------------------------------------
// ExportaCSV(cAlias, cArq) — grava o conteúdo da tabela em CSV.
//   Linha 1 = cabeçalho com os nomes dos campos (FieldName).
//   Demais  = um registro por linha, valores separados por vírgula.
// ------------------------------------------------------------------
Static Function ExportaCSV(cAlias, cArq)

   Local nHandle := 0
   Local nCampo  := 0
   Local cLinha  := ""
   Local cValor  := ""
   Local cCab    := ""

   dbSelectArea(cAlias)                        // abre a tabela informada

   // Cabeçalho: nomes dos campos do DBF
   For nCampo := 1 To FCount()
      cCab += If(nCampo > 1, ",", "") + FieldName(nCampo)
   Next nCampo

   // Cria o arquivo (0 = modo criação/gravação)
   nHandle := FCreate(cArq, 0)
   If nHandle == -1
      MsgStop("Não foi possível criar o arquivo: " + cArq, "ExportaCSV")
      Return NIL
   EndIf

   FWrite(nHandle, cCab + CRLF)

   // Percorre todos os registros
   dbGoTop()
   While !Eof()

      cLinha := ""

      For nCampo := 1 To FCount()
         cValor := CValToChar(FieldGet(nCampo))
         // evita quebrar o CSV se o valor tiver vírgula (aspas duplas)
         If "," $ cValor
            cValor := '"' + cValor + '"'
         EndIf
         cLinha += If(nCampo > 1, ",", "") + cValor
      Next nCampo

      FWrite(nHandle, cLinha + CRLF)
      dbSkip()

   EndDo

   FClose(nHandle)

Return NIL
