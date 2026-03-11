; ==={ abc.asm }===
; Mostrar el abecedario completo en pantalla
; @autor: D

; Lo que debemos hacer es imprimir las letras del abecedario
; mediante un ciclo PEROOOO . . . sin usar variables u
; operaciones de incremento o decremento, es decir, sin usar inc, dec, add o sub.

.model small      ; Modelo de memoria pequeño

.stack 100h       ; Tamaño de la pila

.data             ; Sección de datos

.code             ; Sección de código
main proc
    ; Ok, esto esta mas dificil, como le hacemos . . .
    ; Ya se, esto es ineficiente pero, y si llenamos la pila con codigos ascii desde el 0
    ; hasta la 'Z' (90) . . . Creo que podria funcionar.
    mov cx, 90

    ; A llenar la pila con los codigos ascii, desde el 0 hasta el 90
    llenar_abecedario:
        push cx
        loop llenar_abecedario

    ; Ya llenamos la pila, el problema es que el abecedario esta en la parte mas
    ; baja, por lo que es hora de sacar la basura.
    mov cx, 64
    sacar_basura:
        pop ax
        loop sacar_basura

    ; Ahora si, ya tenemos el abecedario en la pila, y lo unico que tenemos que hacer es imprimirlo, 
    ; pero con un cambio de color cada letra
    mov cx, 26  ; letras del abecedario en la pila
    mostrar_abecedario:
        pop ax ; sacamos letra (al ser un valor chico se guarda en la parte baja)

        mov ah, 09h ; PRINT CHAR
        mov bh, 0
        mov bl, cl
        int 10h

        ; delay con interupcion (solo para ver el proceso de cambio de color y que se vea mas bonito)
        push cx

        mov ah, 86h
        mov cx, 0005h
        mov dx, 4240h
        int 15h

        pop cx

        loop mostrar_abecedario

    ; Si todo sale bien, deberiamos ver un colorido efecto de cambio de color mientras se 
    ; imprime el abecedario.

    ; Esto en terminos de memoria llega a ser algo ineficiente ya que para generar el abecedario
    ; sin necesidad de incrementos o sumas, necesitamos hacer ciertos trucos.
    ; Aunque funciona, no lo hagas en casa ;)

    ; Terminar el programa
    mov ax, 4C00h
    int 21h
end

; Hacer esto costo bastante :\
; Al menos la IA no sabe hacer esto, asi que no es tan malo :D