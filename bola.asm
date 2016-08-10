section .data

	bola: db 0x1b,"[10;10H","0",0xa
	cons_bola: equ $-bola
	
	mascara: equ 1
	limite1: equ 1
	limite2: equ 5
	variable: db"",0xa

section .text
	global _start

_start:

.bloque_0:
	
	mov rax,1
	mov rdi,1
	mov rsi,bola
	mov rdx,cons_bola
	syscall
	
	mov rax,0               ;rax ="sys_read"
        mov rdi,0               ;rdi = 0(standard input=teclado)
        mov rsi,variable        ;rsi= direccion de memoria donde será almacenado el dato recibido
        mov rdx,1               ;rdx=cuantos botones de teclado debe capturar
        mov rbx,[variable]
	syscall                 ;llamada al sistema
	jmp .bloque_1

.bloque_1:

	mov rax,1
        mov rdi,1
        mov rsi,bola
        mov rdx,cons_bola
        syscall

.bloque_2:
	and rbx,mascara
	cmp rbx,limite1
	jge .bloque_3
	jl .bloque_4

.bloque_3:
	and rbx,mascara
	cmp rbx,limite2
	jg .bloque_5
	jle .bloque_4

.bloque_4:	
	mov rax,[bola+6]
	and rax,mascara
	add rax,1
	add rbx,1
	mov [bola + 6],rax
	mov rax,72
	mov [bola + 7],rax

	mov rax,91
	mov [bola+8],rax
	mov rax,45
	mov [bola+9],rax
	mov rax,45
	mov [bola+10],rax
	mov rax,45
	mov [bola+11],rax
	mov rax,45
	mov [bola+12],rax
	mov rax,45
	mov [bola+13],rax
	mov rax,93
	mov [bola+14],rax
	syscall
	jmp .bloque_1

.bloque_5:
	
	mov rax,[bola + 6]
        and rax,mascara
        sub rax,1
        mov [bola + 6],rax
        mov rax,72
        mov [bola + 7],rax

        mov rax,91
        mov [bola + 8],rax
        mov rax,45
        mov [bola + 9],rax
        mov rax,45
        mov [bola + 10],rax
        mov rax,45
        mov [bola + 11],rax
        mov rax,45
        mov [bola + 12],rax
        mov rax,45
        mov [bola + 13],rax
        mov rax,93
        mov [bola + 14],rax
	syscall
        jmp .bloque_1
