// principal.prg — Programa principal que usa matematica.prg
// Compile: hbmk2 principal.prg

SET PROCEDURE TO matematica.prg

FUNCTION Main()

   LOCAL nNum, nA, nB

   ? "=== Biblioteca Matemática ==="
   ?

   // Teste FatorialN
   nNum := 5
   ? "Fatorial de " + AllTrim(Str(nNum)) + " = " + AllTrim(Str(FatorialN(nNum)))

   nNum := 0
   ? "Fatorial de " + AllTrim(Str(nNum)) + " = " + AllTrim(Str(FatorialN(nNum)))
   ?

   // Teste EhPrimo
   ? "Números primos de 1 a 30:"
   FOR nNum := 1 TO 30
      IF EhPrimo(nNum)
         ?? AllTrim(Str(nNum)) + " "
      ENDIF
   NEXT
   ?

   nNum := 17
   ? AllTrim(Str(nNum)) + " é primo? " + IIF(EhPrimo(nNum), "Sim", "Não")
   nNum := 20
   ? AllTrim(Str(nNum)) + " é primo? " + IIF(EhPrimo(nNum), "Sim", "Não")
   ?

   // Teste MMC e MDC
   nA := 12
   nB := 18
   ? "MMC(" + AllTrim(Str(nA)) + ", " + AllTrim(Str(nB)) + ") = " + AllTrim(Str(MMC(nA, nB)))
   ? "MDC(" + AllTrim(Str(nA)) + ", " + AllTrim(Str(nB)) + ") = " + AllTrim(Str(MDC(nA, nB)))
   ?

   nA := 7
   nB := 5
   ? "MMC(" + AllTrim(Str(nA)) + ", " + AllTrim(Str(nB)) + ") = " + AllTrim(Str(MMC(nA, nB)))
   ? "MDC(" + AllTrim(Str(nA)) + ", " + AllTrim(Str(nB)) + ") = " + AllTrim(Str(MDC(nA, nB)))
   ?

   ? "Pressione qualquer tecla para sair..."
   Inkey(0)

RETURN NIL
