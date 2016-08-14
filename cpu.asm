section .data
	mensaje: db 'No contiene las llamadas cpuid',0xa
	mensaje_tamano: equ $-mensaje

	siguiente_linea: db '',0xa
	siguiente_linea_tamano: equ $-siguiente_linea

section .bss
	info: resb 32

section .text
	global _start
	global _perrito

_start:
	mov rax,80000000H
	cpuid
	mov r8,80000004H
	cmp rax,r8
	jb .seg

	mov rax,80000002H
	cpuid
	mov [info],rax
	mov [info + 0x4],rbx
	mov [info + 0x8],rcx
	mov [info + 0xc],rdx

	mov rax,80000003H
        cpuid
        mov [info + 0x10],rax
        mov [info + 0x14],rbx
        mov [info + 0x18],rcx
        mov [info + 0x1c],rdx

	mov rax,80000004H
        cpuid
        mov [info + 0x20],rax
        mov [info + 0x24],rbx
        mov [info + 0x28],rcx
        mov [info + 0x2c],rdx

	mov rax,1
	mov rdi,1
	mov rsi,info
	mov rdx,40
	syscall

	mov rax,1
	mov rdi,1
	mov rsi,siguiente_linea
	mov rdx,siguiente_linea_tamano
	syscall

	mov rax,60
	mov rdi,0
	syscall

.seg:
	mov rax,1
	mov rdi,1
	mov rsi,mensaje
	mov rdx,mensaje_tamano
	syscall
	mov rax,60
	mov rdi,0
	syscall
