function MAIN()

    Local cNome:= "Gabriela"
    Local cCidade:= "SÆo Paulo - SP"
    Local cCurso:= "Harbour/ADVPL"

    hb_cdpSelect("PT850")

    QOut("=======================")
    QOut(" Ficha de Apresenta‡Æo")
    QOut("=======================")
    QOut("Nome: " + cNome)
    QOut("Cidade: " + cCidade)
    QOut("Curso: " + cCurso)
    QOut("=======================")
Return NIL