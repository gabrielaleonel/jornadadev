// matematica.prg — Biblioteca de Funções Matemáticas
// Incluída com SET PROCEDURE TO matematica.prg

// -------------------------------------------------------
// FatorialN(nN) — calcula o fatorial de N
// -------------------------------------------------------
FUNCTION FatorialN(nN)

   LOCAL nResult := 1
   LOCAL nI

   IF nN < 0
      RETURN NIL
   ENDIF

   IF nN == 0
      RETURN 1
   ENDIF

   FOR nI := 1 TO nN
      nResult := nResult * nI
   NEXT

RETURN nResult

// -------------------------------------------------------
// EhPrimo(nN) — retorna .T. se N é primo
// -------------------------------------------------------
FUNCTION EhPrimo(nN)

   LOCAL nI

   IF nN <= 1
      RETURN .F.
   ENDIF

   IF nN <= 3
      RETURN .T.
   ENDIF

   IF nN % 2 == 0 .OR. nN % 3 == 0
      RETURN .F.
   ENDIF

   nI := 5
   DO WHILE nI * nI <= nN
      IF nN % nI == 0 .OR. nN % (nI + 2) == 0
         RETURN .F.
      ENDIF
      nI := nI + 6
   ENDDO

RETURN .T.

// -------------------------------------------------------
// MMC(nA, nB) — mínimo múltiplo comum
// -------------------------------------------------------
FUNCTION MMC(nA, nB)

   LOCAL nMaior, nMenor, nResultado

   IF nA == 0 .OR. nB == 0
      RETURN 0
   ENDIF

   nMaior := Max(nA, nB)
   nMenor := Min(nA, nB)
   nResultado := nMaior

   DO WHILE nResultado % nMenor != 0
      nResultado := nResultado + nMaior
   ENDDO

RETURN nResultado

// -------------------------------------------------------
// MDC(nA, nB) — máximo divisor comum (Euclides)
// -------------------------------------------------------
FUNCTION MDC(nA, nB)

   LOCAL nTemp

   DO WHILE nB != 0
      nTemp := nB
      nB := nA % nB
      nA := nTemp
   ENDDO

RETURN nA
