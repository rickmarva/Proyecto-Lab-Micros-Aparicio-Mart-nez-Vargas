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

	entro:db 0x1b,"[10;10H","unidades",0xa
	tamentro:equ $-entro

	entro1:db 0x1b,"[10;10H","decenas",0xa
        tamentro1:equ $-entro

        bola_1:db 0x1b,"[01;50H","@",0xa
        tambola_1: equ $-bola_1

        borra: db 0x1b,"[10;10H","borra",0x1b ,"[2J",0xa
        tamborra: equ $-borra

        variable: db "",0xa
        z: equ 122
        c: equ 99
        mascara: equ 255
        mascara2: equ 63
	subebaja: db "0",0xa

section .text
        global _start

_start:

.bloque_3:	;bloque izquierda-derecha

        mov rax,[bola_1 + 5]      ;mueve a rax  el byte de  memoria almacenado en palabra1_ + 6
        and rax,mascara          ;extiende el byte de rax a los 32 para ppoder compararlo con el 57 enb ascii
        cmp rax,53               ;compara si el registro es igual a 9
        je .bloque_5            ;si es igual salta al bloque 5 que es de izquierda arriba-abajo
        jne .bloque_3.5           ;si no es igual salta al bloque 3.5, si es arriba abajo en derecha

.bloque_3.5:

	mov rax,[subebaja+1]
	and rax,mascara
	cmp rax,48	;si la bandera es igual a cero sube, si es igual a 1 baja
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

.bloque_4.1: ;desplazamientos a la derecha abajo

	mov rax,[bola_1 + 6]      ;mueve a rax  el byte de  memoria almacenado en palabra1_ + 6
        and rax,mascara          ;extiende el byte de rax a los 32 para ppoder compararlo con el 57 enb ascii
        cmp rax,57               ;compara si el registro es igual a 9
        je .bloque_4.1.2         ;si es igual aumenta decenas, y pone en 0 unidades horizontales
        jne .bloque_4.1.1	 ;si no es igual simplemente incrementa unidades horizontales

.bloque_4.1.1:              ;desplazamientos a la derecha abajo unidades,aqui compara si aumentan decenas en la vertical

	mov rax,[bola_1 + 3]
	and rax,mascara
	cmp rax,57
	je .bloque_4.1.1b	;aumentan decenas en la vertical
	jne .bloque_4.1.1a	 ;no aumentan decenas en la vertical

.bloque_4.1.1a:

	mov r10,[bola_1 + 2]
	and r10,mascara
	mov r9,[bola_1 + 5]
        and r9,mascara
        mov rax,[bola_1 + 6]         ;mueve a la direccion que apunta rax, los bytes de palabra_1 con un corrimiento de 6$
        and rax,mascara                 ;realiza una mascara con los bits guardados en rax
        inc rax
	mov rbx,[bola_1 + 3]
	and rbx,mascara
	inc rbx
	
	mov [bola_1 + 2],r10
	mov [bola_1 + 3],rbx
	mov r8,59
	mov [bola_1 + 4],r8
	mov [bola_1 + 5],r9
        mov [bola_1 + 6],rax
        mov rax,72
        mov [bola_1 + 7],rax

        mov rax,64
        mov [bola_1 + 8],rax
        syscall

	imprime borra,tamborra,bola_1,tambola_1


;-------------------------------------------------------------------------- aqui comparo si llego a 30 el limite vertical
	mov rax,[bola_1 + 2]
        and rax,mascara
        cmp rax,51	; mientas las decenas del eje vertical no sean 3
        je .bloque_a  ;desplaza derecha  abajo
        jne .bloque_b; desplaza derecha arriba
;--------------------------------------------------------------------------------

.bloque_4.1.1b:

        mov r10,[bola_1 + 2]
        and r10,mascara
	inc r10
        mov r9,[bola_1 + 5]
        and r9,mascara
        mov rax,[bola_1 + 6]         ;mueve a la direccion que apunta rax, los bytes de palabra_1 con un corrimiento de 6$
        and rax,mascara                 ;realiza una mascara con los bits guardados en rax
        inc rax

        mov [bola_1 + 2],r10
	mov rbx,48
        mov [bola_1 + 3],rbx
        mov r8,59
        mov [bola_1 + 4],r8
        mov [bola_1 + 5],r9
        mov [bola_1 + 6],rax
        mov rax,72
        mov [bola_1 + 7],rax

        mov rax,64
        mov [bola_1 + 8],rax
        syscall

        imprime borra,tamborra,bola_1,tambola_1

;-------------------------------------------------------------------------- aqui comparo si llego a 30 el limite vertical
        mov rax,[bola_1 + 2]
        and rax,mascara
        cmp rax,51      ; mientas las decenas del eje vertical no sean 3
        je .bloque_a  ;desplaza derecha  abajo
        jne .bloque_b; desplaza derecha arriba
;--------------------------------------------------------------------------------



.bloque_4.1.2:              ;desplazamientos a la derecha abajo incremento decenas horizontal

        mov rax,[bola_1 + 3]
        and rax,mascara
        cmp rax,57
        je .bloque_4.1.2b
        jne .bloque_4.1.2a

.bloque_4.1.2a:
	
	mov r9,[bola_1 + 2]
	and r9,mascara
        mov r10,[bola_1 + 5]         ;mueve a la direccion que apunta rax, los bytes de palabra_1 con un corrimiento de 6$
        and r10,mascara                 ;realiza una mascara con los bits guardados en rax
        inc r10
        mov rbx,[bola_1 + 3]
        and rbx,mascara
        inc rbx

	mov [bola_1 + 2],r9
        mov [bola_1 + 3 ],rbx
        mov r8,59
        mov [bola_1 + 4],r8
        mov [bola_1 + 5],r10
	mov r8, 48
        mov [bola_1 + 6],r8
        mov r8,72
        mov [bola_1 + 7],r8

        mov rax,64
        mov [bola_1 + 8],rax
        syscall


        imprime borra,tamborra,bola_1,tambola_1

;-------------------------------------------------------------------------- aqui comparo si llego a 30 el limite vertical
        mov rax,[bola_1 + 2]
        and rax,mascara
        cmp rax,51      ; mientas las decenas del eje vertical no sean 3
        je .bloque_a  ;desplaza derecha  abajo
        jne .bloque_b; desplaza derecha arriba
;--------------------------------------------------------------------------------

.bloque_4.1.2b:

	mov r9,[bola_1 + 2]
        and r9,mascara
	inc r9
        mov r10,[bola_1 + 5]         ;mueve a la direccion que apunta rax, los bytes de palabra_1 con un corrimiento de 6$
        and r10,mascara                 ;realiza una mascara con los bits guardados en rax
        inc r10

        mov [bola_1 + 2],r9
	mov rbx,48
        mov [bola_1 + 3 ],rbx
        mov r8,59
        mov [bola_1 + 4],r8
        mov [bola_1 + 5],r10
        mov r8, 48
        mov [bola_1 + 6],r8
        mov r8,72
        mov [bola_1 + 7],r8

        mov rax,64
        mov [bola_1 + 8],rax
        syscall


        imprime borra,tamborra,bola_1,tambola_1

;-------------------------------------------------------------------------- aqui comparo si llego a 30 el limite vertical
        mov rax,[bola_1 + 2]
        and rax,mascara
        cmp rax,51      ; mientas las decenas del eje vertical no sean 3
        je .bloque_a  ;desplaza derecha  abajo
        jne .bloque_b; desplaza derecha arriba
;--------------------------------------------------------------------------------



.bloque_4.2:   ;desplazamientos a la derecha arriba

	mov rax,[bola_1 + 6]      ;mueve a rax  el byte de  memoria almacenado en palabra1_ + 6
        and rax,mascara          ;extiende el byte de rax a los 32 para ppoder compararlo con el 57 enb ascii
        cmp rax,57               ;compara si el registro es igual a 9
        je .bloque_4.2.2         ;si es igual incrementa  decenas, y pone en 9 unidades
        jne .bloque_4.2.1        ;si no es igual simplemente incrementa  unidades


.bloque_4.2.1:

	mov rax,[bola_1 + 3]
	and rax,mascara
	cmp rax,48	;compara si decrementa unidades en la vertical
	je .bloque_4.2.1b	;decrementa decenas vertical
	jne .bloque_4.2.1a	;decrementa  unidades vertical

.bloque_4.2.1a:

	mov r10,[bola_1 + 2]
	and r10,mascara
	mov r9,[bola_1 + 5]
        and r9,mascara
	mov rax,[bola_1 + 6]         ;mueve a la direccion que apunta rax, los bytes de palabra_1 con un corrimiento de 6$
        and rax,mascara                 ;realiza una mascara con los bits guardados en rax
        inc rax
        mov rbx,[bola_1 + 3]
        and rbx,mascara
        dec rbx

	mov [bola_1 + 2],r10
        mov [bola_1 + 3],rbx
        mov r8,59
        mov [bola_1 + 4],r8
        mov [bola_1 + 5],r9
        mov [bola_1 + 6],rax
        mov rax,72
        mov [bola_1 + 7],rax

        mov rax,64
        mov [bola_1 + 8],rax
        syscall


        imprime borra,tamborra,bola_1,tambola_1
;----------------------------------------------------------------------------
	mov rax,[bola_1 + 2]
        and rax,mascara
        cmp rax,48
        je .revisa  ;desplaza  abajo
        jne .bloque_a; desplaza  arriba

.revisa:
	mov rax,[bola_1 + 3]
	and rax,mascara
	cmp rax,49
	je .bloque_b ;desplaza abajo
	jne .bloque_a ;desplaza arriba

        ;jmp .bloque_3
;-----------------------------------------------------------------------

.bloque_4.2.1b:

        mov r9,[bola_1 + 5]
        and r9,mascara
        mov rax,[bola_1 + 6]         ;mueve a la direccion que apunta rax, los bytes de palabra_1 con un corrimiento de 6$
        and rax,mascara                 ;realiza una mascara con los bits guardados en rax
        inc rax
        mov r10,[bola_1 + 2]
        and r10,mascara
        dec r10

        mov [bola_1 + 2],r10
	mov rbx,57
        mov [bola_1 + 3],rbx
        mov r8,59
        mov [bola_1 + 4],r8
        mov [bola_1 + 5],r9
        mov [bola_1 + 6],rax
        mov rax,72
        mov [bola_1 + 7],rax

        mov rax,64
        mov [bola_1 + 8],rax
	syscall


        imprime borra,tamborra,bola_1,tambola_1
;----------------------------------------------------------------------------
        mov rax,[bola_1 + 2]
        and rax,mascara
        cmp rax,48
        je .revisa1  ;desplaza  abajo
        jne .bloque_a; desplaza  arriba

.revisa1:
        mov rax,[bola_1 + 3]
        and rax,mascara
        cmp rax,49
        je .bloque_b ;desplaza abajo
        jne .bloque_a ;desplaza arriba

        ;jmp .bloque_3
;-----------------------------------------------------------------------


.bloque_4.2.2:

	mov rax,[bola_1 + 3]
        and rax,mascara
        cmp rax,48      ;compara si decrementa unidades en la vertical
        je .bloque_4.2.2b       ;decrementa decenas vertical
        jne .bloque_4.2.2a      ;decrementa  unidades vertical

.bloque_4.2.2a:

	mov r10,[bola_1 + 2]
	and r10,mascara
	mov rax,[bola_1 + 5]         ;mueve a la direccion que apunta rax, los bytes de palabra_1 con un corrimiento de 6$
        and rax,mascara                 ;realiza una mascara con los bits guardados en rax
        inc rax
        mov rbx,[bola_1 + 3]
        and rbx,mascara
        dec rbx

	mov [bola_1 + 2],r10
        mov [bola_1 + 3 ],rbx
        mov r8,59
        mov [bola_1 + 4],r8
        mov [bola_1 + 5],rax
        mov r8, 48
        mov [bola_1 + 6],r8
        mov r9,72
        mov [bola_1 + 7],r9

        mov rax,64
        mov [bola_1 + 8],rax
        syscall

        imprime borra,tamborra,bola_1,tambola_1

;----------------------------------------------------------------------------
        mov rax,[bola_1 + 2]
        and rax,mascara
        cmp rax,48
        je .revisa2  ;desplaza  abajo
        jne .bloque_a; desplaza  arriba

.revisa2:
        mov rax,[bola_1 + 3]
        and rax,mascara
        cmp rax,49
        je .bloque_b ;desplaza abajo
        jne .bloque_a ;desplaza arriba

        ;jmp .bloque_3
;-----------------------------------------------------------------------


.bloque_4.2.2b:

	mov rax,[bola_1 + 5]         ;mueve a la direccion que apunta rax, los bytes de palabra_1 con un corrimiento de 6$
        and rax,mascara                 ;realiza una mascara con los bits guardados en rax
        inc rax
        mov rbx,[bola_1 + 2]
        and rbx,mascara
        dec rbx

	mov [bola_1 +2],rbx
	mov r10,57
	mov [bola_1 + 3],r10
        mov r8,59
        mov [bola_1 + 4],r8
        mov [bola_1 + 5],rax
        mov r8, 48
        mov [bola_1 + 6],r8
        mov r9,72
        mov [bola_1 + 7],r9

        mov rax,64
        mov [bola_1 + 8],rax
        syscall

        imprime borra,tamborra,bola_1,tambola_1

;----------------------------------------------------------------------------
        mov rax,[bola_1 + 2]
        and rax,mascara
        cmp rax,48
        je .revisa3  ;desplaza  abajo
        jne .bloque_a; desplaza  arriba

.revisa3:
        mov rax,[bola_1 + 3]
        and rax,mascara
        cmp rax,49
        je .bloque_b ;desplaza abajo
        jne .bloque_a ;desplaza arriba

        ;jmp .bloque_3
;-----------------------------------------------------------------------



;**********************************************IZQUIERDAAAA******************************************************************************************
.bloque_5:

        mov rax,[bola_1 + 5]
        and rax,mascara
        cmp rax,48; si es igual a 0 
        je .bloque_5.5
        jne .bloque_6

.bloque_5.5:

	mov rax,[bola_1 + 6]
	and rax,mascara
	cmp rax,49	;comparo si llego a la posicion 1
	je .bloque_3
	jne .bloque_6
.bloque_6:

	mov rax,[subebaja+1]
        and rax,mascara
        cmp rax,48      ;si la bandera es igual a cero baja, si es igual a 1 sube
        je .bloque_7.2  ;desplaza izquierda  sube
        jne .bloque_7.1; desplaza izquierda  baja

.bloque_c:
        mov rax,48
        mov [subebaja+1],rax
        jmp .bloque_5
.bloque_d:
        mov rax,49
        mov [subebaja+1],rax
        jmp .bloque_5

.bloque_7.1:

         mov rax,[bola_1 + 6]      ;mueve a rax  el byte de  memoria almacenado en palabra1_ + 6
         and rax,mascara          ;extiende el byte de rax a los 32 para ppoder compararlo con el 57 en ascii
         cmp rax,48               ;compara si el registro es igual a 0
         je .bloque_7.1.2         ;si es igual decrementa  decenas, y pone en 9 unidades
         jne .bloque_7.1.1        ;si no es igual simplemente decrementa  unidades


.bloque_7.1.1:              ;desplazamientos a la izquierda abajo

	mov rax,[bola_1 + 3]
	and rax,mascara
	cmp rax,57
	je .bloque_7.1.1b	;aumentan decenas en la vertical
	jne .bloque_7.1.1a	 ;no aumentan decenas en la vertical


.bloque_7.1.1a:

	mov r10,[bola_1 + 2]
	and r10,mascara
	mov r9,[bola_1 + 5]
	and r9,mascara
        mov rax,[bola_1 + 6]         ;mueve a la direccion que apunta rax, los bytes de palabra_1 con un corrimiento de 6$
        and rax,mascara                 ;realiza una mascara con los bits guardados en rax
        dec rax
        mov rbx,[bola_1 + 3]
        and rbx,mascara
        inc rbx

	mov [bola_1 + 2],r10
        mov [bola_1 + 3 ],rbx
        mov r8,59
        mov [bola_1 + 4],r8
        mov [bola_1 + 5],r9
        mov [bola_1 + 6],rax
        mov rax,72
        mov [bola_1 + 7],rax

        mov rax,64
        mov [bola_1 + 8],rax
        syscall
        imprime borra,tamborra,bola_1,tambola_1

;-------------------------------------------------------------------------- aqui comparo si llego a 30 el limite vertical
	mov rax,[bola_1 + 2]
        and rax,mascara
        cmp rax,51	; mientas las decenas del eje vertical no sean 3
        je .bloque_c  ;desplaza derecha  abajo
        jne .bloque_d; desplaza derecha arriba
;--------------------------------------------------------------------------------


.bloque_7.1.1b:

	mov r9,[bola_1 + 5]
        and r9,mascara
        mov rax,[bola_1 + 6]         ;mueve a la direccion que apunta rax, los bytes de palabra_1 con un corrimiento de 6$
        and rax,mascara                 ;realiza una mascara con los bits guardados en rax
        dec rax
        mov r10,[bola_1 + 2]
        and r10,mascara
        inc r10
        
	mov [bola_1 + 2],r10
	mov rbx,48
	mov [bola_1 + 3 ],rbx
        mov r8,59
        mov [bola_1 + 4],r8
        mov [bola_1 + 5],r9
        mov [bola_1 + 6],rax
        mov rax,72
        mov [bola_1 + 7],rax

        mov rax,64
        mov [bola_1 + 8],rax
        syscall
        imprime borra,tamborra,bola_1,tambola_1

;-------------------------------------------------------------------------- aqui comparo si llego a 30 el limite vertical
        mov rax,[bola_1 + 2]
        and rax,mascara
        cmp rax,51      ; mientas las decenas del eje vertical no sean 3
        je .bloque_c  ;desplaza derecha  abajo
        jne .bloque_d; desplaza derecha arriba
;--------------------------------------------------------------------------------


.bloque_7.1.2:

	mov rax,[bola_1 + 3]
        and rax,mascara
        cmp rax,57
        je .bloque_7.1.2b       ;aumentan decenas en la vertical
        jne .bloque_7.1.2a       ;no aumentan decenas en la vertical

.bloque_7.1.2a:

	mov r10,[bola_1 + 2]
	and r10,mascara
        mov rax,[bola_1 + 5]         ;mueve a la direccion que apunta rax, los bytes de palabra_1 con un corrimiento de 6$
        and rax,mascara                 ;realiza una mascara con los bits guardados en rax
        dec rax
        mov rbx,[bola_1 + 3]
        and rbx,mascara
        inc rbx

	mov [bola_1 + 2],r10
	mov [bola_1 + 3 ],rbx
        mov r8,59
        mov [bola_1 + 4],r8
        mov [bola_1 + 5],rax
	mov r9,57
        mov [bola_1 + 6],r9
        mov rax,72
        mov [bola_1 + 7],rax

        mov rax,64
        mov [bola_1 + 8],rax
        syscall
        imprime borra,tamborra,bola_1,tambola_1

;-------------------------------------------------------------------------- aqui comparo si llego a 30 el limite vertical
        mov rax,[bola_1 + 2]
        and rax,mascara
        cmp rax,51      ; mientas las decenas del eje vertical no sean 3
        je .bloque_c  ;desplaza derecha  abajo
        jne .bloque_d; desplaza derecha arriba
;--------------------------------------------------------------------------------

	jmp .bloque_5

.bloque_7.1.2b:

	mov r10,[bola_1 + 2]
        and r10,mascara
	inc r10
        mov rax,[bola_1 + 5]         ;mueve a la direccion que apunta rax, los bytes de palabra_1 con un corrimiento de 6$
        and rax,mascara                 ;realiza una mascara con los bits guardados en rax
        dec rax

        mov [bola_1 + 2],r10
	mov rbx,48
        mov [bola_1 + 3],rbx
        mov r8,59
        mov [bola_1 + 4],r8
        mov [bola_1 + 5],rax
        mov r9,57
        mov [bola_1 + 6],r9
        mov rax,72
        mov [bola_1 + 7],rax

        mov rax,64
        mov [bola_1 + 8],rax
        syscall
        imprime borra,tamborra,bola_1,tambola_1

;-------------------------------------------------------------------------- aqui comparo si llego a 30 el limite vertical
        mov rax,[bola_1 + 2]
        and rax,mascara
        cmp rax,51      ; mientas las decenas del eje vertical no sean 3
        je .bloque_c  ;desplaza derecha  abajo
        jne .bloque_d; desplaza derecha arriba
;--------------------------------------------------------------------------------

        jmp .bloque_5



.bloque_7.2:

	 mov rax,[bola_1 + 6]      ;mueve a rax  el byte de  memoria almacenado en palabra1_ + 6
         and rax,mascara          ;extiende el byte de rax a los 32 para ppoder compararlo con el 57 enb ascii
         cmp rax,48               ;compara si el registro es igual a 0
         je .bloque_7.2.2         ;si es igual decrementa  decenas, y pone en 9 unidades
         jne .bloque_7.2.1        ;si no es igual simplemente decrementa  unidades


.bloque_7.2.1:            ;desplazamientos a la izquierda  arriba

	mov r9,[bola_1 + 5]
	and r9,mascara
        mov rax,[bola_1 + 6]         ;mueve a la direccion que apunta rax, los bytes de palabra_1 con un corrimiento de 6$
        and rax,mascara                 ;realiza una mascara con los bits guardados en rax
        dec rax
        mov rbx,[bola_1 + 3]
        and rbx,mascara
        dec rbx
        mov [bola_1 + 3 ],rbx
        mov r8,59
        mov [bola_1 + 4],r8
        mov [bola_1 + 5],r9
        mov [bola_1 + 6],rax
        mov rax,72
        mov [bola_1 + 7],rax

        mov rax,64
        mov [bola_1 + 8],rax
        syscall
        imprime borra,tamborra,bola_1,tambola_1

	mov rax,[bola_1 + 3]
        and rax,mascara
        cmp rax,48
        je .bloque_d  ;desplaza derecha  abajo
        jne .bloque_c; desplaza derecha arriba


        ;jmp .bloque_5


.bloque_7.2.2:            ;desplazamientos a la izquierda  arriba

        mov rax,[bola_1 + 5]         ;mueve a la direccion que apunta rax, los bytes de palabra_1 con un corrimiento de 6$
        and rax,mascara                 ;realiza una mascara con los bits guardados en rax
        dec rax
        mov rbx,[bola_1 + 3]
        and rbx,mascara
        dec rbx
        mov [bola_1 + 3 ],rbx
        mov r8,59
        mov [bola_1 + 4],r8
        mov [bola_1 + 5],rax
	mov r8,57
        mov [bola_1 + 6],r8
        mov rax,72
        mov [bola_1 + 7],rax

        mov rax,64
        mov [bola_1 + 8],rax
        syscall
        imprime borra,tamborra,bola_1,tambola_1

	mov rax,[bola_1 + 3]
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








