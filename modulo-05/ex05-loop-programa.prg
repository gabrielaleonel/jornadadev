// Exercício 5 — Loop de programa
// Versão do Exercício 4 que fica rodando:
// ao final de cada aluno, pergunte "Deseja calcular outro? (S/N)".
// Enquanto a resposta for S, processe um novo aluno; caso contrário, encerre.

PROCEDURE Main()

   LOCAL cNome := ""
   LOCAL cDisc := ""
   LOCAL cNota1 := ""
   LOCAL cNota2 := ""
   LOCAL nNota1 := 0
   LOCAL nNota2 := 0
   LOCAL nMedia := 0
   LOCAL cContinuar := "S"

   ? "=== Exercício 5: Loop de Programa ==="
   ?

   DO WHILE cContinuar == "S"

      // Validação do Nome (não pode ser vazio)
      DO WHILE .T.
         ? "Digite o nome do aluno:"
         ACCEPT "Nome: " TO cNome
         IF Len(Trim(cNome)) > 0
            EXIT
         ENDIF
         ? "*** Erro: o nome não pode ser vazio! ***"
         ?
      ENDDO

      ? "Nome aceito: " + cNome
      ?

      // Validação da Disciplina (exatamente 3 letras maiúsculas)
      DO WHILE .T.
         ? "Digite a disciplina (exatamente 3 letras maiúsculas: MAT, POR, etc.):"
         ACCEPT "Disciplina: " TO cDisc
         IF Len(cDisc) == 3 .AND. cDisc == Upper(cDisc)
            EXIT
         ENDIF
         ? "*** Erro: a disciplina deve ter exatamente 3 letras maiúsculas! ***"
         ?
      ENDDO

      ? "Disciplina aceita: " + cDisc
      ?

      // Validação da Nota 1 (entre 0 e 10)
      DO WHILE .T.
         ? "Digite a nota 1 (0 a 10):"
         ACCEPT "Nota 1: " TO cNota1
         nNota1 := Val(cNota1)
         IF nNota1 >= 0 .AND. nNota1 <= 10
            EXIT
         ENDIF
         ? "*** Erro: a nota deve estar entre 0 e 10! ***"
         ?
      ENDDO

      ? "Nota 1 aceita: " + Str(nNota1, 5, 2)
      ?

      // Validação da Nota 2 (entre 0 e 10)
      DO WHILE .T.
         ? "Digite a nota 2 (0 a 10):"
         ACCEPT "Nota 2: " TO cNota2
         nNota2 := Val(cNota2)
         IF nNota2 >= 0 .AND. nNota2 <= 10
            EXIT
         ENDIF
         ? "*** Erro: a nota deve estar entre 0 e 10! ***"
         ?
      ENDDO

      ? "Nota 2 aceita: " + Str(nNota2, 5, 2)
      ?

      // Cálculo da média
      nMedia := (nNota1 + nNota2) / 2

      ? "=== Dados do Aluno ==="
      ? "Nome: " + cNome
      ? "Disciplina: " + cDisc
      ? "Nota 1: " + Str(nNota1, 5, 2)
      ? "Nota 2: " + Str(nNota2, 5, 2)
      ? "Média: " + Str(nMedia, 5, 2)
      ?

      // Perguntar se deseja continuar
      DO WHILE .T.
         ? "Deseja calcular outro aluno? (S/N)"
         ACCEPT "Continuar: " TO cContinuar
         cContinuar := Upper(Trim(cContinuar))
         IF cContinuar == "S" .OR. cContinuar == "N"
            EXIT
         ENDIF
         ? "*** Erro: digite S para sim ou N para não! ***"
         ?
      ENDDO

      ?

   ENDDO

   ? "Programa encerrado. Pressione qualquer tecla para sair..."
   Inkey(0)

RETURN