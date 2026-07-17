// Exercício 4 — = vs ==

LOCAL cStr1 := "Harbour"
LOCAL cStr2 := "Harb"
LOCAL lResultado

QOut("=== Exercício 4: = vs == ===")
QOut("")

// Usando = (atribuição, retorna .T. porque a atribuição teve sucesso)
lResultado := (cStr1 = cStr2)
QOut('cStr1 = cStr2  =>  ' + If(lResultado, ".T.", ".F."))

// Usando == (comparação exata, retorna .F. porque as strings são diferentes)
lResultado := (cStr1 == cStr2)
QOut('cStr1 == cStr2 =>  ' + If(lResultado, ".T.", ".F."))

QOut("")
QOut("Em Harbour, = é atribuição (sempre retorna .T. para atribuição válida).")
QOut("== é comparação exata entre strings.")
QOut('"Harbour" e "Harb" são diferentes, então == retorna .F.')
