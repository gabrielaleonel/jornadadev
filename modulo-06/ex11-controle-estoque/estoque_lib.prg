// estoque_lib.prg — Biblioteca de operações de estoque
// Incluída com SET PROCEDURE TO estoque_lib.prg

// -------------------------------------------------------
// CadastrarProduto(aEstoque) — cadastra novo produto
// -------------------------------------------------------
PROCEDURE CadastrarProduto(aEstoque)

   LOCAL cCodigo
   LOCAL cNome
   LOCAL cQtd
   LOCAL cPreco
   LOCAL nQtd, nPreco

   ?
   ? "--- Cadastrar Produto ---"

   ACCEPT "Código do produto: " TO cCodigo
   cCodigo := AllTrim(cCodigo)

   // Verificar se código já existe
   IF BuscarProduto(aEstoque, cCodigo) > 0
      ? "Erro: já existe um produto com esse código!"
      RETURN
   ENDIF

   ACCEPT "Nome do produto: " TO cNome
   cNome := AllTrim(cNome)

   ACCEPT "Quantidade: " TO cQtd
   nQtd := Val(cQtd)

   ACCEPT "Preço unitário: R$ " TO cPreco
   nPreco := Val(cPreco)

   AADD(aEstoque, {cCodigo, cNome, nQtd, nPreco})

   ? "Produto cadastrado com sucesso!"

RETURN

// -------------------------------------------------------
// ListarProdutos(aEstoque) — lista todos os produtos
// -------------------------------------------------------
PROCEDURE ListarProdutos(aEstoque)

   LOCAL nI

   ?
   ? "============================================="
   ? "         LISTA DE PRODUTOS"
   ? "============================================="
   ? "Código  |  Nome                  |  Qtd  |  Preço"
   ? "---------------------------------------------"

   FOR nI := 1 TO Len(aEstoque)
      ? aEstoque[nI][1] + "     |  " + ;
        PadR(aEstoque[nI][2], 20) + "  |  " + ;
        AllTrim(Str(aEstoque[nI][3], 5)) + "   |  R$ " + ;
        AllTrim(Str(aEstoque[nI][4], 10, 2))
   NEXT

   IF Len(aEstoque) == 0
      ? "Nenhum produto cadastrado."
   ENDIF

   ? "============================================="

RETURN

// -------------------------------------------------------
// EntradaEstoque(aEstoque) — aumenta quantidade
// -------------------------------------------------------
PROCEDURE EntradaEstoque(aEstoque)

   LOCAL cCodigo
   LOCAL nPos
   LOCAL cQtd
   LOCAL nQtd

   ?
   ? "--- Entrada de Estoque ---"

   ACCEPT "Código do produto: " TO cCodigo
   cCodigo := AllTrim(cCodigo)

   nPos := BuscarProduto(aEstoque, cCodigo)

   IF nPos == 0
      ? "Produto não encontrado!"
      RETURN
   ENDIF

   ? "Produto: " + aEstoque[nPos][2]
   ACCEPT "Quantidade a entrada: " TO cQtd
   nQtd := Val(cQtd)

   IF nQtd <= 0
      ? "Quantidade inválida!"
      RETURN
   ENDIF

   aEstoque[nPos][3] := aEstoque[nPos][3] + nQtd

   ? "Entrada realizada! Nova quantidade: " + AllTrim(Str(aEstoque[nPos][3]))

RETURN

// -------------------------------------------------------
// SaidaEstoque(aEstoque) — diminui quantidade (valida)
// -------------------------------------------------------
PROCEDURE SaidaEstoque(aEstoque)

   LOCAL cCodigo
   LOCAL nPos
   LOCAL cQtd
   LOCAL nQtd

   ?
   ? "--- Saída de Estoque ---"

   ACCEPT "Código do produto: " TO cCodigo
   cCodigo := AllTrim(cCodigo)

   nPos := BuscarProduto(aEstoque, cCodigo)

   IF nPos == 0
      ? "Produto não encontrado!"
      RETURN
   ENDIF

   ? "Produto: " + aEstoque[nPos][2] + " — Estoque: " + AllTrim(Str(aEstoque[nPos][3]))
   ACCEPT "Quantidade a dar saída: " TO cQtd
   nQtd := Val(cQtd)

   IF nQtd <= 0
      ? "Quantidade inválida!"
      RETURN
   ENDIF

   IF nQtd > aEstoque[nPos][3]
      ? "Estoque insuficiente! Disponível: " + AllTrim(Str(aEstoque[nPos][3]))
      RETURN
   ENDIF

   aEstoque[nPos][3] := aEstoque[nPos][3] - nQtd

   ? "Saída realizada! Nova quantidade: " + AllTrim(Str(aEstoque[nPos][3]))

RETURN

// -------------------------------------------------------
// BuscarProduto(aEstoque, cCodigo) — retorna posição ou 0
// -------------------------------------------------------
FUNCTION BuscarProduto(aEstoque, cCodigo)

   LOCAL nI

   FOR nI := 1 TO Len(aEstoque)
      IF aEstoque[nI][1] == cCodigo
         RETURN nI
      ENDIF
   NEXT

RETURN 0

// -------------------------------------------------------
// RelatorioEstoque(aEstoque) — valor por produto e total
// -------------------------------------------------------
PROCEDURE RelatorioEstoque(aEstoque)

   LOCAL nI
   LOCAL nValor
   LOCAL nTotal := 0

   ?
   ? "============================================="
   ? "         RELATÓRIO DE ESTOQUE"
   ? "============================================="
   ? "Produto                  |  Qtd  |  Valor Total"
   ? "---------------------------------------------"

   FOR nI := 1 TO Len(aEstoque)
      nValor := aEstoque[nI][3] * aEstoque[nI][4]
      ? PadR(aEstoque[nI][2], 24) + "|  " + ;
        AllTrim(Str(aEstoque[nI][3], 5)) + "   |  R$ " + ;
        AllTrim(Str(nValor, 12, 2))
      nTotal := nTotal + nValor
   NEXT

   IF Len(aEstoque) == 0
      ? "Nenhum produto cadastrado."
   ENDIF

   ? "---------------------------------------------"
   ? "VALOR TOTAL GERAL: R$ " + AllTrim(Str(nTotal, 12, 2))
   ? "============================================="

RETURN
