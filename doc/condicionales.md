# Condicionales en Turbo Ensamblador

Las condicionales en ensamblador permiten cambiar el flujo de ejecución del programa basándose en ciertos criterios. Esto se logra mediante la comparación de valores y el uso de saltos condicionales que evalúan los flags de estado del procesador.

## Registro de Flags (EFLAGS)

El registro EFLAGS contiene varios bits (flags) que se modifican tras operaciones aritméticas y lógicas. Estos flags son esenciales para determinar si se ejecuta un salto condicional.

### Flags Principales

| Flag | Nombre | Abreviatura | Descripción |
|------|--------|-------------|-------------|
| Zero Flag | Bandera de Cero | ZF | Se establece (=1) cuando el resultado de una operación es cero. Se limpia (=0) cuando el resultado es distinto de cero. |
| Sign Flag | Bandera de Signo | SF | Se establece cuando el resultado es negativo (bit más significativo = 1 en representación con signo). |
| Carry Flag | Bandera de Acarreo | CF | Se establece cuando una operación genera un acarreo o préstamo fuera del rango del operando. |
| Overflow Flag | Bandera de Desbordamiento | OF | Se establece cuando una operación causa desbordamiento aritmético (resultado no cabe en el rango con signo). |
| Parity Flag | Bandera de Paridad | PF | Se establece cuando el resultado tiene un número par de bits establecidos. |
| Auxiliary Flag | Bandera Auxiliar | AF | Se establece cuando hay un acarreo desde el nibble bajo (bits 0-3). |

## Instrucción CMP (Comparación)

La instrucción CMP realiza una resta entre dos operandos sin guardar el resultado, pero sí modifica los flags basándose en la diferencia.

```asm
cmp  operando1, operando2
```

Internamente hace: `operando1 - operando2` (y desecha el resultado)

### Ejemplo Básico

```asm
mov  ax, 5
mov  bx, 3
cmp  ax, bx      ; Compara AX con BX (AX - BX = 2)
                 ; ZF = 0 (resultado no es cero)
                 ; SF = 0 (resultado es positivo)
```

### Flags Modificados por CMP

- **ZF**: Se establece si operando1 = operando2
- **SF**: Refleja el signo del resultado de la resta
- **CF**: Se establece si operando1 < operando2 (en comparación sin signo)
- **OF**: Se establece si hay desbordamiento en la resta con signo
- **PF**: Se establece si el resultado tiene paridad par

## Instrucción TEST

La instrucción TEST realiza una operación AND lógica entre dos operandos sin guardar el resultado. Se utiliza frecuentemente para verificar si un valor es cero o tiene bits específicos establecidos.

```asm
test operando1, operando2
```

### Ejemplo

```asm
mov  ax, 5
test ax, ax      ; Hace AND entre AX y AX
                 ; Si AX = 0, ZF se establece
                 ; Si AX != 0, ZF se limpia
```

## Saltos Condicionales (Conditional Jumps)

Los saltos condicionales cambian el flujo del programa a una etiqueta especificada si se cumple cierta condición basada en los flags.

### Saltos Basados en Igualdad y Cero

| Instrucción | Condición | Flags | Descripción |
|-------------|-----------|-------|-------------|
| `je` etiqueta | Igual / Cero | ZF = 1 | Salta si los dos operandos de CMP son iguales |
| `jne` etiqueta | No Igual / No Cero | ZF = 0 | Salta si los dos operandos de CMP son distintos |
| `jz` etiqueta | Cero | ZF = 1 | Salta si el resultado es cero (idéntico a `je`) |
| `jnz` etiqueta | No Cero | ZF = 0 | Salta si el resultado no es cero (idéntico a `jne`) |

### Ejemplo de Salto por Igualdad

```asm
mov  al, 5
mov  bl, 5
cmp  al, bl      ; Compara AL (5) con BL (5)
je   son_iguales ; Si son iguales (ZF = 1), salta aquí
mov  al, 0       ; Esta línea NO se ejecuta
son_iguales:
                 ; Continúa aquí si saltó
```

### Saltos Comparativos Signados (Signed)

Se utilizan para comparaciones donde los números se interpretan como signados (pueden ser negativos).

| Instrucción | Condición | Flags | Descripción |
|-------------|-----------|-------|-------------|
| `jg` etiqueta | Mayor (Signed) | SF = OF y ZF = 0 | Salta si operando1 > operando2 (con signo) |
| `jge` etiqueta | Mayor o Igual (Signed) | SF = OF o ZF = 1 | Salta si operando1 >= operando2 (con signo) |
| `jl` etiqueta | Menor (Signed) | SF != OF | Salta si operando1 < operando2 (con signo) |
| `jle` etiqueta | Menor o Igual (Signed) | SF != OF o ZF = 1 | Salta si operando1 <= operando2 (con signo) |

### Ejemplo de Comparación Signada

```asm
mov  al, -5      ; AL = -5 (representado en complemento a dos)
mov  bl, 3       ; BL = 3
cmp  al, bl      ; Compara AL (-5) con BL (3)
jl   menor       ; Salta porque -5 < 3
mov  al, 0       ; NO se ejecuta
menor:
                 ; Continúa aquí
```

### Saltos Comparativos Sin Signo (Unsigned)

Se utilizan para comparaciones donde los números se interpretan como positivos (sin signo).

| Instrucción | Condición | Flags | Descripción |
|-------------|-----------|-------|-------------|
| `ja` etiqueta | Arriba / Mayor (Unsigned) | CF = 0 y ZF = 0 | Salta si operando1 > operando2 (sin signo) |
| `jae` etiqueta | Arriba o Igual (Unsigned) | CF = 0 o ZF = 1 | Salta si operando1 >= operando2 (sin signo) |
| `jb` etiqueta | Abajo / Menor (Unsigned) | CF = 1 | Salta si operando1 < operando2 (sin signo) |
| `jbe` etiqueta | Abajo o Igual (Unsigned) | CF = 1 o ZF = 1 | Salta si operando1 <= operando2 (sin signo) |

### Ejemplo de Comparación Sin Signo

```asm
mov  al, 200     ; AL = 200 (sin signo)
mov  bl, 100     ; BL = 100
cmp  al, bl      ; Compara AL (200) con BL (100)
ja   mayor       ; Salta porque 200 > 100 (sin signo)
mov  al, 0       ; NO se ejecuta
mayor:
                 ; Continúa aquí
```

### Saltos por Carry

Se utilizan para detectar acarreos en operaciones aritméticas o en comparaciones.

| Instrucción | Condición | Flags | Descripción |
|-------------|-----------|-------|-------------|
| `jc` etiqueta | Carry | CF = 1 | Salta si el carry flag está establecido |
| `jnc` etiqueta | No Carry | CF = 0 | Salta si el carry flag no está establecido |

### Saltos por Signo

Se utilizan para detectar el signo del resultado (negativo o positivo).

| Instrucción | Condición | Flags | Descripción |
|-------------|-----------|-------|-------------|
| `js` etiqueta | Signed / Negativo | SF = 1 | Salta si el resultado es negativo |
| `jns` etiqueta | Not Signed / Positivo | SF = 0 | Salta si el resultado es positivo |

### Saltos por Desbordamiento

Se utilizan para detectar desbordamiento aritmético.

| Instrucción | Condición | Flags | Descripción |
|-------------|-----------|-------|-------------|
| `jo` etiqueta | Overflow | OF = 1 | Salta si hay desbordamiento aritmético |
| `jno` etiqueta | No Overflow | OF = 0 | Salta si no hay desbordamiento |

### Salto por Contador Cero

Se utiliza específicamente con el registro contador (CX).

| Instrucción | Condición | Descripción |
|-------------|-----------|-------------|
| `jcxz` etiqueta | CX = 0 | Salta si el registro CX es cero |
| `jecxz` etiqueta | ECX = 0 | Salta si el registro ECX es cero (32 bits) |

## Estructura de una Condicional

La estructura típica de una condicional en ensamblador sigue este patrón:

```asm
; Cargar valores a comparar
mov  operando1, valor1
mov  operando2, valor2

; Comparar
cmp  operando1, operando2

; Salto condicional
je   etiqueta_si_igual
jne  etiqueta_si_no_igual

; Código si la condición no se cumple
mov  registro, valor
jmp  fin

; Código si la condición se cumple
etiqueta_si_igual:
mov  registro, otro_valor

fin:
; Continúa el programa
```

## Ejemplo Práctico Completo

Este ejemplo compara dos números y decide qué hacer según sea mayor, menor o igual:

```asm
mov  al, 15      ; AL = 15 (primer número)
mov  bl, 10      ; BL = 10 (segundo número)

cmp  al, bl      ; Comparar AL con BL (AL - BL)

je   son_iguales ; Si AL = BL, salta a son_iguales
jl   a_mayor     ; Si AL < BL, salta a a_mayor
                 ; Si llegamos aquí, AL > BL

; AL es mayor que BL
mov  cl, 1       ; CL = 1 (indicador de mayor)
jmp  continua

a_mayor:
; BL es mayor que AL
mov  cl, 2       ; CL = 2 (indicador de menor)
jmp  continua

son_iguales:
; AL es igual a BL
mov  cl, 0       ; CL = 0 (indicador de igual)

continua:
; El programa continúa aquí
; CL contiene el resultado
```

## Diferencia Entre Saltos Signados y Sin Signo

| Característica | Signado (Signed) | Sin Signo (Unsigned) |
|---|---|---|
| Interpreta números como | Con posibilidad de ser negativos | Siempre positivos |
| Rango (8 bits) | -128 a 127 | 0 a 255 |
| Flags usados | SF, OF primariamente | CF primariamente |
| Instrucciones | `jg`, `jl`, `jge`, `jle` | `ja`, `jb`, `jae`, `jbe` |
| Ejemplo: 200 vs 100 | (No válido como signado en 8 bits) | 200 > 100 = verdadero |
| Ejemplo: -5 vs 3 | -5 < 3 = verdadero | (Se interpreta como 251 > 3) |

## Recomendaciones

1. Siempre inicializa los registros antes de comparar
2. Ten claro si estás trabajando con números signados o sin signo
3. Usa `cmp` para comparaciones numéricas
4. Usa `test` para verificar si un valor es cero o tiene bits específicos
5. Documenta qué flags esperas que se establezcan
6. Prueba tu código con valores límite (0, -1, valores máximos)

## Referencia Rápida de Flags

Después de una instrucción `cmp` o `test`:

- **ZF = 1**: Los operandos son iguales (en CMP) o el resultado es cero
- **ZF = 0**: Los operandos son distintos (en CMP) o el resultado no es cero
- **CF = 1**: Hubo acarreo o préstamo (útil para unsigned)
- **SF = 1**: El resultado es negativo
- **SF = 0**: El resultado es positivo (o cero)
- **OF = 1**: Hubo desbordamiento aritmético
- **OF = 0**: No hubo desbordamiento
