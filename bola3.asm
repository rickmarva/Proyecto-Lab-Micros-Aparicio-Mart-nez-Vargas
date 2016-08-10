%macro imprime 4

	mov rax,1               ;rax = "sys_write"
        mov rdi,1               ;rdi = 1 (standard output=pantalla)
        mov rsi,%1           ;rsi= mensaje a imprimir
        mov rdx,%2        ;rdx=tamaño del string a imprimir
        syscall                 ;llamada al sistema

        mov rax,1               ;rax = "sys_write"
        mov rdi,1               ;rdi = 1 (standard output=pantalla)
        mov rsi,%3        ;rsi =mensaje a imrimir
        mov rdx,%4        ;rdx=tamaño del string a imprimir
        syscall                 ;llamada al sistema

        mov rax,0               ;rax ="sys_read"
        mov rdi,0               ;rdi = 0(standard input=teclado)
        mov rsi,variable        ;rsi= direccion de memoria donde será almacenado el dato recibido
        mov rdx,1               ;rdx=cuantos botones de teclado debe capturar
        syscall                 ;llamada al sistema

%endmacro
;Para el Macro imprime
;%1 borra
;%2 tamborra
;%3 bola_1
;%4 tambola_1

section .data

        bola_1:db 0x1b,"[10;10H","@",0xa
        tambola_1: equ $-bola_1

        borra: db 0x1b,"[10;10H","borra",0x1b ,"[2J",0xa
        tamborra: equ $-borra

        variable: db "",0xa
        z: equ 122
        c: equ 99
        mascara: equ 255
        mascara2: equ 63
	subebaja: db"0",0xa

section .text
        global _start

_start:

.bloque_3:	;bloque izquierda-derecha

        mov rax,[bola_1 + 6]      ;mueve a rax  el byte de  memoria almacenado en palabra1_ + 6
        and rax,mascara          ;extiende el byte de rax a los 32 para ppoder compararlo con el 57 enb ascii
        cmp rax,56               ;compara si el registro es igual a 9
        je .bloque_5            ;si es igual salta al bloque 5 que es de izquierda arriba-abajo
        jne .bloque_3.5           ;si no es igual salta al bloque 3.5, si es arriba abajo en derecha

.bloque_3.5:

	mov rax,[subebaja+1]
	and rax,mascara
	cmp rax,48	;si la bandera es igual a cero baja, si es igual a 1 sube
	je .bloque_4.2	;desplaza derecha  arriba
	jne .bloque_4.1; desplaza derecha abajo

.bloque_a:

	mov rax,48
	mov [subebaja+1],rax
	jmp .bloque_3

.bloque_b:

	mov rax,49
	mov [subebaja+1],rax
	jmp .bloque_3

.bloque_4.1:              ;desplazamientos a la derecha abajo
	
        mov rax,[bola_1 + 6]         ;mueve a la direccion que apunta rax, los bytes de palabra_1 con un corrimiento de 6$
        and rax,mascara                 ;realiza una mascara con los bits guardados en rax
        inc rax
	mov rbx,[bola_1 + 3]
	and rbx,mascara
	inc rbx
	mov [bola_1 + 3 ],rbx
	mov r8,59
	mov [bola_1 + 4],r8
	mov r8,49
	mov [bola_1 + 5],r8
        mov [bola_1 + 6],rax
        mov rax,72
        mov [bola_1 + 7],rax

        mov rax,64
        mov [bola_1 + 8],rax
        syscall
	imprime borra,tamborra,bola_1,tambola_1

        mov rax,[bola_1 + 3]
	syscall
        and rax,mascara
        cmp rax,57
        je .bloque_a  ;desplaza derecha  abajo
        jne .bloque_b; desplaza derecha arriba

	;jmp .bloque_3
	

.bloque_4.2:		;desplazamientos a la derecha arriba

	mov rax,[bola_1 + 6]         ;mueve a la direccion que apunta rax, los bytes de palabra_1 con un corrimiento de 6$
        and rax,mascara                 ;realiza una mascara con los bits guardados en rax
        inc rax
        mov rbx,[bola_1 + 3]
        and rbx,mascara
        dec rbx
        mov [bola_1 + 3 ],rbx
        mov r8,59
        mov [bola_1 + 4],r8
        mov r8,49
        mov [bola_1 + 5],r8
        mov [bola_1 + 6],rax
        mov rax,72
        mov [bola_1 + 7],rax

        mov rax,64
        mov [bola_1 + 8],rax
        syscall
        imprime borra,tamborra,bola_1,tambola_1
	
	mov rax,[bola_1 + 3]
        syscall
        and rax,mascara
        cmp rax,48
        je .bloque_a  ;desplaza  abajo
        jne .bloque_b; desplaza  arriba


        ;jmp .bloque_3

;--------------------------------------------
.bloque_5:

        mov rax,[bola_1 + 6]
        and rax,mascara
        cmp rax,48; si es igual a 
        je .bloque_3
        jne .bloque_6

.bloque_6:
	
	mov rax,[subebaja+1]
        and rax,mascara
        cmp rax,48      ;si la bandera es igual a cero baja, si es igual a 1 sube
        je .bloque_7.2  ;desplaza izquierda  arriba
        jne .bloque_7.1; desplaza izquierda  abajo

.bloque_c:
        mov rax,48
        mov [subebaja+1],rax
        jmp .bloque_5
.bloque_d:
        mov rax,49
        mov [subebaja+1],rax
        jmp .bloque_5



.bloque_7.1:              ;desplazamientos a la izquierda abajo

        mov rax,[bola_1 + 6]         ;mueve a la direccion que apunta rax, los bytes de palabra_1 con un corrimiento de 6$
        and rax,mascara                 ;realiza una mascara con los bits guardados en rax
        dec rax
        mov rbx,[bola_1 + 3]
        and rbx,mascara
        inc rbx
        mov [bola_1 + 3 ],rbx
        mov r8,59
        mov [bola_1 + 4],r8
        mov r8,49
        mov [bola_1 + 5],r8
        mov [bola_1 + 6],rax
        mov rax,72
        mov [bola_1 + 7],rax

        mov rax,64
        mov [bola_1 + 8],rax
        syscall
        imprime borra,tamborra,bola_1,tambola_1
	
	mov rax,[bola_1 + 3]
        syscall
        and rax,mascara
        cmp rax,57
        je .bloque_d  ;desplaza derecha  abajo
        jne .bloque_c; desplaza derecha arriba


        ;jmp .bloque_5

.bloque_7.2:            ;desplazamientos a la izquierda  arriba

        mov rax,[bola_1 + 6]         ;mueve a la direccion que apunta rax, los bytes de palabra_1 con un corrimiento de 6$
        and rax,mascara                 ;realiza una mascara con los bits guardados en rax
        dec rax
        mov rbx,[bola_1 + 3]
        and rbx,mascara
        dec rbx
        mov [bola_1 + 3 ],rbx
        mov r8,59
        mov [bola_1 + 4],r8
        mov r8,49
        mov [bola_1 + 5],r8
        mov [bola_1 + 6],rax
        mov rax,72
        mov [bola_1 + 7],rax

        mov rax,64
        mov [bola_1 + 8],rax
        syscall
        imprime borra,tamborra,bola_1,tambola_1

	mov rax,[bola_1 + 3]
        syscall
        and rax,mascara
        cmp rax,48
        je .bloque_d  ;desplaza derecha  abajo
        jne .bloque_c; desplaza derecha arriba

	
        ;jmp .bloque_5


;-------------------------------


.final:

        mov rax,60              ;limpia registro rax
        mov rdi,0               ;elimina valores guardados en rdi
        syscall                 ;llama al sistema


