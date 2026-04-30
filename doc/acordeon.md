> este archivo es temporal y solo se realizo como metodo de estudio para mi examen de TASM

# Interrupcion 10h
Esta interrupcion se encarga de llamar los servicios de **Video**. Para llamar dichos servicios es
necesario usar el registro **`AH`**

### Servicios

- **01h** -> Cambiar el estilo del cursor
```
BH = 0
DH = Fila
DL = Columna
```

- **02h** -> Posicion del cursor
```
BH = 0
DH = Fila (y)
DL = Columna (x)
```

- **06h** -> Scroll Up
```
AL = Lineas para desplazar hacia arriba (0 es para limpiar pantalla)
BH = Color
CH = Fila Superior (Y1)
CL = Columna Izquierda (X1)
DH = Fila Inferior (Y2)
DL = Columna Derecha (X2)
```

- **07h** -> Scroll Down
```
Los argumentos son los mismos que los del servicio 06h
```

- **09h** -> Imprimir caracter
```
AL = Codigo Ascii del caracter
CX = Veces a imprimir el caracter
BH = 0
```

---
# Interrupcio 21h
Esta interrupcion contiene servicios de la BIOS

- **01h** -> Leer un caracter
```
AL = Codigo ascii del caracter capturado
```

- **09h** -> Imprimir un mensaje en pantalla
```
DX = Referencia a la cadena a imprimir (offset)
CX = Longitud del mensaje a imprimir (no exeder longitud)
```

- **0Bh** -> Detectar si se esta pulsando una tecla
```
AL = Deteccion de la Tecla
```
    Si `AL` es igual a **0000h** entonces no hay una tecla pulsada.
    Si `AL` es igual a **00FFh**, entonces si se pulso una tecla.