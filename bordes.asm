section .data
	borra: db 0x1b,"[1;1H", 0x1b,"[2J",""
	borra_tamano: equ $-borra

	borde_superior: db "x"
	borde_superior_tamano: equ $-borde_superior

	lateral: db "x"
	lateral_tamano: equ $-lateral

	lateral_fin: db 0x1b,"[68G","x",0xa
	lateral_fin_tamano: equ $-lateral_fin

	siguiente: db "",0xa
	siguiente_tamano: equ $-siguiente

	cons_bloque: db  "[_________]"
        cons_bloque_tamano: equ $-cons_bloque

        cons_aux: db '',0xa
        cons_aux_tamano: equ $-cons_aux

	regreso: db 0x1b,"[2;1H",""
	regreso_tamano: equ $-regreso

	mover: db 0x1b,"[2G","",
	mover_tamano: equ $-mover

	num1: equ 0
	num2: equ 68
	num3: equ 19
	num4: equ 6

section .text
	global _start

_start:
	mov rax,1
	mov rdi,1
	mov rsi,borra
	mov rdx,borra_tamano
	syscall
	mov r8,num1
	mov r9,num2

.primer_bloque:
	mov rax,1
	mov rdi,1
	mov rsi,borde_superior
	mov rdx,borde_superior_tamano
	syscall
	add r8,1
	jmp .segundo_bloque

.segundo_bloque:
	cmp r8,r9
	je .tercer_bloque
	jne .primer_bloque

.tercer_bloque:
	mov rax,1
	mov rdi,1
	mov rsi,siguiente
	mov rdx,siguiente_tamano
	syscall
	jmp .cuarto_bloque

.cuarto_bloque:
	mov rax,1
	mov rdi,1
	mov rsi,mover
	mov rdx,mover_tamano
	syscall
	mov rax,1
	mov rdi,1
	mov rsi,cons_bloque
	mov rdx,cons_bloque_tamano
	syscall
	mov rax,1
        mov rdi,1
        mov rsi,cons_bloque
        mov rdx,cons_bloque_tamano
        syscall
	mov rax,1
        mov rdi,1
        mov rsi,cons_bloque
        mov rdx,cons_bloque_tamano
        syscall
	mov rax,1
        mov rdi,1
        mov rsi,cons_bloque
        mov rdx,cons_bloque_tamano
        syscall
	mov rax,1
        mov rdi,1
        mov rsi,cons_bloque
        mov rdx,cons_bloque_tamano
        syscall
	mov rax,1
        mov rdi,1
        mov rsi,cons_bloque
        mov rdx,cons_bloque_tamano
        syscall
	mov rax,1
        mov rdi,1
        mov rsi,cons_aux
        mov rdx,cons_aux_tamano
        syscall
	jmp .quinto_bloque

.quinto_bloque:
	mov rax,1
        mov rdi,1
        mov rsi,mover
        mov rdx,mover_tamano
        syscall
	mov rax,1
        mov rdi,1
        mov rsi,cons_bloque
        mov rdx,cons_bloque_tamano
        syscall
	mov rax,1
        mov rdi,1
        mov rsi,cons_bloque
        mov rdx,cons_bloque_tamano
        syscall
	mov rax,1
        mov rdi,1
        mov rsi,cons_bloque
        mov rdx,cons_bloque_tamano
        syscall
	mov rax,1
        mov rdi,1
        mov rsi,cons_bloque
        mov rdx,cons_bloque_tamano
        syscall
	mov rax,1
        mov rdi,1
        mov rsi,cons_bloque
        mov rdx,cons_bloque_tamano
        syscall
	mov rax,1
        mov rdi,1
        mov rsi,cons_bloque
        mov rdx,cons_bloque_tamano
        syscall
	mov rax,1
        mov rdi,1
        mov rsi,cons_aux
        mov rdx,cons_aux_tamano
        syscall
	jmp .sexto_bloque

.sexto_bloque:
	mov rax,1
        mov rdi,1
        mov rsi,mover
        mov rdx,mover_tamano
        syscall
	mov rax,1
        mov rdi,1
        mov rsi,cons_bloque
        mov rdx,cons_bloque_tamano
        syscall
	mov rax,1
        mov rdi,1
        mov rsi,cons_bloque
        mov rdx,cons_bloque_tamano
        syscall
	mov rax,1
        mov rdi,1
        mov rsi,cons_bloque
        mov rdx,cons_bloque_tamano
        syscall
	mov rax,1
        mov rdi,1
        mov rsi,cons_bloque
        mov rdx,cons_bloque_tamano
        syscall
	mov rax,1
        mov rdi,1
        mov rsi,cons_bloque
        mov rdx,cons_bloque_tamano
        syscall
	mov rax,1
        mov rdi,1
        mov rsi,cons_bloque
        mov rdx,cons_bloque_tamano
        syscall
	mov r8,num1
	mov r9,num3
	mov rax,1
        mov rdi,1
        mov rsi,cons_aux
        mov rdx,cons_aux_tamano
        syscall
	jmp .bloque_13

.bloque_13:
	mov rax,1
	mov rdi,1
	mov rsi,regreso
	mov rdx,regreso_tamano
	syscall
	jmp .bloque_14

.bloque_14:
	mov rax,1
	mov rdi,1
	mov rsi,lateral
	mov rdx,lateral_tamano
	syscall
	mov rax,1
	mov rdi,1
	mov rsi,lateral_fin
	mov rdx,lateral_fin_tamano
	syscall
	add r8,1
	jmp .bloque_15

.bloque_15:
	cmp r8,r9
	je .bloque_16
	jne .bloque_14

.bloque_16:
	mov r8,num1
	mov r9,num2
	jmp .bloque_17

.bloque_17:
	mov rax,1
	mov rdi,1
	mov rsi,borde_superior
	mov rdx,borde_superior_tamano
	syscall
	add r8,1
	jmp .bloque_18

.bloque_18:
	cmp r8,r9
	je .final
	jne .bloque_17

.final:
	mov rax,1
	mov rdi,1
	mov rsi,siguiente
	mov rdx,siguiente_tamano
	syscall
	mov rax,60
	mov rdi,0
	syscall
