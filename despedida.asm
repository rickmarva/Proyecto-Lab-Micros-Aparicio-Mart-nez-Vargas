section .data
	;Impresion de Variables

	salida: db 0x1b,"[1;1H",0x1b,"[2J",'Gracias por jugar Micronoid',0xa
	salida_tamano: equ $-salida

	nombre1: db 'Javier Aparicio Morales 201212069',0xa
	nombre1_tamano: equ $-nombre1
	nombre2: db 'Ricardo Martinez Vallejos 2013015275',0xa
	nombre2_tamano: equ $-nombre2
	nombre3: db 'Jose Vargas Aguero 2013014132',0xa
	nombre3_tamano: equ $-nombre3

	mensaje: db 'Presione Enter para terminar'
	mensaje_tamano: equ $-mensaje

	recibir: db ''

	mover: db 0x1b,"[1;4H",0x1b,"[2J","",0xa
	mover_tamano: equ $-mover

section .text
	global _start

;Primera etiqueta

_start:
	;Impresion

	mov rax,1
	mov rdi,1
	mov rsi,salida
	mov rdx,salida_tamano
	syscall

	mov rax,1
	mov rdi,1
	mov rsi,nombre1
	mov rdx,nombre1_tamano
	syscall

	mov rax,1
        mov rdi,1
        mov rsi,nombre2
        mov rdx,nombre2_tamano
        syscall

	mov rax,1
        mov rdi,1
        mov rsi,nombre3
        mov rdx,nombre3_tamano
        syscall

	mov rax,1
	mov rdi,1
	mov rsi,mensaje
	mov rdx,mensaje_tamano
	syscall

	;Recepacion de Enter
	mov rax,0
	mov rdi,0
	mov rsi,recibir
	mov rdx,1
	syscall

	mov rax,1
	mov rdi,1
	mov rsi,mover
	mov rdx,mover_tamano
	syscall

	mov rax,60
	mov rdi,0
	syscall


