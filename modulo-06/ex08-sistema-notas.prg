// Exercício 8 — Sistema de notas (array multidimensional)
// Lê nome e 4 notas de N alunos, calcula média, lista aprovados e reprovados

FUNCTION Main()

   LOCAL aAlunos := {}
   LOCAL nN
   LOCAL nI, nJ
   LOCAL cNome
   LOCAL aNotas := {}
   LOCAL nNota
   LOCAL nSoma
   LOCAL nMedia
   LOCAL lAprovado

   ? "=== Sistema de Notas ==="
   ?

   ACCEPT "Quantos alunos? " TO nN
   nN := Val(nN)

   // Leitura dos alunos
   FOR nI := 1 TO nN
      ?
      ? "Aluno " + AllTrim(Str(nI)) + ":"
      ACCEPT "  Nome: " TO cNome

      aNotas := {}
      nSoma := 0

      FOR nJ := 1 TO 4
         ACCEPT "  Nota " + AllTrim(Str(nJ)) + ": " TO nNota
         nNota := Val(nNota)
         AADD(aNotas, nNota)
         nSoma := nSoma + nNota
      NEXT

      nMedia := nSoma / 4

      AADD(aAlunos, {cNome, aNotas[1], aNotas[2], aNotas[3], aNotas[4], nMedia})
   NEXT

   // Listar aprovados e reprovados
   ?
   ? "==========================="
   ? "      APROVADOS (média >= 7)"
   ? "==========================="
   FOR nI := 1 TO Len(aAlunos)
      IF aAlunos[nI][6] >= 7
         ? aAlunos[nI][1] + " — Média: " + AllTrim(Str(aAlunos[nI][6], 6, 2))
      ENDIF
   NEXT

   ?
   ? "==========================="
   ? "      REPROVADOS (média < 7)"
   ? "==========================="
   FOR nI := 1 TO Len(aAlunos)
      IF aAlunos[nI][6] < 7
         ? aAlunos[nI][1] + " — Média: " + AllTrim(Str(aAlunos[nI][6], 6, 2))
      ENDIF
   NEXT

   ?
   ? "Pressione qualquer tecla para sair..."
   Inkey(0)

RETURN NIL
