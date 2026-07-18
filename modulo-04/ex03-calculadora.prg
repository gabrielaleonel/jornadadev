FUNCTION Main()

   LOCAL cOpcao, nA, nB, nResultado

   ACCEPT "Operacao (+, -, *, /, ^, R): " TO cOpcao
   ACCEPT "Primeiro valor: " TO nA
   ACCEPT "Segundo valor: " TO nB

   nA := Val(nA)
   nB := Val(nB)
   cOpcao := Upper(cOpcao)

   DO CASE
      CASE cOpcao == "+"
         nResultado := nA + nB
      CASE cOpcao == "-"
         nResultado := nA - nB
      CASE cOpcao == "*"
         nResultado := nA * nB
      CASE cOpcao == "/"
         IF nB == 0
            ? "Erro: divisao por zero!"
            RETURN NIL
         ENDIF
         nResultado := nA / nB
      CASE cOpcao == "^"
         nResultado := nA ^ nB
      CASE cOpcao == "R"
         nResultado := Sqrt(nA)
      OTHERWISE
         ? "Operacao invalida!"
         RETURN NIL
   ENDCASE

   ? "Resultado: " + Str(nResultado, 10, 2)

   RETURN NIL
