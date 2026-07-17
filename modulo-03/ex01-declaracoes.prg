// Exercício 1 — Declarando com os prefixos certos

LOCAL cNome     := "João Silva"
LOCAL nSalario  := 5500.00
LOCAL lAtivo    := .T.
LOCAL dAdmissao := SToD("20220315")
LOCAL cDepto    := "TI-001"

QOut("=== Exercício 1: Declarações ===")
QOut("")
QOut("Nome:         " + cNome)
QOut("Salário:      R$ " + Str(nSalario, 10, 2))
QOut("Ativo:        " + If(lAtivo, "Sim", "Não"))
QOut("Admissão:     " + DToC(dAdmissao))
QOut("Depto:        " + cDepto)
