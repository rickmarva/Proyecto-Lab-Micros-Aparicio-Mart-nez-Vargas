section .data


	palabra_1:db 0x1b,"[10;10H","[-----]",0xa
	tampal_1: equ $-palabra_1

	borra: db 0x1b,"[10;10H]","borra",0x1b ,"[2K",0xa
	tamborra: equ $-borra
	linea: db 0x1b,"[20;50H","|",0xa
	tamlinea: equ $-linea

	linea2: db 0x1b,"[20;1H","|",0xa
	tamlinea2: equ $-linea2

        linea3: db 0x1b,"[21;1H","|",0xa
        tamlinea3: equ $-linea3

        linea4: db 0x1b,"[21;50H","|",0xa
        tamlinea4: equ $-linea4

	
	variable: db"",0xa
	z: equ 122
	c: equ 99
	mascara: equ 255
	nueve: equ 51
	cero: equ 48
	uno: equ 50
	cuatro: equ 52

section .text
	global _start

_start:

.bloque_1:

	mov rax,1
	mov rdi,1
	mov rsi,borra
	mov rdx,tamborra
	syscall
	mov rax,1
	mov rdi,1
	mov rsi,linea
	mov rdx,tamlinea
	syscall

        mov rax,1
        mov rdi,1
        mov rsi,linea2
        mov rdx,tamlinea2
        syscall

        mov rax,1
        mov rdi,1
        mov rsi,linea3
        mov rdx,tamlinea3
        syscall

        mov rax,1
        mov rdi,1
        mov rsi,linea4
        mov rdx,tamlinea4
        syscall

	mov rax,1
	mov rdi,1
	mov rsi,palabra_1
	mov rdx,tampal_1
	syscall
	
.bloque_2:

	mov rax,0
	mov rdi,0
	mov rsi,variable
	mov rdx,1
	syscall


.bloque_3:

	mov rax,[variable]
	and rax,mascara
	cmp rax,c
	je .bloque_pregunta_limited
	jne .bloque_5

.bloque_pregunta_limited:

	mov r9,[palabra_1 + 5]
	and r9,mascara
	cmp r9,cuatro
	je .bloque_pregunta_limiteu
	jne .bloque_pregunta

.bloque_pregunta_limiteu:

	mov r9,[palabra_1 + 6]
	and r9,mascara
	cmp r9,nueve
	je .bloque_1
	jne .bloque_pregunta

.bloque_pregunta:

	mov r9,[palabra_1 + 6]
	and r9,mascara
	cmp r9,nueve
	je .bloque_cambio
	jne .bloque_4


.bloque_cambio:

	mov r9,[palabra_1 + 5]
        and r9,mascara
        add r9,1
        mov [palabra_1 + 5],r9

	mov rax,cero
	and rax,mascara
	mov [palabra_1 + 6],rax

	mov rax,72
        mov [palabra_1 + 7],rax

        mov rax,91
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
        mov rax,93
        mov [palabra_1 + 14],rax



	jmp .bloque_1


.bloque_4:

	mov r9,[palabra_1 + 6]
	and r9,mascara
	add r9,1
	mov [palabra_1 + 6],r9
	mov rax,72
	mov [palabra_1 + 7],rax

	mov rax,91
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
        mov rax,93
        mov [palabra_1 + 14],rax


	jmp .bloque_1

.bloque_5:

	mov rax,[variable]
        and rax,mascara
	cmp rax,z
	je .bloque_pregunta_limited2
	jne .bloque_1

.bloque_pregunta_limited2:

        mov r9,[palabra_1 + 5]
        and r9,mascara
        cmp r9,cero
        je .bloque_pregunta_limiteu2
        jne .bloque_pregunta2

.bloque_pregunta_limiteu2:

        mov r9,[palabra_1 + 6]
        and r9,mascara
        cmp r9,uno
        je .bloque_1
        jne .bloque_pregunta2


.bloque_pregunta2:

	mov r9,[palabra_1 + 6]
        and r9,mascara
        cmp r9,cero
        je .bloque_cambio2
        jne .bloque_6
 

.bloque_cambio2:

	mov rax,[palabra_1 + 5]
	and rax,mascara
	sub rax,1
	mov [palabra_1 + 5],rax

	mov r9,nueve
	and r9,mascara
	mov [palabra_1 + 6],r9

      	mov rax,72
        mov [palabra_1 + 7],rax

        mov rax,91
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
        mov rax,93
        mov [palabra_1 + 14],rax

	jmp .bloque_1



.bloque_6:

	mov r9,[palabra_1 + 6]
	and r9,mascara
	sub r9,1
        mov [palabra_1 + 6],r9
        mov rax,72
        mov [palabra_1 + 7],rax

	mov rax,91
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
        mov rax,93
        mov [palabra_1 + 14],rax



	jmp .bloque_1


.final:

	mov rax,60
	mov rdi,0
	syscall