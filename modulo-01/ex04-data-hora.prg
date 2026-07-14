FUNCTION Main()

    Local cNome:= "Gabriela"
    Local cCidade:= "SÆo Paulo - SP"
    Local cCurso:= "Harbour/ADVPL"
    Local cData := DToC(Date())
    Local cHora := Time()

    SET DATE FORMAT TO "DD/MM/YYYY"
    cData := DToC(Date())

    hb_cdpSelect("PT850")
    hb_langSelect("PT_BR")

    QOut("=================================")
    QOut("      FICHA DE APRESENTA€ÇO      ")
    QOut("=================================")
    QOut("Nome: " + cNome)
    QOut("Cidade: " + cCidade)
    QOut("Curso: " + cCurso)
    QOut("==============================")
    // Exercicio 4 - Data e Hora
    QOut("Data: " + cData)
    QOut("Hora: " + cHora)
    QOut("==============================")

RETURN NIL
