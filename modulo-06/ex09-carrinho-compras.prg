// Exercício 9 — Mini-carrinho de compras
// Array de produtos {nome, preço}, loop para adicionar, lista e total

FUNCTION Main()

   LOCAL aCarrinho := {}
   LOCAL cNome
   LOCAL cPreco
   LOCAL nPreco
   LOCAL nTotal := 0
   LOCAL nI
   LOCAL cOpcao

   ? "=== Mini Carrinho de Compras ==="
   ?

   DO WHILE .T.
      ACCEPT "Nome do produto (ou 'fim' para encerrar): " TO cNome
      cNome := AllTrim(cNome)

      IF Lower(cNome) == "fim"
         EXIT
      ENDIF

      ACCEPT "Preço do produto: R$ " TO cPreco
      nPreco := Val(cPreco)

      AADD(aCarrinho, {cNome, nPreco})
      ? "Produto adicionado: " + cNome + " — R$ " + AllTrim(Str(nPreco, 10, 2))
      ?
   ENDDO

   // Exibir itens e total
   ?
   ? "==============================="
   ? "       ITENS NO CARRINHO"
   ? "==============================="
   FOR nI := 1 TO Len(aCarrinho)
      ? AllTrim(Str(nI)) + ". " + aCarrinho[nI][1] + " — R$ " + ;
        AllTrim(Str(aCarrinho[nI][2], 10, 2))
      nTotal := nTotal + aCarrinho[nI][2]
   NEXT

   ?
   ? "==============================="
   ? "TOTAL: R$ " + AllTrim(Str(nTotal, 10, 2))
   ? "==============================="
   ?
   ? "Pressione qualquer tecla para sair..."
   Inkey(0)

RETURN NIL
