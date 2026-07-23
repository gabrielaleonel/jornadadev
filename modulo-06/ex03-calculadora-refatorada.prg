// Exercício 3 — Calculadora Refatorada
// Calculadora do Módulo 4 refatorada com funções separadas

FUNCTION Main()

   LOCAL nNum1, nNum2, nResultado, cOp
   LOCAL lContinuar := .T.

   DO WHILE lContinuar
      ?
      ? "=== Calculadora Refatorada ==="
      ?

      nNum1 := LerNumero("Digite o primeiro número: ")
      nNum2 := LerNumero("Digite o segundo número: ")

      ? "Operações: +  -  *  /"
      ACCEPT "Escolha a operação: " TO cOp
      cOp := Upper(AllTrim(cOp))

      nResultado := Calcular(nNum1, nNum2, cOp)

      IF nResultado == NIL
         ? "Erro: operação inválida ou divisão por zero!"
      ELSE
         MostrarResultado(nNum1, nNum2, cOp, nResultado)
      ENDIF

      ?
      ACCEPT "Deseja continuar? (S/N): " TO cOp
      IF Upper(AllTrim(cOp)) != "S"
         lContinuar := .F.
      ENDIF
   ENDDO

   ? "Saindo da calculadora..."
   Inkey(0)

RETURN NIL

// -------------------------------------------------------
// LerNumero(cMensagem) — lê e retorna um número
// -------------------------------------------------------
FUNCTION LerNumero(cMensagem)

   LOCAL cValor
   LOCAL nValor

   ACCEPT cMensagem TO cValor
   nValor := Val(cValor)

RETURN nValor

// -------------------------------------------------------
// Calcular(nNum1, nNum2, cOp) — retorna resultado ou .F.
// -------------------------------------------------------
FUNCTION Calcular(nNum1, nNum2, cOp)

   LOCAL nResultado

   DO CASE
      CASE cOp == "+"
         nResultado := nNum1 + nNum2
      CASE cOp == "-"
         nResultado := nNum1 - nNum2
      CASE cOp == "*"
         nResultado := nNum1 * nNum2
      CASE cOp == "/"
         IF nNum2 == 0
            RETURN .F.
         ENDIF
         nResultado := nNum1 / nNum2
      OTHERWISE
         RETURN .F.
   ENDCASE

RETURN nResultado

// -------------------------------------------------------
// MostrarResultado(nNum1, nNum2, cOp, nResultado)
// -------------------------------------------------------
PROCEDURE MostrarResultado(nNum1, nNum2, cOp, nResultado)

   ? ""
   ? "Resultado: " + AllTrim(Str(nNum1)) + " " + cOp + " " + AllTrim(Str(nNum2)) + " = " + AllTrim(Str(nResultado))

RETURN
