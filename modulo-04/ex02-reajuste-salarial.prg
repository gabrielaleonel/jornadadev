FUNCTION Main()

   LOCAL nSalario, nPercentual, nNovoSalario

   ACCEPT "Digite o salario atual: R$ " TO nSalario
   nSalario := Val(nSalario)

   IF nSalario < 1000
      nPercentual := 15
   ELSEIF nSalario <= 2000
      nPercentual := 12
   ELSEIF nSalario <= 4000
      nPercentual := 8
   ELSE
      nPercentual := 5
   ENDIF

   nNovoSalario := nSalario + (nSalario * nPercentual / 100)

   ? "Reajuste de " + Str(nPercentual) + "%"
   ? "Novo salario: R$ " + Str(nNovoSalario, 10, 2)

   RETURN NIL
