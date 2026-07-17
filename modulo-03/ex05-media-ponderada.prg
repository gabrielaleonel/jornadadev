// Exercício 5 — Desafio: média ponderada

LOCAL cEntrada
LOCAL nN1, nN2, nN3, nN4
LOCAL nMedia

QOut("=== Exercício 5: Média Ponderada ===")
QOut("(pesos: 1, 2, 3, 4)")
QOut("")

ACCEPT "Nota 1 (peso 1): " TO cEntrada
nN1 := Val(cEntrada)

ACCEPT "Nota 2 (peso 2): " TO cEntrada
nN2 := Val(cEntrada)

ACCEPT "Nota 3 (peso 3): " TO cEntrada
nN3 := Val(cEntrada)

ACCEPT "Nota 4 (peso 4): " TO cEntrada
nN4 := Val(cEntrada)

nMedia := (nN1 * 1 + nN2 * 2 + nN3 * 3 + nN4 * 4) / 10

QOut("")
QOut("Média ponderada: " + Str(nMedia, 10, 2))
