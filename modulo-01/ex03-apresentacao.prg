FUNCTION Main()

    Local cNome:= "Gabriela"
    Local cCidade:= "SÆo Paulo - SP"
    Local cCurso:= "Harbour/ADVPL"

    hb_cdpSelect("PT850")
    hb_langSelect("PT_BR")

    QOut("=================================")
    QOut("      FICHA DE APRESENTA€ÇO      ")
    QOut("=================================")
    QOut("Nome: " + cNome)
    QOut("Cidade: " + cCidade)
    QOut("Curso: " + cCurso)
    QOut("==============================")
RETURN NIL
