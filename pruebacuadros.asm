section .data
	cons_horizontal: db '----- ----- ----- ----- ----- -----',0xa
	cons_horizontales: equ $-cons_horizontal
	cons_lateral: db '!   ! !   ! !   ! !   ! !   ! !   !',0xa
	cons_laterales: equ $-cons_lateral
	num: equ 0
	num1: equ 3

section .text
	global _start
;11
_start:
.starting:
	mov r9, num
	mov R8,num1
.horizontala:
	mov rax,1
	mov rdi,1
	mov rsi,cons_horizontal
	mov rdx,cons_horizontales
	syscall

.vertical:
	mov rax,1
        mov rdi,1
        mov rsi,cons_lateral 
        mov rdx,cons_laterales
        syscall


.horizontalb:	mov rax,1
        mov rdi,1
        mov rsi,cons_horizontal 
        mov rdx,cons_horizontales
	syscall
	add r9, 1
        cmp r8, r9
	je .final
	jne .horizontala

.final:
	mov rax,60
	mov rdi,0
	syscall
