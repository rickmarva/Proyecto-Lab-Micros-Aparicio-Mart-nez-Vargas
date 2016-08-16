
section .data


	palabra_1:db 0x1b,"[10;10H","-------",0x1b,"[10;1H";barra del juego
	tampal_1: equ $-palabra_1

	borra: db 0x1b,"[10;1H","                                                ",0xa ;variable de limpieza de la pantalla al mover la barra
	tamb: equ $-borra

	variable: db"",0xa
	z: equ 122
	c: equ 99
	mascara: equ 255
	nueve: equ 57
	cero: equ 48
	uno: equ 50
	cuatro: equ 52

section .text
	global _start

_start:

.bloque_1:

	mov rax,1   ;imprime los espacios  para borrar la barra
	mov rdi,1
	mov rsi,borra
	mov rdx,tamb
	syscall

	mov rax,1 ;imprime la barra
	mov rdi,1
	mov rsi,palabra_1
	mov rdx,tampal_1
	syscall

.bloque_2:

	mov rax,0 ;captura la letra presionada
	mov rdi,0
	mov rsi,variable
	mov rdx,1
	syscall


.bloque_3:

	mov rax,[variable] ;compara la letra presionada con c
	and rax,mascara
	cmp rax,c
	je .bloque_pregunta_limited
	jne .bloque_5


.bloque_pregunta_limited:


	mov r9,[palabra_1 + 5] ;bloque que analiza el limite derecho de la pantalla en las decenas para no exceder la barra, osea 4
	and r9,mascara
	cmp r9,cuatro
	je .bloque_pregunta_limiteu
	jne .bloque_pregunta

.bloque_pregunta_limiteu:

	mov r9,[palabra_1 + 6];bloque que analiza el limite derecho de la pantalla en las unidades para no exceder la barra, osea 9
	and r9,mascara
	cmp r9,nueve
	je .bloque_1 ;si esta en el limite pinta la barra en la misma posición porque no se va a mover
	jne .bloque_pregunta

.bloque_pregunta:

	mov r9,[palabra_1 + 6] ;analiza si la posición de la barra se encuentra en 9 en las unidades, para intercambiarlo por 0
	and r9,mascara
	cmp r9,nueve
	je .bloque_cambio
	jne .bloque_4


.bloque_cambio:

	mov rax,[palabra_1 + 5] ;intercambia la posicion de la barra de 9 en las unidades por 0 para iniciar una nueva cuenta
        and rax,mascara
        add rax,1
        mov [palabra_1 + 5],rax


	mov r9,cero
	and r9,mascara
	mov [palabra_1 + 6],r9

	mov rax,72 ;imprime el resto de la barra
        mov [palabra_1 + 7],rax

        mov rax,45
        mov [palabra_1 + 8],rax
        mov rax,45
        mov [palabra_1 + 9],rax
        mov rax,45
        mov [palabra_1 + 10],rax
        mov rax,45
        mov [palabra_1 + 11],rax
        mov rax,45
        mov [palabra_1 + 12],rax
        mov rax,45
        mov [palabra_1 + 13],rax
        mov rax,45
        mov [palabra_1 + 14],rax



	jmp .bloque_1


.bloque_4:

	mov r9,[palabra_1 + 6] ;sino se presentó ninguno de los bloques anteriores, suma 1 a las unidades en la posicion de la barra para moverla
	and r9,mascara
	add r9,1
	mov [palabra_1 + 6],r9

	mov rax,72
	mov [palabra_1 + 7],rax

	mov rax,45
	mov [palabra_1 + 8],rax
        mov rax,45
        mov [palabra_1 + 9],rax
        mov rax,45
        mov [palabra_1 + 10],rax
        mov rax,45
        mov [palabra_1 + 11],rax
        mov rax,45
        mov [palabra_1 + 12],rax
        mov rax,45
        mov [palabra_1 + 13],rax
        mov rax,45
        mov [palabra_1 + 14],rax


	jmp .bloque_1

.bloque_5: ;compara la letra presionada con z

	mov rax,[variable]
        and rax,mascara
	cmp rax,z
	je .bloque_pregunta_limited2
	jne .bloque_1

.bloque_pregunta_limited2: ;compara decenas de la posición de la barra para el limite izquierdo de la pantalla

        mov r9,[palabra_1 + 5]
        and r9,mascara
        cmp r9,cero
        je .bloque_pregunta_limiteu2
        jne .bloque_pregunta2

.bloque_pregunta_limiteu2: ;compara unidades de la posición de la barra para el limite izquierdo de la pantalla

        mov r9,[palabra_1 + 6]
        and r9,mascara
        cmp r9,uno
        je .bloque_1
        jne .bloque_pregunta2


.bloque_pregunta2: ;analiza si las unidades se encuentran en 0 ya que al restar posición se debe volver 9

	mov r9,[palabra_1 + 6]
        and r9,mascara
        cmp r9,cero
        je .bloque_cambio2
        jne .bloque_6
 

.bloque_cambio2: ;intercambia 0 por 9 en las unidades y le resta 1 a las decenas para continuar la cuenta

	mov rax,[palabra_1 + 5]
	and rax,mascara
	sub rax,1
	mov [palabra_1 + 5],rax

	mov r9,nueve
	and r9,mascara
	mov [palabra_1 + 6],r9

      	mov rax,72
        mov [palabra_1 + 7],rax

        mov rax,45
        mov [palabra_1 + 8],rax
        mov rax,45
        mov [palabra_1 + 9],rax
        mov rax,45
        mov [palabra_1 + 10],rax
        mov rax,45
        mov [palabra_1 + 11],rax
        mov rax,45
        mov [palabra_1 + 12],rax
        mov rax,45
        mov [palabra_1 + 13],rax
        mov rax,45
        mov [palabra_1 + 14],rax

	jmp .bloque_1



.bloque_6: ;le resta 1 a las unidades de la posición de la barra para moverla

	mov r9,[palabra_1 + 6]
	and r9,mascara
	sub r9,1
        mov [palabra_1 + 6],r9
        mov rax,72
        mov [palabra_1 + 7],rax

	mov rax,45
        mov [palabra_1 + 8],rax
        mov rax,45
        mov [palabra_1 + 9],rax
        mov rax,45
        mov [palabra_1 + 10],rax
        mov rax,45
        mov [palabra_1 + 11],rax
        mov rax,45
        mov [palabra_1 + 12],rax
        mov rax,45
        mov [palabra_1 + 13],rax
        mov rax,45
        mov [palabra_1 + 14],rax



	jmp .bloque_1


.final:

	mov rax,60
	mov rdi,0
	syscall

