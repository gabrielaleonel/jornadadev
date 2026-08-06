# AUTOAVALIACAO.md — TCC Controle ISO 9001

> Preenchido pela aluna Gabriela Oliveira, contra a **rubrica-validacao** (Rev. 1.0).
> Legenda: ✅ entregue · 🟡 parcial · ❌ não entregue

## Núcleo mínimo (piso do TCC)

| # | Item do núcleo mínimo | Onde está | Situação |
|---|-----------------------|-----------|----------|
| 1 | Tabela ZZ1 no dicionário (campos + índices) | `Dados-e-Dicionario/sx2990.csv`, `sx3990.csv`, `six990.csv` + README §3 | ✅ |
| 2 | STTZZ1.PRW — manutenção da ZZ1 (mBrowse) | `fontes/STTZZ1.PRW` | ✅ |
| 3 | Validações da ZZ1 (fornecedor na SA2; tolerância 0–100) | `fontes/STTZZLIB.PRW` (`U_VALZZ1FORNEC`, `U_VALZZ1TOLERA`) | ✅ |
| 4 | BEGIN SEQUENCE protegendo a gravação com mensagem amigável | `fontes/STTZZ1.PRW` (`U_STTZZ1GRAVAR`) | ✅ |

## Tabela de pontuação

| # | Critério (peso) | O que foi entregue | Situação |
|---|-----------------|--------------------|----------|
| 1 | Dicionário — tabelas, índices, SX3 (20%) | SX2/SX3/SIX em CSV + README §3; campos virtuais marcados; ZZ2 completa | ✅ |
| 2 | Rotinas funcionais — mBrowse, legendas, filtro (20%) | `STTZZ1.PRW` e `STTZZ2.PRW`; `aColors` na ZZ1 e na ZZ2; filtro por ZZ1 na ZZ2 (`STTZZ2FLT`) | ✅ |
| 3 | Validações campo a campo + integridade (15%) | `ExistCpo`/`Posicione` para SA2, SB1 e ZZ1; faixa da tolerância; datas não futuras | ✅ |
| 4 | Gatilhos automáticos (SX7) (10%) | `Dados-e-Dicionario/sx7990.csv` + README §5 (nome fornecedor via Posicione; data/hora automáticas) | ✅ |
| 5 | Tratamento de erros — BEGIN SEQUENCE (10%) | `U_STTZZ1GRAVAR` com `BeginTran`/`Recover`/`RollBackTran`, mensagem amigável e `U_GravarLogTCC` | ✅ |
| 6 | Biblioteca de funções comuns (10%) | `fontes/STTZZLIB.PRW` com funções reutilizadas; sem duplicação | ✅ |
| 7 | Menu no SIGACOM (5%) | `Dados-e-Dicionario/sigacom.xnu.txt` + README §8 (aponta para STTZZ1/STTZZ2) | ✅ |
| 8 | Documentação — README + evidências (10%) | `README.md` completo + `evidencias/descricao-das-telas.md` (passo a passo descrito) | ✅ |

**Total estimado: 100/100 nos critérios de código/documentação.** Prints de tela não são entregues por falta de ambiente Protheus — substituídos pela descrição escrita (conforme orientação da atividade).

## Diferenciais (pontos extras)

| Diferencial | Onde está | Situação |
|-------------|-----------|----------|
| Cabeçalho de documentação e comentários nos fontes | todos os `.PRW` | ✅ |
| Zero duplicação de código (tudo repetido virou função na STTZZLIB) | `STTZZLIB.PRW` + `MontaBrowseZZ2()` | ✅ |
| Legenda da ZZ2 comparando % NC com a tolerância (ZZ1_TOLERA) | `fontes/STTZZ2.PRW` | ✅ |
| Pelo menos uma classe ADVPL (POO) | `ClsFornecimento` em `STTZZLIB.PRW` (usada no botão "Certificado" da STTZZ1) | ✅ |
| Impedir excluir ZZ1 com ZZ2 vinculada | `U_VALEXCZZ1()` | ✅ |

## O que não foi possível (ambiente)

- ❌ Prints reais das telas do Protheus (sem ambiente) → substituídos pela descrição por escrito em `evidencias/descricao-das-telas.md`.
- 🟡 Arquivos `.DBF` físicos → entregues como **CSV** em `Dados-e-Dicionario/` (mesma informação, formato texto).

## Checklist rápido de entrega

- [x] Repositório no formato da atividade (pasta `TCC/` com `README.md`, `Dados-e-Dicionario/`, `fontes/`, `evidencias/`)
- [x] Dicionário em CSV commitado (ou estrutura descrita no README)
- [x] Fontes `.PRW` em texto (não só print)
- [x] `AUTOAVALIACAO.md` preenchido
- [x] Link do repositório na atividade do Classroom
