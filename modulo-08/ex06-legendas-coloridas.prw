// Exercício 6 — Legendas coloridas na rotina STTIP002
// Cores por faixa de data de nascimento:
//   Vermelho (BR_RED)  → pet "idoso" (nascimento há mais de 30 meses ~ 10 anos)
//   Amarelo (BR_YELLOW)→ pet cadastrado hoje (ZA1_DTNASC == data atual)
//   Verde (BR_GREEN)   → demais pets (regra ".T." por ÚLTIMO)
//
// As legendas são avaliadas de cima para baixo; a 1ª condição verdadeira vence.
// Por isso ".T." (sempre verdadeiro) fica por último, como cor padrão.

#include "protheus.ch"

USER FUNCTION STTIP002()

   LOCAL aColors := {}

   dbSelectArea("ZA1")
   dbSetOrder(1)

   // Legenda 1 — idosos: nascimento há mais de 10 anos (aprox. 3650 dias)
   AADD(aColors, {"ZA1->ZA1_DTNASC < dDataBase - 3650", "BR_RED"})

   // Legenda 2 — cadastrados hoje (mesma data de nascimento registrada hoje)
   AADD(aColors, {"ZA1->ZA1_DTNASC == dDataBase", "BR_YELLOW"})

   // Legenda padrão — ".T." sempre por último
   AADD(aColors, {".T.", "BR_GREEN"})

   // mBrowse com o parâmetro aColors (11º parâmetro) e lAbort = .F. (16º)
   mBrowse(1, 1, 22, 75, "ZA1", , , , , "Pets", aColors, , , , , .F.)

RETURN NIL
