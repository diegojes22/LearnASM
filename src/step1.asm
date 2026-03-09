; ==={ Step 1 }===
; Intercambio de datos entre registros
; @autor: D

; El siguiente programa es muy simple ya que lo unico que hace es
; intercvambiar los valores entre dos registros, ayudandonos en
; la capoacidad de sepoarar los registros generales de 16 bits en
; dos partes de 8 bits.

; Aclaracion: Este programa no hace nada util mas haya de mostrar
; lo anterior. Ademas, a la hora de ensamblarlo y ejecutarlo, no se
; mostrara nada en pantalla.

.model small

.stack 100h

.data

.code
main proc
    ; Valores iniciales
    mov ax, 5
    mov bx, 10

    ; Intercambiar los valores de ax y bx
    mov ah, al
    mov al, bl
    mov bl, ah

    mov ah, 00h ; Limpiamos la parte alta de ax para evitar problemas con el valor final del registro ax

    ; Terminar el programa
    mov ax, 4C00h
    int 21h

end main