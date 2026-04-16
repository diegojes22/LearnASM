; ==={ si1.asm }===
; Aprendiendo a usar el registro SI (Source Index)
; @autor: D

; En este programa aprenderemos a usar el registro SI, el cual es un registro 
; de 16 bits que se utiliza principalmente para apuntar a datos en memoria. 
; Es comúnmente utilizado en operaciones de cadena y para acceder a datos almacenados
; en el segmento de datos.

.model small      ; Modelo de memoria pequeño
.stack 100h       ; Tamaño de la pila
.data             ; Sección de datos
    text db 'Hola Mundo $'

.code             ; Sección de código
main proc
    ; Inicializar el segmento de datos
    mov ax, @data
    mov ds, ax

    ; Cargar la dirección de la cadena en el registro SI
    mov si, offset text
    ; El apuntador SI por defecto apunta a la primera posicion de la cadena, es decir,
    ; esta en la letra 'H', asi que al incrementar SI, este apuntara a la letra 'o', 
    ; y asi sucesivamente.
    inc si
    ; Ahora, si volvi a a incrementar SI, este apuntara a la letra 'l', y asi sucesivamente.
    inc si

    ; Imprimir el caracter apuntado por SI
    mov ah, 09h
    mov al, [si] ; Cargar el caracter apuntado por SI en AL, para eso se utiliza el operador []
    mov cl, 01h
    mov bh, 0
    mov bl, 0Eh
    int 10h

    ; Terminar el programa
    ; Es fundamental agregar esta sentencia de aqui ya que de lo contrartio,
    ; el programa jamas terminara. En caso de que eso ocurra solo basta con
    ; cerrar y abrir el emulador de DosBox.
    mov ax, 4C00h
    int 21h

end