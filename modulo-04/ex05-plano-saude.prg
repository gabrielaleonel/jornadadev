FUNCTION Main()

   LOCAL nIdade, nDependentes, nValorMensal, nTotal

   ACCEPT "Digite a idade: " TO nIdade
   ACCEPT "Numero de dependentes: " TO nDependentes

   nIdade := Val(nIdade)
   nDependentes := Val(nDependentes)

   IF nIdade <= 25
      nValorMensal := 180
   ELSEIF nIdade <= 40
      nValorMensal := 260
   ELSEIF nIdade <= 60
      nValorMensal := 380
   ELSE
      nValorMensal := 520
   ENDIF

   nTotal := nValorMensal + (nDependentes * 90)

   ? "Valor base: R$ " + Str(nValorMensal, 10, 2)
   ? "Adicional dependentes: R$ " + Str(nDependentes * 90, 10, 2)
   ? "Valor mensal total: R$ " + Str(nTotal, 10, 2)

   RETURN NIL
