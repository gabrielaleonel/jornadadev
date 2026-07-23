// principal.prg — Controle de Estoque Simplificado
// Compile: hbmk2 principal.prg

SET PROCEDURE TO estoque_lib.prg

FUNCTION Main()

   LOCAL aEstoque := {}
   LOCAL nOpcao

   DO WHILE .T.
      ?
      ? "========================================="
      ? "   CONTROLE DE ESTOQUE SIMPLIFICADO"
      ? "========================================="
      ? "1 — Cadastrar produto"
      ? "2 — Listar produtos"
      ? "3 — Entrada de estoque"
      ? "4 — Saída de estoque"
      ? "5 — Buscar produto por código"
      ? "6 — Relatório: valor em estoque"
      ? "0 — Sair"
      ? "========================================="

      ACCEPT "Escolha uma opção: " TO nOpcao
      nOpcao := Val(nOpcao)

      DO CASE
         CASE nOpcao == 1
            CadastrarProduto(aEstoque)

         CASE nOpcao == 2
            ListarProdutos(aEstoque)

         CASE nOpcao == 3
            EntradaEstoque(aEstoque)

         CASE nOpcao == 4
            SaidaEstoque(aEstoque)

         CASE nOpcao == 5
            BuscarProdutoMenu(aEstoque)

         CASE nOpcao == 6
            RelatorioEstoque(aEstoque)

         CASE nOpcao == 0
            ? "Saindo do sistema..."
            EXIT

         OTHERWISE
            ? "Opção inválida! Tente novamente."
      ENDCASE
   ENDDO

   ? "Programa encerrado."
   Inkey(0)

RETURN NIL

// -------------------------------------------------------
// BuscarProdutoMenu(aEstoque) — busca por código (menu)
// -------------------------------------------------------
PROCEDURE BuscarProdutoMenu(aEstoque)

   LOCAL cCodigo
   LOCAL nPos

   ?
   ? "--- Buscar Produto por Código ---"

   ACCEPT "Código do produto: " TO cCodigo
   cCodigo := AllTrim(cCodigo)

   nPos := BuscarProduto(aEstoque, cCodigo)

   IF nPos == 0
      ? "Produto não encontrado!"
   ELSE
      ? "Produto encontrado!"
      ? "Código:    " + aEstoque[nPos][1]
      ? "Nome:      " + aEstoque[nPos][2]
      ? "Quantidade: " + AllTrim(Str(aEstoque[nPos][3]))
      ? "Preço:     R$ " + AllTrim(Str(aEstoque[nPos][4], 10, 2))
   ENDIF

RETURN
