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

        bola_1:db 0x1b,"[11;40H","@",0xa			;Aqui se asigna la posiciòn inicial de la bola
        tambola_1: equ $-bola_1					;se define el tamaño del dato que se va a imprimir en imprime

        borra: db 0x1b,"[10;10H","borra",0x1b ,"[2J",0xa	;IMprime la palabra "borra" y luego borra la pantalla
        tamborra: equ $-borra					;se define el tamaño

	variable: db "",0xa
        mascara: equ 255					;mascara de 8 bits para poder realizar las comparaciones
	subebaja: db "1",0xa					;bandera para indicarle al programa si sube o baja
	izqder: db "0",0xa

section .text
        global _start

_start:

.bloque_izqder:

	mov rax,[izqder+1]
	and rax,mascara
	cmp rax,49
	je .bloque_3
	jne .bloque_5


.bloque_3:	;bloque izquierda-derecha

        mov rax,[bola_1 + 5]      ;mueve a rax las decenas de la posiciòn horizontal
        and rax,mascara           ;extiende a los bits necesarios para comparalo  con el 57 eb ascii
        cmp rax,53                ;compara si las decenas son iguales a 5
        je .controlhorizontal              ;si es igual salta al bloque 5 que es de izquierda arriba-abajo
        jne .bloque_3.5           ;si no es igual salta al bloque 3.5, que es derecha arriba-abajo

.controlhorizontal:

	mov rax,48
	mov [izqder+1],rax
	syscall
	jmp .bloque_izqder

.bloque_3.5:

	mov rax,[subebaja+1]	;mueve a rax la bandera subebaja
	and rax,mascara		;extiende los bits para realizar la comparación
	cmp rax,48		;si la bandera es igual a cero sube, si es igual a 1 baja
	je .bloque_4.2	        ;desplaza derecha  arriba
	jne .bloque_4.1         ;desplaza derecha abajo

.bloque_A:

	mov rax,49
	mov [izqder+1],rax
	jmp .bloque_izqder

.bloque_a:

	mov rax,48		;se le asigna el valor de 0 a rax
	mov [subebaja+1],rax	;se le cambia el valor a la bandera a 0 con ayuda de rax
;	mov rax,49
;	mov [izqder+1],rax
	jmp .bloque_A		;regresa al bloque que pregunta izquierda-derecha

.bloque_b:

	mov rax,49		;se le asigna el valor de 1 a rax
	mov [subebaja+1],rax    ;se le cambia e valor a la bandera a 1 con ayuda de rax
	jmp .bloque_A		;regresa al bloque que pregunta izquierda derecha

.bloque_4.1: ;desplazamientos a la derecha abajo

	mov rax,[bola_1 + 6]     ;mueve a rax  el byte de  memoria almacenado en palabra1_ + 6
        and rax,mascara          ;completa los bits del regisstro eliminando los bit basura
        cmp rax,57               ;compara si el registro es igual a 9
        je .bloque_4.1.2         ;si es igual aumenta decenas, y pone en 0 unidades horizontales
        jne .bloque_4.1.1	 ;si no es igual simplemente incrementa unidades horizontales

.bloque_4.1.1:              ;desplazamientos a la derecha abajo unidades desplazamiento horizontal

	mov rax,[bola_1 + 3]	 ;mueve a rax, las unidades del desplazamiento vertical
	and rax,mascara		 ;completa los bits para la comparación
	cmp rax,57		 ;realiza la comparaciòn con 9, si es igual aumenta decenas
	je .bloque_4.1.1b	 ;aumentan decenas en el desplazamiento vertical
	jne .bloque_4.1.1a	 ;aumentan unidades en el desplazamiento vertical

.bloque_4.1.1a:		    ;Desplazamiento vertical con incremento de unidades

	mov r10,[bola_1 + 2]	;guarda en el registro el valor de las decenas vertical
	and r10,mascara		;elimina los bits basura del registro
	mov r9,[bola_1 + 5]	;guarda en el registro el valor de las decenas horizontal
        and r9,mascara		;elimina los bits basura del registro
        mov rax,[bola_1 + 6]    ;guarda en el registro el valor de las unidades horizontal
        and rax,mascara         ;elimina los bits basura del registro
        inc rax			;incremento en una posición el desplazamiento horizontal
	mov rbx,[bola_1 + 3]	;guarda en el registro el valor de las unidades vertical
	and rbx,mascara		;elimina los bits basura del registro
	inc rbx			;incrementa en una posición las unidades del desplazamiento vertical
	
	;reconstruyo lo almacenado en bola_1 con los desplazamientos
	mov [bola_1 + 2],r10	;asigna el viejo valor de las decenas del desplazamiento vertical
	mov [bola_1 + 3],rbx	;asigna el nuevo valor de las unidades del desplazamiento vertical
	mov r8,59		;le asigna al registro r8 el caracter ";" en ascii
	mov [bola_1 + 4],r8	;agrega el caracter a bola_1
	mov [bola_1 + 5],r9	;le asigna el viejo valor de decenas del desplazamiento horizontal
        mov [bola_1 + 6],rax	;le asigna el nuevo valor de las unidades al desplazamiento horizontal
        mov rax,72		;le asigna el registro rax el caracter  "H" en ascii
        mov [bola_1 + 7],rax	;le asigna a bola_1 el valor del registro

        mov rax,64		;muevo a rax el caracter "@"
        mov [bola_1 + 8],rax	;agrego a bola_1 el caracter "@"
        syscall			;llamado al sistema

	imprime borra,tamborra,bola_1,tambola_1	;imprimo la bola en al pantalla


;-------------------------------------------------------------------------- aqui comparo si llego a 30 el limite vertical
	mov rax,[bola_1 + 2]	;mueve a el registro las decenas del desplazamiento vertical
        and rax,mascara		;elimina bits basura
        cmp rax,51	        ;mientras las decenas del eje vertical no sean 3
        je .bloque_a            ;desplaza derecha  arriba
        jne .bloque_b           ;desplaza derecha abajo
;--------------------------------------------------------------------------------

.bloque_4.1.1b:

        mov r10,[bola_1 + 2]    ;guarda en el registro el valor de las decenas vertical
        and r10,mascara		;elimina bits basura guardados en el registro
	inc r10			;incrementa las decenas del desplazamiento vertical
        mov r9,[bola_1 + 5]	;guarda en el registro el valor de las unidades horizontal
        and r9,mascara		;elimina bits basura guardados en el registro
        mov rax,[bola_1 + 6]    ;guarda en el registro el valor de las unidades horizontal
        and rax,mascara         ;elimina bits basura guardados en el registro
        inc rax			;incrementa  las unidades del desplazamiento horizontal

	;reconstruye bola_1 con los nuevos valores
        mov [bola_1 + 2],r10	;le asigna el valor viejo  de decenas del desplazamiento vertical
	mov rbx,48		;asigna al registro rbx el valor de 0
        mov [bola_1 + 3],rbx    ;le asigna el valor de 0 a las unidades del desplazamiento vertical
        mov r8,59		;se le asigna el caracer ";"
        mov [bola_1 + 4],r8	; se agrega a bola_1 el caracter ";"
        mov [bola_1 + 5],r9	;se agregan las decenas del desplazamiento horizonta
        mov [bola_1 + 6],rax	;se agregan las unidades del desplazamiento horizontal
        mov rax,72		;se asigna el caracter "H"
        mov [bola_1 + 7],rax    ;se asigna a bola_1 el caracter "H"

        mov rax,64		;se asigna al registro el "@"
        mov [bola_1 + 8],rax	;se agrega a la posiciòn 8 de bola_1  el  "@"
        syscall

        imprime borra,tamborra,bola_1,tambola_1		;se imprime en pantalla la bola

;-------------------------------------------------------------------------- aqui comparo si llego a 30 el limite vertical
        mov rax,[bola_1 + 2]	;mueve al registro las decenas del desplazamiento vertical
        and rax,mascara		;elimina bits basura del registro
        cmp rax,51      	;mientras las decenas del eje vertical no sean 3, desplaza derecha arriba
        je .bloque_a  		;desplaza derecha  arriba
        jne .bloque_b		;desplaza derecha abajo
;--------------------------------------------------------------------------------



.bloque_4.1.2:          ;desplazamientos a la derecha abajo incremento decenas horizontal

        mov rax,[bola_1 + 3]	;mueve al registro las unidades del eje vertical
        and rax,mascara		;elimina bits basura
        cmp rax,57		;compara si incrementa unidades o decenas eje vertical
        je .bloque_4.1.2b	;incrementa decenas eje vertical
        jne .bloque_4.1.2a	;incrementa unidades eje vertical

.bloque_4.1.2a:		;incrementa las unidades del eje vertical
	
	mov r9,[bola_1 + 2]	;guarda en el registro las decenas del eje vertical
	and r9,mascara		;elimina bits basura
        mov r10,[bola_1 + 5]    ;mueve al registro las decenas del eje horizontal
        and r10,mascara         ;elimina bits basura
        inc r10			;incremento decenas eje horizontal
        mov rbx,[bola_1 + 3]	;mueve al registro las unidades del eje vetical
        and rbx,mascara		;elimina bits basura
        inc rbx			;incrementa unidades del eje vertical

	;recontruye bola_1 con los nuevos valores
	mov [bola_1 + 2],r9	;agrega decenas eje vertical
        mov [bola_1 + 3],rbx	;agrega unidades eje vertical
        mov r8,59		;mueve al registro el caracter ";"
        mov [bola_1 + 4],r8	;mueve a bola_1 el caracter de ";"
        mov [bola_1 + 5],r10	;agrega decenas eje horizontal
	mov r8, 48		;mueve al registro el valor de 0
        mov [bola_1 + 6],r8	;agrega el valor de 0 a las unidades del eje horizontal
        mov r8,72		;mueve al registro el caracter "H"
        mov [bola_1 + 7],r8	;agrega a bola_1 el caracter "H"

        mov rax,64		; mueve al registro el caracter "@"
        mov [bola_1 + 8],rax	;agrega a bola_1 el "@"
        syscall			;llamado al sistema


        imprime borra,tamborra,bola_1,tambola_1		;imprime en pantalla la bola

;-------------------------------------------------------------------------- aqui comparo si llego a 30 el limite vertical
        mov rax,[bola_1 + 2]	;mueve al registro las decenas del eje vertical
        and rax,mascara		;elimina bits basura
        cmp rax,51      	;mientras las decenas del eje vertical no sean 3
        je .bloque_a  		;desplaza derecha  arriba
        jne .bloque_b		;desplaza derecha abajo
;--------------------------------------------------------------------------------

.bloque_4.1.2b:		;incrementa las decenas del eje vertical

	mov r9,[bola_1 + 2]	;mueve al registro las decenas del eje vertical
        and r9,mascara		;elimina bits basura
	inc r9			;incrementa decenas eje vertical
        mov r10,[bola_1 + 5]    ;mueve al registro las decenas del eje horizontal
        and r10,mascara         ;elimina bits basura
        inc r10			;incrementa decenas del eje horizontal

	;recontruye los valores de bola_1
        mov [bola_1 + 2],r9	;agrega decenas eje vertical
	mov rbx,48
        mov [bola_1 + 3 ],rbx	;agrega unidades eje vertical
        mov r8,59
        mov [bola_1 + 4],r8	;agrega caracter ";"
        mov [bola_1 + 5],r10	;agrega decenas eje horizontal
        mov r8, 48
        mov [bola_1 + 6],r8	;agrega unidades eje horizontal
        mov r8,72
        mov [bola_1 + 7],r8	;agrega caracter "H"

        mov rax,64
        mov [bola_1 + 8],rax	;agrega el "@"
        syscall


        imprime borra,tamborra,bola_1,tambola_1		;imprime la bola

;-------------------------------------------------------------------------- aqui comparo si llego a 30 el limite vertical
        mov rax,[bola_1 + 2]	;mueve las decenas del eje vertical al registro
        and rax,mascara		;elimina bits basura
        cmp rax,51      	;mientas las decenas del eje vertical no sean 3
        je .bloque_a  		;desplaza derecha  arriba
        jne .bloque_b		;desplaza derecha abajo
;--------------------------------------------------------------------------------



.bloque_4.2:   ;desplazamientos a la derecha arriba

	mov rax,[bola_1 + 6]     ;Mueve a rax las unidades del desplazamiento horizontal
        and rax,mascara          ;extiende el byte de rax a los 32 para ppoder compararlo con el 57 enb ascii
        cmp rax,57               ;compara si el registro es igual a 9
        je .bloque_4.2.2         ;si es igual incrementa  decenas, y pone en 9 unidades
        jne .bloque_4.2.1        ;si no es igual simplemente incrementa  unidades


.bloque_4.2.1:		;Incrementos a las unidades desplazamiento horizontal

	mov rax,[bola_1 + 3]	;mueve al registro las unidades del eje vertical
	and rax,mascara		;elimina bits basura
	cmp rax,48	        ;compara si decrementa unidades o decenas en la vertical
	je .bloque_4.2.1b	;decrementa decenas vertical
	jne .bloque_4.2.1a	;decrementa  unidades vertical

.bloque_4.2.1a:		;decrementa unidades del eje vertical

	mov r10,[bola_1 + 2]	;mueve al registro decenas eje vertical
	and r10,mascara		;elimina bits basura
	mov r9,[bola_1 + 5]	;mueve al registro decenas eje horizontal
        and r9,mascara		;elimina bits basura
	mov rax,[bola_1 + 6]    ;mueve al registro unidades del eje horizontal
        and rax,mascara         ;elimina bits basura
        inc rax			;incrementa unidades eje horizontal
        mov rbx,[bola_1 + 3]	;mueve al registro la unidades del eje horizontal
        and rbx,mascara		;elimina bits basura
        dec rbx			;decrementa unidades del eje vertical

	;reconstruye bola_1
	mov [bola_1 + 2],r10	;agrega decenas eje vertical
        mov [bola_1 + 3],rbx	;agrega unidades eje vertical
        mov r8,59
        mov [bola_1 + 4],r8	;agrega el caracter ";"
        mov [bola_1 + 5],r9	;agrega las decenas eje horizontal
        mov [bola_1 + 6],rax	;agrega las unidades del eje horizontal
        mov rax,72
        mov [bola_1 + 7],rax	;agrega el caracter "H"

        mov rax,64
        mov [bola_1 + 8],rax	;agrega el "@"
        syscall			;llamado al sistema


        imprime borra,tamborra,bola_1,tambola_1
;----------------------------------------------------------------------------revisa si llego a la posicion 01 vertical
	mov rax,[bola_1 + 2]	;mueve al registro las decenas del eje vertical
        and rax,mascara		;elimina bits basura
        cmp rax,48		;compara con 0
        je .revisa  		;si es igual revisa si llego a 01
        jne .bloque_a		;desplaza  arriba

.revisa:
	mov rax,[bola_1 + 3]	;mueve al registro las unidades del eje vertical
	and rax,mascara		;elimina bits basura
	cmp rax,49		;compara con 1
	je .bloque_b 		;desplaza abajo
	jne .bloque_a 		;desplaza arriba

        ;jmp .bloque_3
;-----------------------------------------------------------------------

.bloque_4.2.1b:		;decrementa decenas del eje vertical

        mov r9,[bola_1 + 5]	;mueve al registro las decenas del eje horizontal
        and r9,mascara		;elimina bits basura
        mov rax,[bola_1 + 6]    ;mueve al registro las unidades del eje horizontal
        and rax,mascara         ;elimina bits basura
        inc rax			;incrementa unidades del eje horizontal
        mov r10,[bola_1 + 2]	;mueve al registro las decenas del eje vertical
        and r10,mascara		;elimina bits basura
        dec r10			;decrementa decenas del eje vertical

	;reconstruye bola_1
        mov [bola_1 + 2],r10	;agrega decenas eje vertical
	mov rbx,57
        mov [bola_1 + 3],rbx	;agrega unidades eje vertical
        mov r8,59
        mov [bola_1 + 4],r8	;agrega caracter ";"
        mov [bola_1 + 5],r9	;agrega decenas del eje horizontal
        mov [bola_1 + 6],rax	;agrega unidades del eje horizontal
        mov rax,72
        mov [bola_1 + 7],rax	;agrega caracter "H"

        mov rax,64
        mov [bola_1 + 8],rax	; agrega el caracter "@"
	syscall


        imprime borra,tamborra,bola_1,tambola_1		;imprime en pantalla la bola
;----------------------------------------------------------------------------compara si llego a la posicion 01 vertical
        mov rax,[bola_1 + 2]	;mueve al registro las decenas eje vertical
        and rax,mascara		;elimina bits basura
        cmp rax,48		;compara con 48
        je .revisa1  		;revisa si las unidades del eje vertical son igual a 1
        jne .bloque_a		;desplaza  arriba

.revisa1:
        mov rax,[bola_1 + 3]	;mueve al registro las unidades eje vertical
        and rax,mascara		;elimina bits basura
        cmp rax,49		;compara con 1
        je .bloque_b 		;desplaza abajo
        jne .bloque_a 		;desplaza arriba

        ;jmp .bloque_3
;-----------------------------------------------------------------------


.bloque_4.2.2:		;incrementa decenas del eje horizontal

	mov rax,[bola_1 + 3]	;mueve al registro las unidades del eje vertical
        and rax,mascara		;elimina bits basura
        cmp rax,48      	;compara si decrementa unidades en la vertical
        je .bloque_4.2.2b       ;decrementa decenas vertical
        jne .bloque_4.2.2a      ;decrementa  unidades vertical

.bloque_4.2.2a:		;decrementa las unidades del eje vertical

	mov r10,[bola_1 + 2]	;mueve al registro las decenas del eje vertical
	and r10,mascara		;elimina los bits basura
	mov rax,[bola_1 + 5]    ;mueve al registro las decenas del eje horizontal
        and rax,mascara         ;elimina los bits basura
        inc rax			;incrementa decenas del eje horizontal
        mov rbx,[bola_1 + 3]	;mueve al registro unidades del eje vertical
        and rbx,mascara		;elimina bits basura
        dec rbx

	;recontruye bola_1
	mov [bola_1 + 2],r10	;agrega decenas eje vertical
        mov [bola_1 + 3 ],rbx	;agrega unidades eje vertical
        mov r8,59
        mov [bola_1 + 4],r8	;agrega el caracter ";"
        mov [bola_1 + 5],rax	;agrega decenas del eje horizontal
        mov r8, 48
        mov [bola_1 + 6],r8	;agrega unidades del eje horizontal
        mov r9,72
        mov [bola_1 + 7],r9	;agrega caracter "H"

        mov rax,64
        mov [bola_1 + 8],rax	;agrega el "@"
        syscall

        imprime borra,tamborra,bola_1,tambola_1	;imprime en pantalla la bola

;----------------------------------------------------------------------------compara si llego a la posicion 01 vertical
        mov rax,[bola_1 + 2]	;mueve al registro las decenas del eje verticla 
        and rax,mascara
        cmp rax,48		;compara con 0
        je .revisa2  		;revisa si las unidades del eje vertical son igual a 1
        jne .bloque_a		; desplaza  arriba

.revisa2:
        mov rax,[bola_1 + 3]	;mueve al registro las unidades del eje vertical
        and rax,mascara
        cmp rax,49		;compara con 1
        je .bloque_b 		;desplaza abajo
        jne .bloque_a 		;desplaza arriba

        ;jmp .bloque_3
;-----------------------------------------------------------------------


.bloque_4.2.2b:		;decrementa las decenas del eje vertical

	mov rax,[bola_1 + 5]	;mueve al registro las decenas del eje horizontal
        and rax,mascara         ;elimina bits basura
        inc rax		        ;incrementa decenas del eje horizontal
        mov rbx,[bola_1 + 2]    ;mueve al registro las decenas del eje vertical
        and rbx,mascara	        ;elimina bits basura
        dec rbx		        ;decremtenta las decenas del  eje vertical

	;reconstruimos bola_1
	mov [bola_1 +2],rbx	;agregamos decenas del eje vertical
	mov r10,57
	mov [bola_1 + 3],r10	;agregamos unidades del eje vertical
        mov r8,59
        mov [bola_1 + 4],r8	;agregamos el caracter ";"
        mov [bola_1 + 5],rax	;agregamos decenas del eje horizontal
        mov r8, 48
        mov [bola_1 + 6],r8	;agregamos unidades del eje vertical
        mov r9,72
        mov [bola_1 + 7],r9	;agregamos el caracter "H"

        mov rax,64
        mov [bola_1 + 8],rax	;agregamos el "@"
        syscall

        imprime borra,tamborra,bola_1,tambola_1		;imprime en pantalla la bola

;---------------------------------------------------------------------comprueba si se llego a la posicion 01 eje vertical
        mov rax,[bola_1 + 2]	;mueve al registro las decenas del eje vertical
        and rax,mascara		;elimina bits basura
        cmp rax,48		;compara con 0
        je .revisa3  		;revisa si las unidades del eje vertical son igual a 1
        jne .bloque_a		;desplaza  arriba

.revisa3:
        mov rax,[bola_1 + 3]	;mueve al registro las unidades del eje vertical 
        and rax,mascara		;elimina bits basura
        cmp rax,49		;compara con 1
        je .bloque_b 		;desplaza abajo
        jne .bloque_a 		;desplaza arriba

        ;jmp .bloque_3
;-----------------------------------------------------------------------



;**********************************************IZQUIERDAAAA******************************************************************************************
.bloque_izqder1:

        mov rax,[izqder+1]
        and rax,mascara
        cmp rax,48
        je .bloque_5
        jne .bloque_izqder1

.bloque_5:		;mantiene el desplazamiento a la izquierda hasta la posicion 01 horizontal

        mov rax,[bola_1 + 5]	;mueve al registro las decenas del eje horizontal
        and rax,mascara		;elimina bits basura
        cmp rax,48		;compara con 0
        je .bloque_5.5		;compara si las unidades son igual a 1
        jne .bloque_6		;realiza desplazamientos a la izquierda

.bloque_5.5:		;compara si las unidades son igual a 1

	mov rax,[bola_1 + 6]	;mueve al registro las unidades del eje horizontal
	and rax,mascara		;elimina bits basura
	cmp rax,49		;comparo si llego a la posicion 1
	je .controlhorizontal1		;realiza desplazamientos a la derecha
	jne .bloque_6		;continua con desplazamientos a la izquierda

.controlhorizontal1:

	mov rax,49
        mov [izqder+1],rax
        syscall
        jmp .bloque_izqder


.bloque_6:

	mov rax,48
	mov [izqder+1],rax
	mov rax,[subebaja+1]	;mueve al registro el valor de la bandera
        and rax,mascara		;elimina bits basura
        cmp rax,48      	;si la bandera es igual a cero sube, si es igual a 1 baja
        je .bloque_7.2  	;desplaza izquierda  sube
        jne .bloque_7.1		;desplaza izquierda  baja

.bloque_C:

	mov rax,48
	mov [izqder+1],rax
	jmp .bloque_izqder

.bloque_c:

        mov rax,48		;mueve al registro el valor de 0
        mov [subebaja+1],rax	;cambia el valor de la bandera a 0 con ayuda de rax
        jmp .bloque_C			;bloque_5		;vuelve al ciclo de izquierda

.bloque_d:

        mov rax,49		;mueve al registro el valor de 1
        mov [subebaja+1],rax	;cambia el valor de la bandera a 1 con ayuda de rax
        jmp .bloque_C      ;.bloque_5		;vuelve al ciclo de izquierda

.bloque_7.1:		;desplazamiento izquierda abajo

         mov rax,[bola_1 + 6]     ;mueve al registro las unidades del eje horizontal
         and rax,mascara          ;elimina bits basura
         cmp rax,48               ;compara si el registro es igual a 0
         je .bloque_7.1.2         ;si es igual decrementa  decenas, y pone en 9 unidades
         jne .bloque_7.1.1        ;si no es igual simplemente decrementa  unidades


.bloque_7.1.1:              ;desplazamientos a la izquierda abajo

	mov rax,[bola_1 + 3]	;mueve al registro las unidades del eje horizontal
	and rax,mascara		;elimina bits basura
	cmp rax,57		;compara si el registro es igual a 0
	je .bloque_7.1.1b	;aumentan decenas en la vertical
	jne .bloque_7.1.1a	;aumentan unidades en la vertical


.bloque_7.1.1a:		   ;incremento unidades del eje vertical

	mov r10,[bola_1 + 2]	;mueve al registro decenas del eje vertical
	and r10,mascara		;elimina bits basura
	mov r9,[bola_1 + 5]	;mueve al registro decenas eje horizontal
	and r9,mascara		;elimina bits basura
        mov rax,[bola_1 + 6]    ;mueve al registro las unidades del eje horizontal
        and rax,mascara         ;elimina bits basura
        dec rax			;decrementa unidades del eje horizontal
        mov rbx,[bola_1 + 3]	;mueve al registro las unidades del eje vertical
        and rbx,mascara		;elimina bits basura
        inc rbx			;incrementa unidades del eje vertical

	;recontruye bola_1
	mov [bola_1 + 2],r10	;agregamos decenas eje vertical
        mov [bola_1 + 3 ],rbx	;agregamos unidades del eje vertical
        mov r8,59
        mov [bola_1 + 4],r8	;agregamos el caracter ";"
        mov [bola_1 + 5],r9	;agregamos decenas del eje horizontal
        mov [bola_1 + 6],rax	;agregamos unidades del eje horizontal
        mov rax,72
        mov [bola_1 + 7],rax	;agregamos el caracter "H"

        mov rax,64
        mov [bola_1 + 8],rax	;agregamos el "@"
        syscall			;llamado al sistema

        imprime borra,tamborra,bola_1,tambola_1		;imprime en pantalla la bola

;-------------------------------------------------------------------------- aqui comparo si llego a 30 el limite vertical
	mov rax,[bola_1 + 2]	;mueve al registro las decenas del eje vertical
        and rax,mascara		;elimina bits basura
        cmp rax,51		; mientas las decenas del eje vertical no sean 3
        je .bloque_c  		;desplaza derecha  arriba
        jne .bloque_d		; desplaza derecha abajo
;--------------------------------------------------------------------------------


.bloque_7.1.1b:		;incremento decenas vertical

	mov r9,[bola_1 + 5]	;mueve al registro las decenas del eje horizontal
        and r9,mascara		;elimina bits basura
        mov rax,[bola_1 + 6]    ;mueve al registro las unidades del eje horizontal
        and rax,mascara         ;elimina bits basura
        dec rax			;decrementa las unidades del eje horizontal
        mov r10,[bola_1 + 2]	;mueve al registro las decenas del eje vertical
        and r10,mascara		;elimina bits basura
        inc r10			;incrementa las decenas del eje vertical
        
	;se reconstruye bola_1
	mov [bola_1 + 2],r10	;agregamos decenas eje vertical
	mov rbx,48
	mov [bola_1 + 3 ],rbx	;agregamos unidades eje vertical
        mov r8,59
        mov [bola_1 + 4],r8	;agregamos caracter ";"
        mov [bola_1 + 5],r9	;agregamos decenas eje horizontal
        mov [bola_1 + 6],rax	;agregamos unidades eje vertical
        mov rax,72
        mov [bola_1 + 7],rax	;agregamos caracter "H"

        mov rax,64
        mov [bola_1 + 8],rax	;agregamos el "@"
        syscall
        imprime borra,tamborra,bola_1,tambola_1		;imprime la bola en la pantalla

;-------------------------------------------------------------------------- aqui comparo si llego a 30 el limite vertical
        mov rax,[bola_1 + 2]	;mueve al registro las decenas del eje vertical
        and rax,mascara		;elimina bits basura
        cmp rax,51      	; mientas las decenas del eje vertical no sean 3
        je .bloque_c  		;desplaza derecha  arriba
        jne .bloque_d		; desplaza derecha abajo
;--------------------------------------------------------------------------------


.bloque_7.1.2:		;decremento decenas horizontal

	mov rax,[bola_1 + 3]	;mueve al registro las unidades del eje vertical
        and rax,mascara		;elimina bits basura
        cmp rax,57		;compara si es igual a 9
        je .bloque_7.1.2b       ;aumentan decenas en la vertical
        jne .bloque_7.1.2a      ;aumentan unidades en la vertical

.bloque_7.1.2a:		;Incremento unidades vertical

	mov r10,[bola_1 + 2]	;mueve al registro las decenas eje vertical
	and r10,mascara		;elimina bits basura
        mov rax,[bola_1 + 5]    ;mueve al registro las decenas del eje horizontal
        and rax,mascara         ;elimina bits basura
        dec rax			;decrementa las decenas del eje horizontal
        mov rbx,[bola_1 + 3]	;mueve al registro las unidades del eje vertical
        and rbx,mascara		;elimina bits basura
        inc rbx			;incrementa las unidades del eje vertical

	;se recontruye bola_1
	mov [bola_1 + 2],r10	;agregamos decenas eje vertical
	mov [bola_1 + 3 ],rbx	;agregamos unidades eje vertical
        mov r8,59
        mov [bola_1 + 4],r8	;agregamos el caracter ";"
        mov [bola_1 + 5],rax	;agregamos decenas eje horizontal
	mov r9,57
        mov [bola_1 + 6],r9	;agregamos unidades eej horizontal
        mov rax,72
        mov [bola_1 + 7],rax	;agregamos el caracter "H"

        mov rax,64
        mov [bola_1 + 8],rax	;agregamos el "@"
        syscall
        imprime borra,tamborra,bola_1,tambola_1		;imprime la bola

;-------------------------------------------------------------------------- aqui comparo si llego a 30 el limite vertical
        mov rax,[bola_1 + 2]	;mueve al registro las decenas del eje vertical
        and rax,mascara		;elimina bits basura
        cmp rax,51      	;mientas las decenas del eje vertical no sean 3
        je .bloque_c  		;desplaza derecha  arriba
        jne .bloque_d		;desplaza derecha  abajo
;--------------------------------------------------------------------------------

	;jmp .bloque_5

.bloque_7.1.2b:		;incremento decenas vertical

	mov r10,[bola_1 + 2]	;muevo al registro las decenas del eje vertical
        and r10,mascara		;elimino bits basura
	inc r10			;incremento las decenas del eje vertical
        mov rax,[bola_1 + 5]    ;muevo al registro las decenas del eje horizontal
        and rax,mascara         ;elimino bits basura
        dec rax			;decremento decenas del eje horizontal

	;se recontruye bola_1
        mov [bola_1 + 2],r10	;agregamos decenas eje vertical
	mov rbx,48
        mov [bola_1 + 3],rbx	;agregamos unidades eje vertical
        mov r8,59
        mov [bola_1 + 4],r8	;agregamos caracter ";"
        mov [bola_1 + 5],rax	;agregamos decenas eje horizontal
        mov r9,57
        mov [bola_1 + 6],r9	;agregamos unidades eje horizontal
        mov rax,72
        mov [bola_1 + 7],rax	;agregamos el caracter "H"

        mov rax,64
        mov [bola_1 + 8],rax	;agregamos el "@"
        syscall			;llamado al sistema

        imprime borra,tamborra,bola_1,tambola_1		;imprime la bola

;-------------------------------------------------------------------------- aqui comparo si llego a 30 el limite vertical
        mov rax,[bola_1 + 2]	;mueve al registro las decenas del eje vertical
        and rax,mascara		;elimina bits basura
        cmp rax,51      	; mientas las decenas del eje vertical no sean 3
        je .bloque_c  		;desplaza derecha  arriba
        jne .bloque_d		; desplaza derecha abajo
;--------------------------------------------------------------------------------

        ;jmp .bloque_5



.bloque_7.2:		;desplazamiento izquierda sube

	 mov rax,[bola_1 + 6]     ;mueve al registro las unidades del eje horizontal
         and rax,mascara          ;elimina bits basura
         cmp rax,48               ;compara si el registro es igual a 0
         je .bloque_7.2.2         ;si es igual decrementa  decenas, y pone en 9 unidades eje horizontal
         jne .bloque_7.2.1        ;si no es igual simplemente decrementa  unidades eje horizontal


.bloque_7.2.1:            ;decrementos unidades eje horizontal

	mov rax,[bola_1 + 3]	;muevo al registro las unidades del eje vertical
	and rax,mascara		;elimino bits basura
	cmp rax,48		;compara si decrementa unidades en la vertical
	je .bloque_7.2.1b	;decrementa decenas vertical
	jne .bloque_7.2.1a	;decrementa  unidades vertical

.bloque_7.2.1a:		;Decremento unidades eje vertical

	mov r10,[bola_1 + 2]	;muevo al registro las decenas eje vertical
	and r10,mascara		;elimino bits basura
	mov r9,[bola_1 + 5]	;muevo al registro las decenas del eje horizontal
	and r9,mascara		;elimino bits basura
        mov rax,[bola_1 + 6]    ;muevo al registro las unidades del eje horizontal
        and rax,mascara         ;elimina bits basura
        dec rax			;decremento unidades eje horizontal
        mov rbx,[bola_1 + 3]	;mueve al registro las unidades del eje vertical
        and rbx,mascara		;elimina bits basura
        dec rbx			;decremento en las unidades del eje vertical

	;se reconstruye bola_1
	mov [bola_1 + 2],r10	;agregamos decenas eje vertical
        mov [bola_1 + 3 ],rbx	;agregamos unidades eje vertical
        mov r8,59
        mov [bola_1 + 4],r8	;agregamos caracter ";"
        mov [bola_1 + 5],r9	;agregamos decenas eje horizontal
        mov [bola_1 + 6],rax	;agregamos unidades eje horizontal
        mov rax,72
        mov [bola_1 + 7],rax	;agregamos caracter "H"

        mov rax,64
        mov [bola_1 + 8],rax	;agregamos el "@"
        syscall			;llamado al sistema

        imprime borra,tamborra,bola_1,tambola_1		;imprime la bola ne la pantalla

;-------------------------------------------------------------------------compara si el eje vertical llego al limite 01
	mov rax,[bola_1 + 2]	;mueve al registro las decenas del eje vertical
        and rax,mascara		;elimina bits basura
        cmp rax,48		;compara con 0
        je .revisa4 		;revisa si las unidades son igual a 1
        jne .bloque_c		; desplaza  arriba

.revisa4:
	mov rax,[bola_1 + 3]	;mueve al registro las unidades del eje vertical
	and rax,mascara		;elimina bits basura
	cmp rax,49		;compara con 1
	je .bloque_d 		;desplaza abajo
	jne .bloque_c 		;desplaza arriba

;-----------------------------------------------------------------------

        ;jmp .bloque_5

.bloque_7.2.1b:		;decremento decenas vertical

        mov r9,[bola_1 + 5]	;mueve al registro las decenas del eje horizontal
        and r9,mascara		;elimina bits basura
        mov rax,[bola_1 + 6]    ;mueve al registro las unidades del eje horizontal
        and rax,mascara         ;elimina bits basura
        dec rax			;decrementa unidades del eje horizontal
        mov r10,[bola_1 + 2]	;mueve al registro las decenas del eje vertical
        and r10,mascara		;alimina bits basura
        dec r10			;decremento de las decenas del eje vertical

	;se reconstruye bola_1
        mov [bola_1 + 2],r10	;agregamos las decenas eje vertical
	mov rbx,57
        mov [bola_1 + 3 ],rbx	;agregamos las unidades eje vertical
        mov r8,59
        mov [bola_1 + 4],r8	;agregamos el caracter ";"
        mov [bola_1 + 5],r9	;agregamos las decenas eje horizontal
        mov [bola_1 + 6],rax	;agregamos las unidades eje horizontal
        mov rax,72
        mov [bola_1 + 7],rax	;agregamos caracter  "H"

        mov rax,64
        mov [bola_1 + 8],rax	;agregamos el "@"
        syscall
        imprime borra,tamborra,bola_1,tambola_1

;-----------------------------------------------------------------------comparamos si el eje vertical llego al limite 01
        mov rax,[bola_1 + 2]	;mueve  al registro las decenas eje vertical
        and rax,mascara		;elimina bits basura
        cmp rax,48		;compara con 0
        je .revisa5  		;revisa si las unidades son igual a 1
        jne .bloque_c		;desplaza  arriba

.revisa5:
        mov rax,[bola_1 + 3]	;mueve al registro las unidades del eje vertical
        and rax,mascara		;elimina bits basura
        cmp rax,49		;comopara con 49
        je .bloque_d 		;desplaza abajo
        jne .bloque_c 		;desplaza arriba

;-----------------------------------------------------------------------


.bloque_7.2.2:            ;decrementos decenas eje horizontal

	mov rax,[bola_1 + 3]	;mueve al registro las unidades del eje vertical
        and rax,mascara		;elimina bits basura
        cmp rax,48      	;compara si decrementa unidades en la vertical
        je .bloque_7.2.2b       ;decrementa decenas vertical
        jne .bloque_7.2.2a      ;decrementa  unidades vertical

.bloque_7.2.2a:		;decremento unidades eje vertical

	mov r10,[bola_1 + 2]	;mueve al registro las decenas del eje vertical
	and r10,mascara		;elimina bits basura
        mov rax,[bola_1 + 5]    ;mueve la registro las decenas del eje horizontal
        and rax,mascara         ;elimina bits basura
        dec rax			;decremento decenas eje horizontal
        mov rbx,[bola_1 + 3]	;mueve al registro las unidades del eje vertical
        and rbx,mascara		;elimina bits basura
        dec rbx			;decremento de las unidades del eje vertical

	;se reconstruye bola_1
	mov [bola_1 +2],r10	;agregamos decenas eje vertical
        mov [bola_1 + 3 ],rbx	;agregamos unidades eje vertical
        mov r8,59
        mov [bola_1 + 4],r8	;agregamos caracter ";"
        mov [bola_1 + 5],rax	;agregamos decenas eje horizontal
	mov r8,57
        mov [bola_1 + 6],r8	;agregamos unidades eje horizontal
        mov rax,72
        mov [bola_1 + 7],rax	;agregamos caracter"H"

        mov rax,64
        mov [bola_1 + 8],rax	;agregamos el "@"
        syscall			;llamada al sistema

        imprime borra,tamborra,bola_1,tambola_1		;imprime la bola en la pantalla

;-----------------------------------------------------------------------compara si se llego al limite vertical 01
        mov rax,[bola_1 + 2]	;mueve al registro las decenas del eje vertical
        and rax,mascara		;elimina bits basura
        cmp rax,48		;compara con 0
        je .revisa6  		;revisa si las unidades del eje vertical son igual a1
        jne .bloque_c		;desplaza  arriba

.revisa6:
        mov rax,[bola_1 + 3]	;mueve al registro las unidades del eje vertical
        and rax,mascara		;elimina bits basura
        cmp rax,49		;compara con 1
        je .bloque_d 		;desplaza abajo
        jne .bloque_c 		;desplaza arriba

;-----------------------------------------------------------------------

        ;jmp .bloque_5


.bloque_7.2.2b:		;decremento decenas vertical

        mov rax,[bola_1 + 5]    ;mueve al registro las decenas del eje horizontal
        and rax,mascara         ;elimina bits basura
        dec rax			;decremento de las decenas del eje horizontal
        mov r10,[bola_1 + 2]	;mueve al registro las decenas del eje vertical
        and r10,mascara		;elimina bits basura
        dec r10			;decremento de las decenas del eje vertical

	;se reconstruye bola_1
        mov [bola_1 +2],r10	;agregamos decenas eje vertical
	mov rbx,57
        mov [bola_1 + 3 ],rbx	;agregamos unidades eje vertical
        mov r8,59
        mov [bola_1 + 4],r8	;agregamos caracter ";"
        mov [bola_1 + 5],rax	;agregamos decenas eje horizontal
        mov r8,57
        mov [bola_1 + 6],r8	;agregamos unidades eje horizontal
        mov rax,72
        mov [bola_1 + 7],rax	;agregamos caracter "H"

	mov rax,64
        mov [bola_1 + 8],rax	;agregamos el "@"
        syscall
        imprime borra,tamborra,bola_1,tambola_1		;imprime la bola en pantalla

;-------------------------------------------------------------------comapramos si el eje vetical llego al limite 01
        mov rax,[bola_1 + 2]	;mueve al registro las decenas del eje vertical
        and rax,mascara		;elimina bits basura
        cmp rax,48		;compara con 0
        je .revisa7  		;revisa si las unidades son igual a 1
        jne .bloque_c		;desplaza  arriba

.revisa7:
        mov rax,[bola_1 + 3]	;mueve al registro las unidades del eje vertical
        and rax,mascara		;elimina bits basura
        cmp rax,49		;compara con 1
        je .bloque_d 		;desplaza abajo
        jne .bloque_c 		;desplaza arriba

;-----------------------------------------------------------------------

        ;jmp .bloque_5



.final:

        mov rax,60              ;limpia registro rax
        mov rdi,0               ;elimina valores guardados en rdi
        syscall                 ;llama al sistema










