# Exercício 5 — A1_FILIAL e xFilial()

## a. Por que existe o campo A1_FILIAL na SA1 (e em toda tabela do Protheus)?

O Protheus é **multi-empresa e multi-filial**: uma mesma tabela física (como a SA1) guarda registros de várias filiais em um único arquivo. O campo **A1_FILIAL identifica a qual filial pertence cada registro**, permitindo que dados de filiais diferentes convivam no mesmo arquivo sem se misturar. É por isso que **toda** tabela do Protheus — inclusive a ZA1 que criamos — precisa de um campo de filial: sem ele, o sistema não conseguiria filtrar/separar os dados por filial, e o conceito de filial simplesmente não funcionaria.

## b. O que a função xFilial() tem a ver com isso?

A função **xFilial()** retorna a **filial atual** para uma determinada tabela (utilizando os globais `cFilial`/`cEmpAnt` e considerando as características da tabela). É ela quem "descobre" qual filial deve ser usada a cada gravação/consulta.

**O que aconteceria se um programa "escrevesse a filial na mão"** em vez de usar `xFilial()`:
- Os registros seriam gravados/lidos na **filial errada** — ou fixos em uma filial só.
- Ao trocar de filial no sistema, a rotina continuaria usando o valor fixado, **misturando dados entre filiais** e quebrando o isolamento que o campo de filial garante.
- Resultado: **inconsistência de dados** e registros "sumindo" quando o usuário filtra pela filial correta.

Ou seja: `xFilial()` garante que o dado sempre seja gravado na filial certa do contexto atual, sem depender de valores "chutados" pelo programador.
