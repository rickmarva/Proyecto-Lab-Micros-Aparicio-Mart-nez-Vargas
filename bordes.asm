section .data

	; Regrea cursor a la esquina superior izquierda y borra pantalla
	borra: db 0x1b,"[1;1H", 0x1b,"[2J",""
	borra_tamano: equ $-borra

	;Bordeado de la parte superior del juego
	borde_superior: db "-"
	borde_superior_tamano: equ $-borde_superior

	;Bordeado lateral del area de juego
	lateral: db "|"
	lateral_tamano: equ $-lateral

	;Bordeado lateral ubicado en el extremo derecho del area de juego
	lateral_fin: db 0x1b,"[50G","|",0xa
	lateral_fin_tamano: equ $-lateral_fin

	;Para pasar a la siguiente linea
	siguiente: db "",0xa
	siguiente_tamano: equ $-siguiente

	;Figura del bloque
	cons_bloque: db  "[______________]"
        cons_bloque_tamano: equ $-cons_bloque

	;Para pasar a la sigueinte linea
        cons_aux: db '',0xa
        cons_aux_tamano: equ $-cons_aux

	;Variable para ubicar el cursor en la linea dos, columna uno
	regreso: db 0x1b,"[2;1H",""
	regreso_tamano: equ $-regreso

	;Variable para posicionar el curso en la columna dos
	mover: db 0x1b,"[2G","",
	mover_tamano: equ $-mover

	;Mensaje para empezar a jugar
	mensaje: db 0x1b,"[12;15H", "Presione X para iniciar"
	mensaje_tamano: equ $-mensaje

	;Variable para ubicar en la esquina superior izquierda
	esquina: db 0x1b,"[1;1H",""
	esquina_tamano: equ $-esquina

	;Variables que van a sustituir los bloque cuando estos sean impactados

	posicion_a: db 0x1b,"[2;2H","                "
	posicion_a_tamano: equ $-posicion_a

	posicion_b: db 0x1b,"[2;18H","                "
        posicion_b_tamano: equ $-posicion_b

	posicion_c: db 0x1b,"[2;34H","                "
        posicion_c_tamano: equ $-posicion_c

	posicion_d: db 0x1b,"[3;2H","                "
        posicion_d_tamano: equ $-posicion_d

	posicion_e: db 0x1b,"[3;18H","                "
        posicion_e_tamano: equ $-posicion_e

	posicion_f: db 0x1b,"[3;34H","                "
        posicion_f_tamano: equ $-posicion_f

	posicion_g: db 0x1b,"[4;2H","                "
        posicion_g_tamano: equ $-posicion_g

	posicion_h: db 0x1b,"[4;18H","                "
        posicion_h_tamano: equ $-posicion_h

	posicion_i: db 0x1b,"[4;34H","                "
        posicion_i_tamano: equ $-posicion_i

	;Variable para posicionar cursor fuera del area de juego
	ajustar: db 0x1b,"[28;1H",""
	ajustar_tamano: equ $-ajustar

	letra: db ''

	num1: equ 0
	num2: equ 50
	num3: equ 25
	num4: equ 6
	num9: equ 9

	a: equ 97
	b: equ 98
	c: equ 99
	d: equ 100
	e: equ 101
	f: equ 102
	g: equ 103
	h: equ 104
	i: equ 105

	mascara: equ 255

section .text
	global _start
	global _segunda

;Primera etiqueta

_start:
	;Impresion de variables
	mov rax,1
	mov rdi,1
	mov rsi,borra
	mov rdx,borra_tamano
	syscall

	mov rax,1
        mov rdi,1
        mov rsi,mensaje
        mov rdx,mensaje_tamano
        syscall

	mov rax,1
	mov rdi,1
	mov rsi,esquina
	mov rdx,esquina_tamano
	syscall

	mov r8,num1
	mov r9,num2

.primer_bloque:
	;Imprime borde superior

	mov rax,1
	mov rdi,1
	mov rsi,borde_superior
	mov rdx,borde_superior_tamano
	syscall

	;Ciclo para que se imprima repetivamente el borde
	add r8,1

.segundo_bloque:
	;Comparacion de registros

	cmp r8,r9
	je .tercer_bloque
	jne .primer_bloque

.tercer_bloque:
	mov rax,1
	mov rdi,1
	mov rsi,siguiente
	mov rdx,siguiente_tamano
	syscall

.cuarto_bloque:
	;Impresion de los bloques de la primera fila

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
        mov rsi,cons_aux
        mov rdx,cons_aux_tamano
        syscall

.quinto_bloque:
	;Impresion segunda fila de bloques

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
        mov rsi,cons_aux
        mov rdx,cons_aux_tamano
        syscall

.sexto_bloque:
	;Impresion tercer bloque

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

	mov r8,num1
	mov r9,num3
	mov rax,1
        mov rdi,1
        mov rsi,cons_aux
        mov rdx,cons_aux_tamano
        syscall

.bloque_13:
	;Imprime variable para regresar el cursor

	mov rax,1
	mov rdi,1
	mov rsi,regreso
	mov rdx,regreso_tamano
	syscall

.bloque_14:
	;Impresion de los bordes

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

	;Se realiza mediante un ciclo
	add r8,1

.bloque_15:
	;Compara

	cmp r8,r9
	je .bloque_16
	jne .bloque_14

.bloque_16:
	;Asigancion de registros

	mov r8,num1
	mov r9,num2
	jmp .bloque_17

.bloque_17:
	;Impresion de bordes mediante ciclo

	mov rax,1
	mov rdi,1
	mov rsi,borde_superior
	mov rdx,borde_superior_tamano
	syscall
	add r8,1

.bloque_18:
	;Compara

	cmp r8,r9
	je .final
	jne .bloque_17

.final:
	;Sigueinte linea
	mov rax,1
	mov rdi,1
	mov rsi,siguiente
	mov rdx,siguiente_tamano
	syscall

;Segunda Etiqueta

_segunda:

	mov r8,num1

.primero:
	;Recepcion de letra

	mov rax,0
	mov rdi,0
	mov rsi,letra
	mov rdx,1
	syscall

.segundo:
	;Comparacion de letra

	mov rax,[letra]
	and rax,mascara
	cmp rax,a
	je .tercero
	jne .cuarto

.tercero:
	;Posicion a

	mov rax,1
	mov rdi,1
	mov rsi,posicion_a
	mov rdx,posicion_a_tamano
	syscall
	add r8,1
	jmp .seg_semi

.cuarto:
	;Compara letra

	mov rax,[letra]
        and rax,mascara
        cmp rax,b
        je .quinto
        jne .sexto

.quinto:
	;Posicion b

	mov rax,1
        mov rdi,1
        mov rsi,posicion_b
        mov rdx,posicion_b_tamano
        syscall
	add r8,1
        jmp .seg_semi

.sexto:
	;Compara letra

        mov rax,[letra]
        and rax,mascara
        cmp rax,c
        je .setimo
        jne .octavo

.setimo:
	;Posicion c

        mov rax,1
        mov rdi,1
        mov rsi,posicion_c
        mov rdx,posicion_c_tamano
        syscall
	add r8,1
        jmp .seg_semi

.octavo:
	;Compara letra

        mov rax,[letra]
        and rax,mascara
        cmp rax,d
        je .noveno
        jne .decimo

.noveno:
	;Posicion d

        mov rax,1
        mov rdi,1
        mov rsi,posicion_d
        mov rdx,posicion_d_tamano
        syscall
	add r8,1
        jmp .seg_semi

.decimo:
	;Compara letra

        mov rax,[letra]
        and rax,mascara
        cmp rax,e
        je .11x
        jne .12x

.11x:
	;Posicion e

        mov rax,1
        mov rdi,1
        mov rsi,posicion_e
        mov rdx,posicion_e_tamano
        syscall
	add r8,1
        jmp .seg_semi

.12x:
	;Compara letra

        mov rax,[letra]
        and rax,mascara
        cmp rax,f
        je .13x
        jne .14x

.13x:
	;Posicion f

        mov rax,1
        mov rdi,1
        mov rsi,posicion_f
        mov rdx,posicion_f_tamano
        syscall
	add r8,1
        jmp .seg_semi

.14x:
	;Compara letra

        mov rax,[letra]
        and rax,mascara
        cmp rax,g
        je .15x
        jne .16x

.15x:
	;Posicion g

        mov rax,1
        mov rdi,1
        mov rsi,posicion_g
        mov rdx,posicion_g_tamano
        syscall
	add r8,1
        jmp .seg_semi

.16x:
	;Compara letra

        mov rax,[letra]
        and rax,mascara
        cmp rax,h
        je .17x
        jne .18x

.17x:
	;Posicion h

        mov rax,1
        mov rdi,1
        mov rsi,posicion_h
        mov rdx,posicion_h_tamano
        syscall
	add r8,1
        jmp .seg_semi

.18x:
	;Compara letra

        mov rax,[letra]
        and rax,mascara
        cmp rax,i
        je .19x
        jne .primero

.19x:
	;Posicion i

        mov rax,1
        mov rdi,1
        mov rsi,posicion_i
        mov rdx,posicion_i_tamano
        syscall
	add r8,1
        jmp .seg_semi

.seg_semi:
	;Ajusta cursor y compara

	mov rax,1
	mov rdi,1
	mov rsi,ajustar
	mov rdx,ajustar_tamano
	syscall
	cmp r8,num9
	je .seg_final
	jne .primero

.seg_final:
	mov rax,60
	mov rdi,0
	syscall




