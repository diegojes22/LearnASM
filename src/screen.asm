; ==={ screen.asm }===
; Jugando con la interrupcion de video (scroll y posicion del cursor
; @autor: D

; El siguiente programa es muy simple ya que lo unico que hace es
; intercvambiar los valores entre dos registros, ayudandonos en
; la capoacidad de sepoarar los registros generales de 16 bits en
; dos partes de 8 bits.

; Aclaracion: Este programa no hace nada util mas haya de mostrar
; lo anterior. Ademas, a la hora de ensamblarlo y ejecutarlo, no se
; mostrara nada en pantalla.
.model small      ; Modelo de memoria pequeño

.stack 100h       ; Tamaño de la pila

.data             ; Sección de datos

.code             ; Sección de código
main proc
    ; Scroll de la pantalla para limpiarla y poner el color en azul con letras blancas
    mov ah, 06h
    mov al, 00h
    mov bh, 1Fh     ; Color (1 = azul, F = blanco)

    ; La parte de colores se explica a fondo en la parte de /doc/colors.md,
    ; pero basicamente, el color se representa con un byte, donde los 4 bits
    ; mas significativos representan el color de fondo, y los 4 bits menos
    ; significativos representan el color de las letras. 

    ; Con los siguientes valores, indicamos que toda la pantalla
    ; (desde el punto superior izquierdo (0,0) hasta el punto inferior derecho (79,24))
    ; se limpie con el color indicado en bh (azul con letras blancas)
    mov ch, 0      ; Fila superior (y1)
    mov cl, 0      ; Columna izquierda (x1)
    mov dh, 24     ; Fila inferior (y2)
    mov dl, 79     ; Columna derecha (x2)
    int 10h        ; Llamada a la interrupción de video para limpiar la pantalla

    ; Posicion del cursor (esto es como el gotoxy de C)
    mov ah, 02h    ; Función para mover el cursor
    mov bh, 0      ; Página de video
    mov dl, 50     ; Columna (0-79) x
    mov dh, 5      ; Fila (0-24) y
    int 10h        ; Llamada a la interrupción de video

    ; Mover el cursor a la esquina superior izquierda después de imprimir
    mov ah, 02h    ; Función para mover el cursor
    mov bh, 0      ; Página de video
    mov dl, 0     ; Columna (0-79) x
    mov dh, 0      ; Fila (0-24) y
    int 10h        ; Llamada a la interrupción de video

    ; Terminar el programa
    mov ax, 4C00h
    int 21h        ; call kernel to exit

end