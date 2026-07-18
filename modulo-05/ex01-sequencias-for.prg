// Exercício 1 — Sequências com FOR/NEXT
// a) Imprima os números de 1 a 100
// b) Imprima os números de -50 a 50
// c) Imprima os números de 80 a 5 em ordem decrescente

PROCEDURE Main()

   LOCAL nI

   ? "=== Exercício 1: Sequências com FOR/NEXT ==="
   ?

   // a) Números de 1 a 100
   ? "a) Números de 1 a 100:"
   FOR nI := 1 TO 100
      ?? Str(nI) + " "
   NEXT
   ?

   // b) Números de -50 a 50
   ? "b) Números de -50 a 50:"
   FOR nI := -50 TO 50
      ?? Str(nI) + " "
   NEXT
   ?

   // c) Números de 80 a 5 em ordem decrescente
   ? "c) Números de 80 a 5 (decrescente):"
   FOR nI := 80 TO 5 STEP -1
      ?? Str(nI) + " "
   NEXT
   ?

   ? "Pressione qualquer tecla para sair..."
   Inkey(0)

RETURN