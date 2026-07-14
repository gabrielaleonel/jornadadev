// Apresentação

//Variáveis

REQUEST HB_CODEPAGE_PTWIN

FUNCTION Main()

   Set( _SET_CODEPAGE, "PTWIN" )

   LOCAL cNome := "Gabriela"
   LOCAL cCidade := "São Paulo - SP"
   LOCAL cCurso := "Harbour/AdvPL"

   QOut("==============================")
   QOut("FICHA DE APRESENTAÇÃO")
   QOut("==============================")
   QOut("Nome: " + cNome)
   QOut("Cidade: " + cCidade)
   QOut("Curso: " + cCurso)
   QOut("==============================")

RETURN NIL
