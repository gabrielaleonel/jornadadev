# Exercício 4 — Menu no SIGACOM

> Sem ambiente Protheus disponível, segue o passo a passo que eu executaria no Configurador para publicar as rotinas no menu do módulo de Compras.

## Estrutura desejada

```
Compras
  ├── Cadastros
  │     ├── Contatos           → USER FUNCTION STTIP003
  │     └── Interações (todas) → USER FUNCTION STTIP004B
```

## Passos

1. **Abrir o Configurador (SIGACFG)** → **Menu do Sistema**.
2. Selecionar o **módulo de Compras** (SIGACOM).
3. Criar (se ainda não existir) a opção de menu **Cadastros** (pasta/menu agrupador).
4. Dentro de **Cadastros**, incluir a opção **Contatos**:
   - **Função:** `STTIP003` (a rotina de Contatos, com mBrowse + botão Interações).
   - Nome/legenda do menu: "Contatos".
5. Ainda em **Cadastros**, incluir a opção **Interações (todas)**:
   - **Função:** `STTIP004B` (a cópia da STTIP004 **sem filtro** → listagem geral).
   - Nome/legenda do menu: "Interações (todas)".
6. **Salvar** o menu e sair do Configurador.
7. No SmartClient, acessar **Compras → Cadastros** e testar as duas opções abrindo sem erro.

> **Obs.:** a STTIP004 (com filtro) não vai ao menu — ela é chamada pelo **botão "Interações"** dentro da rotina de Contatos, recebendo o contato selecionado.
