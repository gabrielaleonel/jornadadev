# Exercício 1 — Conceitos fundamentais

## a. Qual é a função do AppServer?

O AppServer é o **servidor de aplicação** do Protheus. Ele é o "motor" que roda por trás: recebe as requisições enviadas pelo SmartClient, carrega o código compilado (RPO), executa as funções/rotinas ADVPL e faz a comunicação com o banco de dados. Em resumo, é ele quem processa a lógica de negócio — o SmartClient só apresenta as telas.

## b. O que é o RPO?

RPO é o **repositório de objetos** do Protheus. É um arquivo (em formato próprio, semelhante a um banco de dados) que guarda o código ADVPL compilado junto com os metadados/objetos do sistema. O AppServer lê o RPO para executar as rotinas — é dele que sai o código que roda as aplicações.

## c. Para que serve o Configurador (SIGACFG)?

O Configurador é o ambiente onde se **administra o sistema sem escrever código**. Por ele se cadastra o dicionário de dados (tabelas no SX2 e campos no SX3), além de parâmetros, perfis de acesso e outros elementos da estrutura. Foi por ele que criamos a tabela ZA1 e os campos customizados (como o A1_VOVO) — tudo "apontando e preenchendo", sem ADVPL.

## d. Qual a diferença entre campo Real e campo Virtual no SX3?

- **Campo Real**: existe **fisicamente** no arquivo DBF. Ocupa espaço no disco, é gravado no registro e pode ser usado em indexação.
- **Campo Virtual**: **não existe** no arquivo físico. O valor é **calculado em tempo de execução** por um bloco de código (ex.: a concatenação de outros campos). Não ocupa espaço no DBF nem pode ser usado como índice físico.

**Referência:** TDN — https://tdn.totvs.com
