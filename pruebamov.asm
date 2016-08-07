section .data


	palabra_1:db 0x1b,"[10;10H","[-----]",0xa
	tampal_1: equ $-palabra_1

	borra: db 0x1b,"[10;10H]","borra",0x1b ,"[2J]",0xa
	tamborra: equ $-borra

	variable: db"",0xa
	z: equ 122
	c: equ 99
	mascara: equ 255
	mascara2: equ 63

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
	je .bloque_4
	jne .bloque_5

.bloque_4:

	mov rax,[palabra_1 + 6]
	and rax,mascara
	add rax,1
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

.bloque_5:

	mov rax,[variable]
        and rax,mascara
	cmp rax,z
	je .bloque_6
	jmp .bloque_1 


.bloque_6:

	mov rax,[palabra_1 + 6]
	and rax,mascara
	sub rax,1
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


.final:

	mov rax,60
	mov rdi,0
	syscall

