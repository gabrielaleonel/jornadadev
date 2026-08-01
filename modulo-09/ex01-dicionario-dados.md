# Exercício 1 — Dicionário de dados completo (SZ1 e SZ2)

> Sem ambiente Protheus disponível, segue a configuração que eu faria no Configurador (SIGACFG), com base na apostila. Tipos/tamanhos seguem o padrão do Protheus; se a apostila indicar valores diferentes, ajustar nos campos correspondentes.

## SX2 — Cadastro das tabelas (modo Compartilhado)

No *Dicionário de Dados → Tabelas (SX2)*, cadastrar as duas tabelas do projeto, ambas em **modo Compartilhado** (SX2 → flag de compartilhamento), para que os dados sejam compartilhados entre as empresas do ambiente:

| Tabela | Descrição | Modo |
|--------|-----------|------|
| SZ1 | Contatos | Compartilhado |
| SZ2 | Interações | Compartilhado |

## SX3 — Campos

**Tabela SZ1 (Contatos):**

| Campo | Tipo | Tamanho | Descrição | Observação |
|-------|------|---------|-----------|------------|
| Z1_FILIAL | C | 2 | Filial | Obrigatório |
| Z1_CODIGO | C | 6 | Código do contato | Chave |
| Z1_NOME | C | 50 | Nome do contato | |
| Z1_CLIENTE | C | 6 | Cliente vinculado (SA1) | Validado na gravação |
| Z1_ASSUNTO | C | 40 | Assunto | Validado na gravação |

**Tabela SZ2 (Interações):**

| Campo | Tipo | Tamanho | Descrição | Observação |
|-------|------|---------|-----------|------------|
| Z2_FILIAL | C | 2 | Filial | Obrigatório |
| Z2_CONTAT | C | 6 | Contato (SZ1) | Validado com ExistCpo |
| Z2_SEQUEN | C | 4 | Sequencial da interação | |
| Z2_DATA | D | 8 | Data | Gatilho → dDataBase |
| Z2_HORA | C | 8 | Hora | Gatilho → Time() |
| Z2_USUAR | C | 20 | Usuário | Gatilho → cNomUsr |
| Z2_TIPO | C | 1 | Tipo de interação | Domínio SX5 Z2 (E/L/R/V/W) |
| Z2_CODIGO | C | 6 | Código do contato | **Campo VIRTUAL** (POSICIONE) |
| Z2_ASSUNT | C | 40 | Assunto do contato | **Campo VIRTUAL** (POSICIONE) |

## SIX — Índices

No cadastro de cada tabela (SX2), definir os índices:

| Tabela | Ordem | Expressão |
|--------|-------|-----------|
| SZ1 | 1 | Z1_FILIAL + Z1_CODIGO |
| SZ2 | 1 | Z2_FILIAL + Z2_CONTAT + Z2_SEQUEN |

## SX5 — Domínio Z2 (tipos de interação)

No *Dicionário de Dados → Domínios (SX5)*, criar o domínio de código **Z2** com os tipos de interação (descrições sugeridas, ajustar conforme a apostila):

| Código | Descrição sugerida |
|--------|--------------------|
| E | E-mail |
| L | Ligação |
| R | Reunião |
| V | Visita |
| W | WhatsApp |

## Passos finais

1. Rodar a **rotina de fórmulas** para o framework reconhecer as tabelas novas.
2. Conferir no **MPSDU** (somente desenvolvimento) que SZ1 e SZ2 aparecem com campos e índices corretos.
3. **Evidência:** prints do Configurador (SX2, SX3, SIX, SX5) e do MPSDU iriam para `modulo-09/evidencias/`.
