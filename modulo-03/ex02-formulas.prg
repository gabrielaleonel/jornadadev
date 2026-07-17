// Exercício 2 — Calculando com fórmulas

#define PI 3.14159

LOCAL cEntrada
LOCAL nRaio
LOCAL nA, nB
LOCAL nPeso, nAltura

QOut("=== Exercício 2: Fórmulas ===")
QOut("")

// a. Área do círculo
QOut("--- a) Área do Círculo ---")
ACCEPT "Informe o raio: " TO cEntrada
nRaio := Val(cEntrada)
QOut("Área: " + Str(PI * nRaio ^ 2, 10, 2))
QOut("")

// b. Hipotenusa
QOut("--- b) Hipotenusa ---")
ACCEPT "Informe o lado A: " TO cEntrada
nA := Val(cEntrada)
ACCEPT "Informe o lado B: " TO cEntrada
nB := Val(cEntrada)
QOut("Hipotenusa: " + Str(Sqrt(nA ^ 2 + nB ^ 2), 10, 2))
QOut("")

// c. IMC
QOut("--- c) IMC ---")
ACCEPT "Informe o peso (kg): " TO cEntrada
nPeso := Val(cEntrada)
ACCEPT "Informe a altura (m): " TO cEntrada
nAltura := Val(cEntrada)
QOut("IMC: " + Str(nPeso / nAltura ^ 2, 10, 2))
