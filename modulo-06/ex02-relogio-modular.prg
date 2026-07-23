// Exercício 2 — Relógio Digital Modular
// Exibe a hora no formato HH:MM:SS, atualizando por ~30 segundos

FUNCTION Main()

   LOCAL cHora
   LOCAL nCont := 0

   ? "=== Relógio Digital Modular ==="
   ? "Atualizando por ~30 segundos..."
   ?

   DO WHILE nCont < 30
      cHora := ObterHora()
      cHora := FormatarHora(cHora)
      ExibirHora(cHora)
      nCont := nCont + 1
      Inkey(1)
   ENDDO

   ?
   ? "Tempo encerrado!"
   ?
   Inkey(0)

RETURN NIL

// -------------------------------------------------------
// ObterHora() — retorna a hora atual do sistema
// -------------------------------------------------------
FUNCTION ObterHora()

   LOCAL cHora

   cHora := Time()

RETURN cHora

// -------------------------------------------------------
// FormatarHora(cHora) — devolve a string formatada HH:MM:SS
// -------------------------------------------------------
FUNCTION FormatarHora(cHora)

   LOCAL cFormatada

   cFormatada := SubStr(cHora, 1, 8)

RETURN cFormatada

// -------------------------------------------------------
// ExibirHora(cHora) — exibe na tela
// -------------------------------------------------------
PROCEDURE ExibirHora(cHora)

   ? cHora

RETURN
