# Exercício 2 — Completando a tabela ZA1 (o pet ganha um dono)

> Sem ambiente Protheus disponível, segue a estrutura da tabela e a descrição dos passos que eu executaria no Configurador (SIGACFG).

## Estrutura final da ZA1 (SX3)

| Campo | Tipo | Tamanho | Descrição | Observação |
|-------|------|---------|-----------|------------|
| ZA1_FILIAL | C | 2 | Filial | Obrigatório em toda tabela |
| ZA1_COD | C | 6 | Código do pet | Chave do registro |
| ZA1_NOME | C | 50 | Nome do pet | |
| ZA1_RACA | C | 30 | Raça do pet | |
| ZA1_DTNASC | D | 8 | Data de nascimento | Usada nas legendas coloridas (Ex. 6) |
| ZA1_CLIENT | C | 6 | Código do cliente (dono) | Código A1_COD na SA1 |
| ZA1_LOJA | C | 2 | Loja do cliente | Código A1_LOJA na SA1 |
| ZA1_NOMCLI | C | 40 | Nome do cliente | **Campo VIRTUAL** — não é gravado |

**Campo Virtual ZA1_NOMCLI (X3_RELACAO):**
```
POSICIONE("SA1",1,xFilial("SA1")+M->ZA1_CLIENT+M->ZA1_LOJA,"A1_NOME")
```

**Índices (SIX):**
```
1 = ZA1_FILIAL + ZA1_COD                  → chave principal (busca por código)
2 = ZA1_FILIAL + ZA1_CLIENT + ZA1_LOJA    → busca pelo dono (cliente)
```

## Passos no Configurador

1. **Abrir o Configurador (SIGACFG)** no ambiente de desenvolvimento.
2. **SX3 (Campos)** — para cada campo acima:
   - Incluir o campo (ZA1_COD, ZA1_NOME, ZA1_RACA, ZA1_DTNASC, ZA1_CLIENT, ZA1_LOJA) com tipo, tamanho e título.
   - **ZA1_NOMCLI**: incluir como **campo Virtual**, marcando a opção *Virtual* e preenchendo a **relação (X3_RELACAO)** com o `POSICIONE(...)` da apostila. Campo virtual não ocupa espaço no arquivo e o valor é calculado na exibição.
3. **SIX (Índices)** — no cadastro da tabela (SX2), definir as duas expressões de índice:
   - `1 = ZA1_FILIAL + ZA1_COD`
   - `2 = ZA1_FILIAL + ZA1_CLIENT + ZA1_LOJA`
4. **Rotina de fórmulas** — rodar para o framework reconhecer a estrutura atualizada.
5. **Conferir** no MPSDU (somente desenvolvimento): campos, tipo do ZA1_NOMCLI (Virtual) e os 2 índices.
6. **Testar no SmartClient** — abrir a ZA1 (via `STTIP001`/`STTIP002`), incluir um pet, informar ZA1_CLIENT e ver o ZA1_NOMCLI sendo exibido automaticamente.

> **Nota:** a data de nascimento aparece como **ZA1_DTNASC** no código deste módulo (legendas e filtros). Mantenha no dicionário o mesmo nome usado nas rotinas para as legendas e o filtro funcionarem.
