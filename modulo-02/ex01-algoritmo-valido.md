# Exercício 1 — Isto é um algoritmo válido?

| Item | Válido? | Justificativa |
|------|---------|---------------|
| a. "Some dois números." | **Não** | Falta passos de entrada (quais números?), processamento (como?) e saída (onde mostrar?). É apenas uma instrução solta, sem os três requisitos: não é **ordenado** (não define sequência de passos) e é **ambíguo** (não diz de onde pegar os números nem o que fazer com o resultado). |
| b. "Leia um número. Se for positivo, mostre 'positivo'. Senão, mostre 'negativo'." | **Sim** | É um algoritmo válido. É **finito** (termina após mostrar a mensagem), **ordenado** (passos em sequência clara: ler → testar → mostrar) e **sem ambiguidade** (uma única interpretação possível). |
| c. "Fique repetindo até acabar." | **Não** | É **infinito** (não define quando "acabar") e **ambíguo** (repetir o quê?). Não atende ao requisito de ser finito e sem ambiguidade. |
| d. "Pegue um ingrediente qualquer e cozinhe." | **Não** | É **ambíguo** em vários pontos: "ingrediente qualquer" não define entrada; "cozinhe" não detalha o processo; não há saída definida. Falta ordenação dos passos. |

**Referência — Três requisitos de um algoritmo válido:**
1. **Finito** — deve terminar em algum momento
2. **Ordenado** — passos devem estar em sequência lógica
3. **Sem ambiguidade** — cada passo deve ter uma única interpretação
