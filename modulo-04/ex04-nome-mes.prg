FUNCTION Main()

   LOCAL nMes

   ACCEPT "Digite o numero do mes (1-12): " TO nMes
   nMes := Val(nMes)

   DO CASE
      CASE nMes == 1
         ? "Janeiro"
      CASE nMes == 2
         ? "Fevereiro"
      CASE nMes == 3
         ? "Marco"
      CASE nMes == 4
         ? "Abril"
      CASE nMes == 5
         ? "Maio"
      CASE nMes == 6
         ? "Junho"
      CASE nMes == 7
         ? "Julho"
      CASE nMes == 8
         ? "Agosto"
      CASE nMes == 9
         ? "Setembro"
      CASE nMes == 10
         ? "Outubro"
      CASE nMes == 11
         ? "Novembro"
      CASE nMes == 12
         ? "Dezembro"
      OTHERWISE
         ? "Mes invalido!"
   ENDCASE

   RETURN NIL
