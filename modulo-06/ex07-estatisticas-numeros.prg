// Exercício 7 — Estatísticas de 10 números
// Lê 10 números, armazena em array, exibe ordenados, soma, média, maior, menor

FUNCTION Main()

   LOCAL aNumeros := {}
   LOCAL nI, nValor
   LOCAL nSoma := 0
   LOCAL nMedia

   ? "=== Estatísticas de 10 Números ==="
   ?

   // Leitura dos 10 números
   FOR nI := 1 TO 10
      ACCEPT "Digite o " + AllTrim(Str(nI)) + "º número: " TO nValor
      AADD(aNumeros, Val(nValor))
   NEXT

   // Cálculo da soma
   FOR nI := 1 TO Len(aNumeros)
      nSoma := nSoma + aNumeros[nI]
   NEXT

   // Média
   nMedia := nSoma / Len(aNumeros)

   // Ordenar (crescente)
   ASORT(aNumeros)

   ? ""
   ? "=== Resultados ==="
   ?

   // Números ordenados
   ? "Números em ordem crescente:"
   FOR nI := 1 TO Len(aNumeros)
      ?? AllTrim(Str(aNumeros[nI])) + " "
   NEXT
   ?

   // Soma e média
   ? "Soma:  " + AllTrim(Str(nSoma))
   ? "Média: " + AllTrim(Str(nMedia, 10, 2))
   ?

   // Maior e menor (após ASORT: aV[1] e aV[Len(aV)])
   ? "Maior: " + AllTrim(Str(aNumeros[Len(aNumeros)]))
   ? "Menor: " + AllTrim(Str(aNumeros[1]))
   ?

   ? "Pressione qualquer tecla para sair..."
   Inkey(0)

RETURN NIL
