# Exercício 1 — AxCadastro × mBrowse

## a. Quando usar AxCadastro e quando usar mBrowse? Dê um exemplo de cada.

- **AxCadastro**: uso quando preciso de um CRUD **rápido e padrão** sobre uma tabela, aproveitando o que o framework gera automaticamente (pesquisar, visualizar, incluir, alterar e excluir). É o caminho mais curto para "cadastro funcionando". **Exemplo:** o CRUD da nossa tabela ZA1 (Pets) — o `STTIP001.PRW`, com pouquíssimas linhas, já gera o cadastro completo.
- **mBrowse**: uso quando preciso de **controle e personalização** — botões customizados no `aRotina`, legendas coloridas, filtros, telas com tamanho e comportamento sob medida. **Exemplo:** a rotina `STTIP002.PRW` com legendas coloridas por faixa de data de nascimento (idoso/cadastrado hoje/demais) e botão que remove o filtro do mês.

## b. Cite três coisas que o mBrowse faz e o AxCadastro não faz.

1. **Aceita legendas coloridas** (parâmetro `aColors`), pintando as linhas conforme uma condição.
2. **Aceita um filtro de dados** (`cFiltro`), exibindo apenas os registros que atendem a expressão.
3. **Permite botões customizados** no `aRotina` (tipo 6), que chamam USER FUNCTIONs próprias — o AxCadastro só monta os botões padrão de CRUD.

## c. Na configuração de legendas (aColors), por que a regra ".T." deve ficar por último?

Porque as legendas são avaliadas **de cima para baixo, na ordem** do array: a **primeira** condição que retornar verdadeiro é a que "vence". O ".T." é uma condição que sempre é verdadeira — se ele viesse antes, **nunca** deixaria as outras regras serem avaliadas, e todas as linhas ficariam com a cor dele. Colocando ".T." **por último**, ele vira o "caso padrão" (cor base), só aplicado quando nenhuma regra anterior deu certo.

## d. Qual a diferença entre um campo Virtual (X3_RELACAO) e um gatilho (SX7) para preencher o nome do cliente?

- **Campo Virtual (X3_RELACAO)**: o valor é **calculado na hora da exibição**, a partir de uma relação/expressão definida no dicionário (ex.: `POSICIONE("SA1",1,xFilial("SA1")+M->ZA1_CLIENT+M->ZA1_LOJA,"A1_NOME")`). Ele **não é gravado** — é apenas mostrado. Só serve para **ler/visualizar**.
- **Gatilho (SX7)**: dispara uma regra **quando um campo perde o foco / é validado** (ex.: ao digitar o CEP, preenche bairro/município/UF). Ele **escreve de fato** em um campo do registro (contra-domínio), ou seja, o valor preenchido **fica gravado**.

Em resumo: o campo Virtual **apresenta** um dado calculado sem gravar; o gatilho **preenche e grava** um campo a partir de uma ação do usuário.
