# 🚀 Jornada DEV START — Programa START · TOTVS Paulista

### Aluna: Gabriela Oliveira

![Harbour](https://img.shields.io/badge/Linguagem-Harbour-blue?style=for-the-badge&logo=)
![TOTVS](https://img.shields.io/badge/Programa-START%20TOTVS%20Paulista-green?style=for-the-badge)

---

## 🎓 Sobre o curso

O **Jornada DEV START** é um programa de formação promovido pela **TOTVS Paulista** dentro do programa **START**. O curso aborda lógica de programação, algoritmos, pseudocódigo, fluxogramas e programação em **Harbour** — uma linguagem compilada, rápida e gratuita. Ao final, teremos construído uma base sólida para encarar qualquer desafio de dev! 💪

---

## 📂 Estrutura do repositório

O projeto é organizado por **módulos**, com uma pasta para cada etapa do curso:

```
jornadadev/
├── README.md
├── modulo-01/
│   ├── ex01-hello.prg
│   ├── ex02-saudacao.prg
│   ├── ex03-apresentacao.prg
│   └── ex04-data-hora.prg
├── modulo-02/
│   └── ex01-algoritmo-media.md
├── modulo-03/
│   └── ex01-mini-projeto/
│       ├── main.prg
│       └── utils.prg
├── ...
└── modulo-10/
```

### 📌 Regras de nomenclatura

| Elemento | Formato | Exemplo |
|----------|---------|---------|
| Pasta de módulo | `modulo-XX/` (2 dígitos) | `modulo-01`, `modulo-02`, `modulo-10` |
| Exercício em Harbour | `exNN-descricao.prg` | `ex03-apresentacao.prg` |
| Exercício teórico | `exNN-descricao.md` | `ex01-algoritmo-media.md` |
| Mini-projeto | `exNN-descricao/` (subpasta) | `ex01-mini-projeto/` |

> ⚠️ **Importante:** Nomes de arquivos e pastas sempre em **minúsculo** e com **hífens** no lugar de espaços!

---

## ⚙️ Como rodar os exercícios

Para compilar e rodar os arquivos `.prg` do curso, você precisa ter o **Harbour** instalado na sua máquina.

### 1. Instale o Harbour

Acesse [https://harbour.github.io](https://harbour.github.io) e baixe a versão para o seu sistema operacional.

### 2. Compile um exercício

No terminal, navegue até a pasta do módulo e execute:

```powershell
hbmk2 .\ex01-hello.prg
```

Isso vai gerar um executável na mesma pasta. É só rodar! 🎉

```powershell
.\ex01-hello.exe
```

---

## 🔄 Fluxo de trabalho (Git)

Sempre que terminar os exercícios de uma aula, sigo esse ciclo:

```bash
# 1. Adiciona tudo que foi criado ou alterado
git add .

# 2. Salva com uma mensagem descritiva
git commit -m "modulo XX - exercicios"

# 3. Envia para o GitHub
git push
```

### 📤 Entrega das atividades

Depois do `push`, copio o link da pasta do módulo correspondente e colo na atividade do **Google Classroom**.

🔗 Formato do link:
```
github.com/gabriela-oliveira/jornadadev/tree/main/modulo-XX
```

---

## 🛠️ Ferramentas utilizadas

| Ferramenta | Uso |
|------------|-----|
| **Harbour** | Linguagem de programação compilada |
| **hbmk2** | Compilador do Harbour |
| **Git** | Controle de versão |
| **GitHub** | Hospedagem do repositório |

---

> *"Programar é como montar um quebra-cabeça: cada exercício é uma peça que encaixa no grande mapa da lógica."* 🧩
