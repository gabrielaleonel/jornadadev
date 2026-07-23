// Exercício 10 (Desafio) — Bubble Sort na mão
// Implementação manual do Bubble Sort, sem usar ASORT

FUNCTION Main()

   LOCAL aVetor := {}
   LOCAL nI
   LOCAL nValor

   ? "=== Bubble Sort Manual ==="
   ?

   // Leitura de 10 números
   FOR nI := 1 TO 10
      ACCEPT "Digite o " + AllTrim(Str(nI)) + "º número: " TO nValor
      AADD(aVetor, Val(nValor))
   NEXT

   // Exibir antes de ordenar
   ?
   ? "Antes da ordenação:"
   FOR nI := 1 TO Len(aVetor)
      ?? AllTrim(Str(aVetor[nI])) + " "
   NEXT

   // Bubble Sort
   BubbleSort(aVetor)

   // Exibir depois de ordenar
   ?
   ? "Depois da ordenação:"
   FOR nI := 1 TO Len(aVetor)
      ?? AllTrim(Str(aVetor[nI])) + " "
   NEXT
   ?
   ?
   ? "Pressione qualquer tecla para sair..."
   Inkey(0)

RETURN NIL

// -------------------------------------------------------
// BubbleSort(aVetor) — ordena array em ordem crescente
// -------------------------------------------------------
FUNCTION BubbleSort(aVetor)

   LOCAL nI, nJ
   LOCAL nTemp
   LOCAL nLen
   LOCAL lTrocou

   nLen := Len(aVetor)

   FOR nI := 1 TO nLen - 1
      lTrocou := .F.

      FOR nJ := 1 TO nLen - nI
         IF aVetor[nJ] > aVetor[nJ + 1]
            // Troca elementos vizinhos
            nTemp := aVetor[nJ]
            aVetor[nJ] := aVetor[nJ + 1]
            aVetor[nJ + 1] := nTemp
            lTrocou := .T.
         ENDIF
      NEXT

      // Se não houve troca, array já está ordenado
      IF !lTrocou
         EXIT
      ENDIF
   NEXT

RETURN NIL
