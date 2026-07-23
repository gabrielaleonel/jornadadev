// Exercício 6 — Dias da semana por índice
// Array literal com os 7 dias, leitura de 1 a 7, validação

FUNCTION Main()

   LOCAL aDias := {"Segunda-feira", "Terça-feira", "Quarta-feira", ;
                   "Quinta-feira", "Sexta-feira", "Sábado", "Domingo"}
   LOCAL nDia
   LOCAL cEntrada

   ? "=== Dias da Semana por Índice ==="
   ?

   DO WHILE .T.
      ACCEPT "Digite um número de 1 a 7 (ou 0 para sair): " TO cEntrada
      nDia := Val(cEntrada)

      IF nDia == 0
         EXIT
      ENDIF

      IF nDia >= 1 .AND. nDia <= 7
         ? "Dia " + AllTrim(Str(nDia)) + ": " + aDias[nDia]
      ELSE
         ? "Número inválido! Digite um valor de 1 a 7."
      ENDIF
   ENDDO

   ? "Programa encerrado."
   Inkey(0)

RETURN NIL
