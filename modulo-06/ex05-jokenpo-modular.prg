// Exercício 5 (Desafio) — Jokenpo Modular
// Pedra, Papel, Tesoura — com pelo menos 4 funções

FUNCTION Main()

   LOCAL cJogadaUsuario, cJogadaCPU
   LOCAL cResultado
   LOCAL nPartidas := 0
   LOCAL nVitorias := 0
   LOCAL nDerrotas := 0
   LOCAL nEmpates := 0
   LOCAL lJogar := .T.
   LOCAL cContinuar

   ? "=== Jokenpo Modular ==="
   ? "Pedra, Papel ou Tesoura"
   ?

   DO WHILE lJogar
      ?
      ? "--- Nova Partida ---"

      cJogadaUsuario := ValidarJogada()

      cJogadaCPU := SortearJogadaCPU()

      ? "Você: " + cJogadaUsuario + "  |  CPU: " + cJogadaCPU

      cResultado := DefinirVencedor(cJogadaUsuario, cJogadaCPU)

      ? "Resultado: " + cResultado

      nPartidas := nPartidas + 1

      IF "Você" $ cResultado .AND. "GANHOU" $ cResultado
         nVitorias := nVitorias + 1
      ELSEIF "CPU" $ cResultado .AND. "GANHOU" $ cResultado
         nDerrotas := nDerrotas + 1
      ELSE
         nEmpates := nEmpates + 1
      ENDIF

      ?
      ACCEPT "Jogar novamente? (S/N): " TO cContinuar
      IF Upper(AllTrim(cContinuar)) != "S"
         lJogar := .F.
      ENDIF
   ENDDO

   ?
   ? "=== Placar Final ==="
   ? "Partidas: " + AllTrim(Str(nPartidas))
   ? "Vitórias: " + AllTrim(Str(nVitorias))
   ? "Derrotas: " + AllTrim(Str(nDerrotas))
   ? "Empates:  " + AllTrim(Str(nEmpates))
   ?
   ? "Pressione qualquer tecla para sair..."
   Inkey(0)

RETURN NIL

// -------------------------------------------------------
// SortearJogadaCPU() — sorteia pedra, papel ou tesoura
// -------------------------------------------------------
FUNCTION SortearJogadaCPU()

   LOCAL aOpcoes := {"pedra", "papel", "tesoura"}
   LOCAL nSorteio

   nSorteio := (Random() % 3) + 1

RETURN aOpcoes[nSorteio]

// -------------------------------------------------------
// ValidarJogada() — valida entrada do usuário
// -------------------------------------------------------
FUNCTION ValidarJogada()

   LOCAL cJogada
   LOCAL lValida := .F.

   DO WHILE !lValida
      ACCEPT "Digite sua jogada (pedra, papel, tesoura): " TO cJogada
      cJogada := Lower(AllTrim(cJogada))

      IF cJogada == "pedra" .OR. cJogada == "papel" .OR. cJogada == "tesoura"
         lValida := .T.
      ELSE
         ? "Jogada inválida! Tente novamente."
      ENDIF
   ENDDO

RETURN cJogada

// -------------------------------------------------------
// DefinirVencedor(cJogada1, cJogada2) — retorna o vencedor
// -------------------------------------------------------
FUNCTION DefinirVencedor(cJogada1, cJogada2)

   LOCAL cResultado

   IF cJogada1 == cJogada2
      cResultado := "EMPATE!"
   ELSEIF (cJogada1 == "pedra" .AND. cJogada2 == "tesoura") .OR. ;
          (cJogada1 == "papel" .AND. cJogada2 == "pedra") .OR. ;
          (cJogada1 == "tesoura" .AND. cJogada2 == "papel")
      cResultado := "Você GANHOU!"
   ELSE
      cResultado := "CPU GANHOU!"
   ENDIF

RETURN cResultado
