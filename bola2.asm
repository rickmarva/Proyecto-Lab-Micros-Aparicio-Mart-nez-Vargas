section .data

        palabra_1:db 0x1b,"[10;10H","@",0xa
        tampal_1: equ $-palabra_1

        borra: db 0x1b,"[10;10H","borra",0x1b ,"[2J",0xa
        tamborra: equ $-borra

        variable: db "",0xa
        z: equ 122
        c: equ 99
        mascara: equ 255
        mascara2: equ 63

section .text
        global _start

_start:
.bloque_1:

        mov rax,1               ;rax = "sys_write"
        mov rdi,1               ;rdi = 1 (standard output=pantalla)
        mov rsi,borra           ;rsi= mensaje a imprimir
        mov rdx,tamborra        ;rdx=tamaño del string a imprimir
        syscall                 ;llamada al sistema

        mov rax,1               ;rax = "sys_write"
        mov rdi,1               ;rdi = 1 (standard output=pantalla)
        mov rsi,palabra_1       ;rsi =mensaje a imrimir
        mov rdx,tampal_1        ;rdx=tamaño del string a imprimir
        syscall                 ;llamada al sistema

        mov rax,0               ;rax ="sys_read"
        mov rdi,0               ;rdi = 0(standard input=teclado)
        mov rsi,variable        ;rsi= direccion de memoria donde será almacenado el dato recibido
        mov rdx,1               ;rdx=cuantos botones de teclado debe capturar
        syscall                 ;llamada al sistema


.bloque_3:

        mov rax,[palabra_1 + 6]      ;mueve a rax  el byte de  memoria almacenado en palabra1_ + 6
        and rax,mascara	         ;extiende el byte de rax a los 32 para ppoder compararlo con el 57 enb ascii
        cmp rax,57               ;compara si el registro es igual a 9
        je .bloque_5            ;si es igual salta al bloque 4
        jne .bloque_4           ;si no es igual salta al bloque 5

.bloque_4:		;desplazamientos a la derecha

        mov rax,[palabra_1 + 6]         ;mueve a la direccion que apunta rax, los bytes de palabra_1 con un corrimiento de 6$
        and rax,mascara                 ;realiza una mascara con los bits guardados en rax
        inc rax
        mov [palabra_1 + 6],rax
        mov rax,72
        mov [palabra_1 + 7],rax

        mov rax,64
        mov [palabra_1 + 8],rax
	syscall
        jmp .bloque_1

.bloque_5:

        mov rax,[palabra_1 + 6]
        and rax,mascara
        cmp rax,48; si es igual a 0
        je .bloque_1
        jne .bloque_6

.bloque_6:		;desplazamientos a la izquierda

        mov rax,[palabra_1 + 6]
        and rax,mascara
        dec rax
        mov [palabra_1 + 6],rax
        mov rax,72
        mov [palabra_1 + 7],rax

        mov rax,64
        mov [palabra_1 + 8],rax
	syscall
        jmp .bloque_7

.bloque_7:

	mov rax,1               ;rax = "sys_write"
        mov rdi,1               ;rdi = 1 (standard output=pantalla)
        mov rsi,borra           ;rsi= mensaje a imprimir
        mov rdx,tamborra        ;rdx=tamaño del string a imprimir
        syscall                 ;llamada al sistema

        mov rax,1               ;rax = "sys_write"
        mov rdi,1               ;rdi = 1 (standard output=pantalla)
        mov rsi,palabra_1       ;rsi =mensaje a imrimir
        mov rdx,tampal_1        ;rdx=tamaño del string a imprimir
        syscall                 ;llamada al sistema

	mov rax,0               ;rax ="sys_read"
        mov rdi,0               ;rdi = 0(standard input=teclado)
        mov rsi,variable        ;rsi= direccion de memoria donde será almacenad$
        mov rdx,1               ;rdx=cuantos botones de teclado debe capturar
        syscall                 ;llamada al sistema


	jmp .bloque_5


.final:

        mov rax,60              ;limpia registro rax
        mov rdi,0               ;elimina valores guardados en rdi
        syscall                 ;llama al sistema

