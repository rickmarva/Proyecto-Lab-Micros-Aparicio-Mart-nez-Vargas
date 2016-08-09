section .data

	;Variables que guardan distintos mensajes que se necesitan en la bienvenida

	bienvenida: db 0x1b,"[1;1H",0x1b,"[2J","Bienvenidos a Micronoid",0xa
	bienvenida_tamano: equ $-bienvenida

	curso: db 'EL-4313-Lab. Estructrura de Microprocesadores 2S-2016',0xa
	curso_tamano: equ $-curso

	msj_ingrese: db 'Ingrese el nombre del jugador: '
	msj_ingrese_tamano: equ $-msj_ingrese

	borrar: db 0x1b,"[1;1H",0x1b,"[2J",""
	borrar_tamano: equ $-borrar

	nombre: db '',0xa

section .text
	global _start

;Primera etiqutea

_start:
	;Se realiza las impresiones de los distintos mensajes

	mov rax,1
	mov rdi,1
	mov rsi,bienvenida
	mov rdx,bienvenida_tamano
	syscall

	mov rax,1
        mov rdi,1
        mov rsi,curso
        mov rdx,curso_tamano
	syscall

	mov rax,1
	mov rdi,1
	mov rsi,msj_ingrese
	mov rdx,msj_ingrese_tamano
	syscall

	;Recepcion del nombre
	mov rax,0
	mov rdi,0
	mov rsi,nombre
	mov rdx,30
	syscall

	mov rax,1
	mov rdi,1
	mov rsi,borrar
	mov rdx,borrar_tamano
	syscall

	;Liberacion del sistema
	mov rax,60
	mov rdi,0
	syscall
