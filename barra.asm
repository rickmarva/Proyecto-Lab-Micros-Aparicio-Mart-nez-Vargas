section .data
	inicio: db '   ___   ',0xa   
	cons_inicio: equ $-inicio
	izq: db'*-*-*-*',0xa
	cons_izq: equ $-izq
	der: db'++++',0xa
	cons_der: equ $-der
	
	z:db'z'
	cons_z: equ $-z
	variable:db''

section .text
	global _start

_start:

_iniciando:
;imprime inicio
	mov rax,1
	mov rdi,1
	mov rsi,inicio
	mov rdx,cons_inicio
	syscall
	
	;capturo letra
	mov rax,0
	mov rdi,0
	mov rsi,variable
	mov rdx,1
	syscall
	
	;imprimo letra capturada
	mov rax,1
	mov rdi,1
	mov rbx,variable
	mov rdx,1
	syscall

	;comparo para saber  si imprimo izq o der
	mov r9,cons_z
	;mov rsi,variable
	cmp rbx,r9
	jne _derecha
	je _izquierda

_izquierda:
	;Tercer paso: Imprimir el banner de salida
        mov rax,1                                                       ;rax = "sys_write"
        mov rdi,1                                                       ;rdi = 1 (standard output = pantalla)
        mov rsi,izq                             ;rsi = mensaje a imprimir
        mov rdx,cons_izq      ;rdx=tamano del string
        syscall
	jmp _iniciando 

_derecha:
;Tercer paso: Imprimir el banner de salida
        mov rax,1                                                       ;rax = "sys_write"
        mov rdi,1                                                       ;rdi = 1 (standard output = pantalla)
        mov rsi,der                             ;rsi = mensaje a imprimir
        mov rdx,cons_der      ;rdx=tamano del string
        syscall 
	jmp _iniciando
