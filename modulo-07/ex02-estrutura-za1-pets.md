# Exercício 2 — A tabela ZA1 (Pets)

## a. Campos da ZA1

| Campo | Tipo | Tamanho | Descrição |
|-------|------|---------|-----------|
| ZA1_FILIAL | C (caractere) | 2 | Filial — **obrigatório** em toda tabela do Protheus |
| ZA1_NOME | C (caractere) | 50 | Nome do pet |
| ZA1_RACA | C (caractere) | 30 | Raça do pet |
| ZA1_NASC | D (data) | 8 | Data de nascimento do pet |

## b. Índice que faria sentido para a ZA1

Índice composto: **ZA1_FILIAL + ZA1_NOME** (chave principal).

**Justificativa:** na analogia da lista telefônica, o índice funciona como o caderno já ordenado — em vez de percorrer todos os registros procurando um por um, o banco vai direto ao ponto. Como a consulta mais comum num cadastro de pets é **localizar pelo nome** (dentro de cada filial), ordenar por `ZA1_FILIAL + ZA1_NOME` torna essa busca rápida e ainda garante a unicidade da chave por filial.

## c. Por que o prefixo da tabela é Z

O **Z** é a convenção do Protheus para **tabela customizada de cliente**. As tabelas com prefixos de **A a Y** são tabelas de fábrica (padrão do sistema); o **Z** é reservado para as personalizações feitas pelo cliente/parceiro. Essa separação evita conflito de nomes com as tabelas originais e com futuras versões do Protheus.

## d. Por que os campos começam com ZA1_ e não com o nome solto

Pela convenção do Protheus, **todo campo começa com o nome da sua tabela**. Isso evita colisão de nomes entre tabelas diferentes, deixa explícito a qual tabela cada campo pertence e permite que o framework reconheça os campos automaticamente — o sistema identifica o campo pelo nome completo (ex.: `ZA1_NOME`), sem ambigüidade.
