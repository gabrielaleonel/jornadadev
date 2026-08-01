// Exercício 5 — Primeiro contato com erros (Harbour puro — não precisa de Protheus)
//
// Objetivo do exercício:
//   a. Provocar de propósito uma divisão por zero
//   b. Capturar o erro com BEGIN SEQUENCE / RECOVER WITH oErro
//   c. Exibir oErro:Description
//   d. Continuar executando normalmente depois do tratamento
//
// Para rodar (ex.: com o Harbour instalado):  hbmk2 ex05-tratamento-erros.prg

FUNCTION Main()

   LOCAL nA := 10
   LOCAL nB := 0
   LOCAL nRes

   ? "=== Teste de tratamento de erros ==="
   ?

   // BEGIN SEQUENCE ... RECOVER ... END SEQUENCE é o bloco de proteção:
   // qualquer erro (ou Break()) que acontecer dentro dele é capturado no RECOVER.
   BEGIN SEQUENCE
      nRes := nA / nB                       // (a) divide por zero DE PROPÓSITO
      QOut("Resultado: " + Str(nRes))       // (não deve chegar aqui — o erro vem antes)
   RECOVER WITH oErro                        // (b) oErro recebe o objeto de erro
      QOut("Erro capturado: " + oErro:Description)   // (c) mostra a descrição
   END SEQUENCE

   // (d) o programa segue vivo mesmo depois do erro tratado
   QOut("O programa continua de pé!")

   ?

RETURN NIL
