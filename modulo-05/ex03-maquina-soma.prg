// Exercício 3 — Máquina de soma
// Leia valores do usuário até que o valor 0 seja digitado.
// Ao final, mostre:
// - A soma total dos valores
// - A quantidade de valores somados (não conte o 0 final)

PROCEDURE Main()

   LOCAL nValor := 0
   LOCAL nTotal := 0
   LOCAL nQtd := 0
   LOCAL cValor := ""

   ? "=== Exercício 3: Máquina de Soma ==="
   ?

   // Lê o primeiro valor antes do loop
   ? "Digite valores inteiros (0 para calcular e sair):"
   ACCEPT "Valor: " TO cValor
   nValor := Val(cValor)

   WHILE nValor != 0
      nTotal += nValor
      nQtd++
      ?
      ? "Digite outro valor (0 para calcular e sair):"
      ACCEPT "Valor: " TO cValor
      nValor := Val(cValor)
   ENDDO

   ?
   ? "=== Resultado ==="
   ? "Quantidade de valores somados: " + Str(nQtd)
   ? "Soma total: " + Str(nTotal)
   ?

   ? "Pressione qualquer tecla para sair..."
   Inkey(0)

RETURN