# Exercício 7 — 🎉 A brincadeira do CEP: gatilho que preenche o endereço

> **Material de referência:** o PDF cita `modulo-08/cep/GATILHO-CEP.md` e `modulo-08/cep/stcep.prw`, mas essa pasta não está presente no repositório (só o PDF do módulo). As respostas abaixo são conceituais e valem para qualquer implementação do gatilho de CEP.

## a. Qual a diferença entre campo, contra-domínio e regra num gatilho?

Um gatilho no SX7 é composto por três partes:

- **Campo (X7_CAMPO)** — é o campo **que dispara** o gatilho quando o usuário o altera/sai dele. Ex.: `A1_CEP`. É o "gatilho do evento".
- **Contra-domínio (X7_CDOMINIO)** — é o campo **que será preenchido** pela ação do gatilho. Ex.: `A1_BAIRRO`, `A1_MUN`, `A1_EST`. É o "alvo" que recebe o valor.
- **Regra (X7_REGRA)** — é o **código/expressão** executado para gerar o valor do contra-domínio. Ex.: `U_STCEP(M->A1_CEP,"BAIRRO")`. É o "como preencher".

Resumindo: o usuário digita no **campo** → o sistema executa a **regra** → o resultado é gravado no **contra-domínio**.

## b. Por que a regra usa M->A1_CEP e não SA1->A1_CEP?

Porque o `M->` representa o valor **em edição** (memória), ou seja, o CEP que o usuário acabou de digitar e que **ainda não foi gravado** no registro. Já o `SA1->` representa o valor **já gravado** no arquivo (o CEP antigo). Como o gatilho dispara **no momento da digitação, antes do salvamento**, para preencher o endereço com o CEP novo é preciso ler `M->A1_CEP`. Usar `SA1->A1_CEP` preencheria com o valor antigo.

## c. Os CEPs estão dentro do fonte. Cite dois problemas disso em produção e como você resolveria.

1. **Manutenção com recompilação:** para corrigir/adicionar um CEP, seria preciso alterar o fonte, recompilar (F9), gerar nova versão do RPO e atualizar **todos os ambientes**. Isso é lento e arriscado em produção.
   **Solução:** criar uma **tabela do dicionário** (ex.: tabela ZZ de CEP) com CEP, bairro, município e UF, mantida pelo próprio usuário via um CRUD no Configurador. A função do gatilho passa a **consultar essa tabela**, sem precisar tocar no fonte.

2. **Desatualização e volume:** a base de CEPs do país é grande e muda com frequência; um fonte não escala e nunca fica em dia.
   **Solução:** integrar um **serviço externo** (API dos Correios, ViaCEP etc.) — a função consulta o serviço na hora, retorna o endereço e grava. Dados sempre atualizados e nenhuma recompilação.

**Resposta final:** resolveria com uma combinação — tabela do dicionário para manter os dados de forma simples e, quando possível, serviço externo (ViaCEP/Correios) para garantia de atualização automática.

## d. Se pedissem para preencher também o código do município (A1_COD_MUN), o que você faria?

Adicionaria mais um gatilho na sequência do campo `A1_CEP`, com **contra-domínio `A1_COD_MUN`** e uma regra que retorna o código do município:

```
Sequência   Contra-domínio   Regra
004         A1_COD_MUN       U_STCEP(M->A1_CEP,"CODMUN")
```

Para isso, eu ampliaria a USER FUNCTION `U_STCEP` para tratar também o parâmetro `"CODMUN"`, retornando o código IBGE do município encontrado — buscando na **tabela de CEP** do dicionário (se tiver a coluna de código) ou no **serviço externo** que já retorna esse dado junto com bairro/cidade/UF.
