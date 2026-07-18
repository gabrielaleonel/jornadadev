FUNCTION Main()

   LOCAL nValor1, nValor2

   ACCEPT "Digite o primeiro valor: " TO nValor1
   ACCEPT "Digite o segundo valor: " TO nValor2

   nValor1 := Val(nValor1)
   nValor2 := Val(nValor2)

   IF nValor1 == nValor2
      ? "Os valores sao iguais!"
   ELSEIF nValor1 > nValor2
      ? "Maior: " + Str(nValor1)
      ? "Menor: " + Str(nValor2)
   ELSE
      ? "Maior: " + Str(nValor2)
      ? "Menor: " + Str(nValor1)
   ENDIF

   RETURN NIL
