# Exercício 4 — Refinamento Sucessivo

Problema: *"Um sistema de caixa de supermercado deve registrar os itens de uma compra, calcular o subtotal, aplicar desconto se o cliente tiver cartão fidelidade (5%) e mostrar o total a pagar."*

---

## Nível 1 — Visão geral (3-4 passos)

```
1. Registrar itens da compra
2. Calcular subtotal
3. Aplicar desconto (se tiver cartão fidelidade)
4. Mostrar total a pagar
```

---

## Nível 2 — Detalhamento de cada passo

### Passo 1 — Registrar itens da compra

```
Início
    totalItens ← 0
    subtotal ← 0
    Leia quantidadeItens

    Enquanto (totalItens < quantidadeItens) faça
        Leia nomeItem
        Leia precoItem
        Leia qtdItem

        valorItem ← precoItem * qtdItem
        subtotal ← subtotal + valorItem
        totalItens ← totalItens + 1
    FimEnquanto
```

### Passo 2 — Calcular subtotal

```
    // O subtotal já foi acumulado no passo 1
    // A cada item registrado, o valor foi somado ao subtotal
    Escreva "Subtotal: ", subtotal
```

### Passo 3 — Aplicar desconto (se tiver cartão fidelidade)

```
    Leia temCartao

    Se (temCartao = "sim") então
        desconto ← subtotal * 0.05
        totalPagar ← subtotal - desconto
        Escreva "Desconto aplicado: ", desconto
    Senão
        totalPagar ← subtotal
    FimSe
```

### Passo 4 — Mostrar total a pagar

```
    Escreva "Total a pagar: ", totalPagar
Fim
```

---

## Pseudocódigo completo (Nível 2 integrado)

```
Início
    totalItens ← 0
    subtotal ← 0
    Leia quantidadeItens

    Enquanto (totalItens < quantidadeItens) faça
        Leia nomeItem
        Leia precoItem
        Leia qtdItem
        valorItem ← precoItem * qtdItem
        subtotal ← subtotal + valorItem
        totalItens ← totalItens + 1
    FimEnquanto

    Escreva "Subtotal: ", subtotal

    Leia temCartao
    Se (temCartao = "sim") então
        desconto ← subtotal * 0.05
        totalPagar ← subtotal - desconto
        Escreva "Desconto aplicado: ", desconto
    Senão
        totalPagar ← subtotal
    FimSe

    Escreva "Total a pagar: ", totalPagar
Fim
```
