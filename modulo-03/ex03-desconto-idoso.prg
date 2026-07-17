// Exercício 3 — Programa completo com desconto

LOCAL cEntrada
LOCAL cNome
LOCAL dNasc
LOCAL nPreco
LOCAL nIdade
LOCAL nDesconto := 0
LOCAL nTotal

QOut("=== Exercício 3: Desconto Idoso ===")
QOut("")

ACCEPT "Nome do cliente: " TO cNome
ACCEPT "Data de nascimento (dd/mm/aaaa): " TO cEntrada
dNasc := CToD(cEntrada)
ACCEPT "Preço do produto: R$ " TO cEntrada
nPreco := Val(cEntrada)

nIdade := Int((Date() - dNasc) / 365)

IF nIdade > 60
    nDesconto := nPreco * 0.125
ENDIF

nTotal := nPreco - nDesconto

QOut("")
QOut("=== Resumo ===")
QOut("Cliente:      " + cNome)
QOut("Idade:        " + Str(nIdade) + " anos")
QOut("Preço:        R$ " + Str(nPreco, 10, 2))
QOut("Desconto:     R$ " + Str(nDesconto, 10, 2))
QOut("Total:        R$ " + Str(nTotal, 10, 2))
