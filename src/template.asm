; @autor: D
; Plantilla basica para un programa de turboensamblador x86
; en sistemas tipo DOS
; Cada vez que inicies un nuevo programa es recomendable
; copiar esta plantilla y modificarla segun tus necesidades

.model small      ; Modelo de memoria pequeño

.stack 100h       ; Tamaño de la pila

.data             ; Sección de datos

.code             ; Sección de código
main proc
    ; Codigo aqui

    ; Terminar el programa
    ; Es fundamental agregar esta sentencia de aqui ya que de lo contrartio,
    ; el programa jamas terminara. En caso de que eso ocurra solo basta con
    ; cerrar y abrir el emulador de DosBox.
    mov ax, 4C00h
    int 21h

end