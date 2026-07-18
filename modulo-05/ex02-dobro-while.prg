// Exercício 2 — Loop indefinido: o dobro
// Leia valores inteiros indefinidamente e, para cada um, exiba o dobro do valor lido.
// Pare quando o usuário informar um valor zero ou negativo.

PROCEDURE Main()

   LOCAL nValor := 0
   LOCAL cValor := ""

   ? "=== Exercício 2: Loop indefinido - O Dobro ==="
   ?

   // Lê o primeiro valor antes do loop
   ? "Digite um valor inteiro (0 ou negativo para sair):"
   ACCEPT "Valor: " TO cValor
   nValor := Val(cValor)

   WHILE nValor > 0
      ? "Dobro de " + Str(nValor) + " = " + Str(nValor * 2)
      ?
      ? "Digite outro valor inteiro (0 ou negativo para sair):"
      ACCEPT "Valor: " TO cValor
      nValor := Val(cValor)
   ENDDO

   ?
   ? "Programa encerrado. Pressione qualquer tecla para sair..."
   Inkey(0)

RETURN