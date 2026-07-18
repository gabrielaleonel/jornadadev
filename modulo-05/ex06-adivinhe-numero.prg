// Exercício 6 — Desafio: jogo "Adivinhe o número"
// Crie um jogo em que:
// - O programa sorteia um número entre 1 e 100 com HB_RandomInt(1, 100)
// - O usuário tem 7 tentativas
// - A cada palpite errado, informe se o número secreto é maior ou menor
// - Ao acertar ou esgotar as tentativas, mostre o resultado (e revele o número)

PROCEDURE Main()

   LOCAL nSecreto := 0
   LOCAL nPalpite := 0
   LOCAL nTentativa := 0
   LOCAL nMaxTentativas := 7
   LOCAL lAcertou := .F.
   LOCAL cPalpite := ""

   // Sorteia o número secreto entre 1 e 100
   nSecreto := HB_RandomInt(1, 100)

   ? "=== Exercício 6: Adivinhe o Número ==="
   ?
   ? "Estou pensando em um número entre 1 e 100."
   ? "Você tem " + Str(nMaxTentativas) + " tentativas para adivinhar."
   ?

   // Loop de tentativas
   FOR nTentativa := 1 TO nMaxTentativas
      ? "--- Tentativa " + Str(nTentativa) + " de " + Str(nMaxTentativas) + " ---"

      DO WHILE .T.
         ? "Digite seu palpite (1 a 100):"
         ACCEPT "Palpite: " TO cPalpite
         nPalpite := Val(cPalpite)
         IF nPalpite >= 1 .AND. nPalpite <= 100
            EXIT
         ENDIF
         ? "*** Erro: o palpite deve estar entre 1 e 100! ***"
         ?
      ENDDO

      // Verifica se acertou
      IF nPalpite == nSecreto
         lAcertou := .T.
         ?
         ? "🎉 PARABÉNS! Você acertou!"
         ? "O número secreto era: " + Str(nSecreto)
         ? "Você acertou na tentativa " + Str(nTentativa) + "!"
         EXIT
      ELSE
         ?
         IF nPalpite < nSecreto
            ? "❌ Errado! O número secreto é MAIOR que " + Str(nPalpite)
         ELSE
            ? "❌ Errado! O número secreto é MENOR que " + Str(nPalpite)
         ENDIF

         // Mostra tentativas restantes
         IF nTentativa < nMaxTentativas
            ? "Tentativas restantes: " + Str(nMaxTentativas - nTentativa)
         ENDIF
      ENDIF
      ?
   NEXT

   // Se não acertou em 7 tentativas
   IF !lAcertou
      ?
      ? "😔 Suas tentativas acabaram!"
      ? "O número secreto era: " + Str(nSecreto)
   ENDIF

   ?
   ? "Pressione qualquer tecla para sair..."
   Inkey(0)

RETURN