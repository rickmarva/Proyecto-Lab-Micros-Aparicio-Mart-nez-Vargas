section .data

	;--------------------Bienvenida_1------------------------------------------

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

	;-----------------------Bordes----------------------------------------------

	;Cursor invisible
	invisible: db 27,'[?25l'
	invisible_tamano: equ 6

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
        mensaje: db 0x1b,"[12;17H", "Presione X para iniciar"
        mensaje_tamano: equ $-mensaje

        ;Variable para ubicar en la esquina superior izquierda
        esquina: db 0x1b,"[1;1H",""
        esquina_tamano: equ $-esquina

        ;Variable para borrar texto
        borrar_txt: db 0x1b,"[12;15H","                         "
        borrar_txt_tamano: equ $-borrar_txt

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

	;----------------------Despedida--------------------------------

	;Impresion de Variables

	salida: db 0x1b,"[1;1H",0x1b,"[2J","Gracias por jugar Micronoid",0xa
	salida_tamano: equ $-salida

	nombre1: db 'Javier Aparicio Morales 201212069',0xa
	nombre1_tamano: equ $-nombre1
	nombre2: db 'Ricardo Martinez Vallejos 2013015275',0xa
	nombre2_tamano: equ $-nombre2
	nombre3: db 'Jose Vargas Aguero 2013014132',0xa
	nombre3_tamano: equ $-nombre3

	mensaje_salida: db 'Presione Enter para terminar'
	mensaje_salida_tamano: equ $-mensaje

	recibir: db ''

	cursor: db 0x1b,"[2J",""
	cursor_tamano: equ $-cursor

	mensaje_info: db 'No contiene las llamadas cpuid',0xa
        mensaje_info_tamano: equ $-mensaje

        siguiente_linea: db '',0xa
        siguiente_linea_tamano: equ $-siguiente_linea

	;-------------------------Barra-------------------------------------------

	palabra_1:db 0x1b,"[24;22H","-------",0x1b,"[10;2H",0xa;barra del juego
	tampal_1: equ $-palabra_1

	borra: db 0x1b,"[24;02H","                                                ",0xa ;variable de limpieza de la pantalla al mover la barra
        tamb: equ $-borra

	variable: db"",0xa

	;-------------------------------------------------------------------------

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
        x: equ 120
	z: equ 122

	nueve: equ 57
	cero: equ 48
	uno: equ 50
	cuatro: equ 52

        mascara: equ 255

        termios:        times 36 db 0                                                                   ;Estructura de 36bytes que contiene el modo de operacion de la$
        stdin:                    equ 0                                                                                         ;Standard Input (se usa stdin en lugar$
        ICANON:      equ 1<<1                                                                                   ;ICANON: Valor de control para encender/apagar el modo$
        ECHO:           equ 1<<3                                                                                        ;ECHO: Valor de control para encender/apagar e$

        canonical_off:

	;Se llama a la funcion que lee el estado actual del TERMIOS en STDIN
        ;TERMIOS son los parametros de configuracion que usa Linux para STDIN
        call read_stdin_termios

        ;Se escribe el nuevo valor de ICANON en EAX, para apagar el modo canonico
        push rax
        mov eax, ICANON
        not eax
        and [termios+12], eax
        pop rax

        ;Se escribe la nueva configuracion de TERMIOS
        call write_stdin_termios
        ret
        ;Final de la funcion

        echo_off:

        ;Se llama a la funcion que lee el estado actual del TERMIOS en STDIN
        ;TERMIOS son los parametros de configuracion que usa Linux para STDIN
        call read_stdin_termios

        ;Se escribe el nuevo valor de ECHO en EAX para apagar el echo
        push rax
        mov eax, ECHO
        not eax
        and [termios+12], eax
        pop rax

        ;Se escribe la nueva configuracion de TERMIOS
        call write_stdin_termios
        ret
	;Final de la funcion

        canonical_on:

        ;Se llama a la funcion que lee el estado actual del TERMIOS en STDIN
        ;TERMIOS son los parametros de configuracion que usa Linux para STDIN
        call read_stdin_termios

        ;Se escribe el nuevo valor de modo Canonico
        or dword [termios+12], ICANON

        ;Se escribe la nueva configuracion de TERMIOS
        call write_stdin_termios
        ret
        ;Final de la funcion

	echo_on:

        ;Se llama a la funcion que lee el estado actual del TERMIOS en STDIN
        ;TERMIOS son los parametros de configuracion que usa Linux para STDIN
        call read_stdin_termios

        ;Se escribe el nuevo valor de modo echo
        or dword [termios+12], ECHO

        ;Se escribe la nueva configuracion de TERMIOS
        call write_stdin_termios
        ret
        ;Final de la funcion

        read_stdin_termios:
        push rax
	push rbx
        push rcx
        push rdx

        mov eax, 36h
        mov ebx, stdin
        mov ecx, 5401h
        mov edx, termios
        int 80h

        pop rdx
        pop rcx
        pop rbx
        pop rax
        ret
        ;Final de la funcion

	write_stdin_termios:
        push rax
        push rbx
        push rcx
        push rdx

        mov eax, 36h
        mov ebx, stdin
        mov ecx, 5402h
        mov edx, termios
        int 80h

        pop rdx
        pop rcx
        pop rbx
	pop rax
        ret
        ;Final de la funcion

section .bss
        info: resb 32

section .text
        global _start

_start:
	;Llamadas de funciones

	mov rax,1
	mov rdi,1
	mov rsi,invisible
	mov rdx,invisible_tamano
	syscall

	call bienvenida_1
	call bordes
	call barra
	call borra_1
	call fin_juego

	;Liberacion del sistema

	mov rax,60
	mov rdi,0
	syscall


;Primera funcion

bienvenida_1:
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
        mov rdx,15
        syscall

	mov rax,1
	mov rdi,1
	mov rsi,r11
	mov rdx,10
	syscall

	mov rax,1
	mov rdi,1
	mov rsi,borrar
	mov rdx,borrar_tamano
	syscall

        ;retorno de la llamada
        ret

;Segunda funcion

bordes:
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
	je .bloque_19
	jne .bloque_17

.bloque_19:
	;Desactiva modo canonico y echo, ademas de adquirir letra

	call canonical_off
	call echo_off
	mov rax,1
        mov rdi,1
        mov rsi,siguiente
        mov rdx,siguiente_tamano
	syscall
	mov rax,0
	mov rdi,0
	mov rsi,letra
	mov rdx,1
	syscall

.bloque_20:
	;Compara letra

        mov rax,[letra]
        and rax,mascara
        cmp rax,x
        je .final
        jne .bloque_19

.final:
	;Sigueinte linea
	mov rax,1
	mov rdi,1
	mov rsi,borrar_txt
	mov rdx,borrar_txt_tamano
	syscall

	call canonical_on
	call echo_on
	ret

;Cuarta funcion

borra_1:

	mov r8,num1
	;Ajustar cursor
        mov rax,1
        mov rdi,1
        mov rsi,ajustar
        mov rdx,ajustar_tamano
        syscall

        call canonical_off
        call echo_off

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
	call canonical_on
	call echo_on
	ret

;Quinta funcion

fin_juego:

	mov rax,1
	mov rdi,1
	mov rsi,borrar
	mov rdx,borrar_tamano
	syscall

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

	ret

.seg:
	mov rax,1
	mov rdi,1
	mov rsi,mensaje
	mov rdx,mensaje_tamano
	syscall

	ret

;Tercera funcion

barra:
	call canonical_off
	call echo_off

.bloque_1:

	mov rax,1   ;imprime los espacios  para borrar la barra
	mov rdi,1
	mov rsi,borra
	mov rdx,tamb
	syscall

	mov rax,1 ;imprime la barra
	mov rdi,1
	mov rsi,palabra_1
	mov rdx,tampal_1
	syscall

.bloque_2:

	mov rax,0 ;captura la letra presionada
	mov rdi,0
	mov rsi,variable
	mov rdx,1
	syscall


.bloque_3:

	mov rax,[variable] ;compara la letra presionada con c
	and rax,mascara
	cmp rax,c
	je .bloque_pregunta_limited
	jne .bloque_5


.bloque_pregunta_limited:


	mov r9,[palabra_1 + 5] ;bloque que analiza el limite derecho de la pantalla en las decenas para no exceder la barra, osea 4
	and r9,mascara
	cmp r9,52;------------------------------------
	je .bloque_pregunta_limiteu
	jne .bloque_pregunta

.bloque_pregunta_limiteu:

	mov r9,[palabra_1 + 6];bloque que analiza el limite derecho de la pantalla en las unidades para no exceder la barra, osea 9
	and r9,mascara
	cmp r9,51;-------------------------------
	je .bloque_1 ;si esta en el limite pinta la barra en la misma posición porque no se va a mover
	jne .bloque_pregunta

.bloque_pregunta:

	mov r9,[palabra_1 + 6] ;analiza si la posición de la barra se encuentra en 9 en las unidades, para intercambiarlo por 0
	and r9,mascara
	cmp r9,57;---------------------------------------
	je .bloque_cambio
	jne .bloque_4


.bloque_cambio:

	mov rax,[palabra_1 + 5] ;intercambia la posicion de la barra de 9 en las unidades por 0 para iniciar una nueva cuenta
        and rax,mascara
        add rax,1
        mov [palabra_1 + 5],rax


	mov r9,cero
	and r9,mascara
	mov [palabra_1 + 6],r9

	mov rax,72 ;imprime el resto de la barra
        mov [palabra_1 + 7],rax

        mov rax,45
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
        mov rax,45
        mov [palabra_1 + 14],rax



	jmp .bloque_1


.bloque_4:

	mov r9,[palabra_1 + 6] ;sino se presentó ninguno de los bloques anteriores, suma 1 a las unidades en la posicion de la barra para moverla
	and r9,mascara
	add r9,1
	mov [palabra_1 + 6],r9

	mov rax,72
	mov [palabra_1 + 7],rax

	mov rax,45
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
        mov rax,45
        mov [palabra_1 + 14],rax


	jmp .bloque_1

.bloque_5: ;compara la letra presionada con z

	mov rax,[variable]
        and rax,mascara
	cmp rax,z
	je .bloque_pregunta_limited2
	jne .bloque_1

.bloque_pregunta_limited2: ;compara decenas de la posición de la barra para el limite izquierdo de la pantalla

        mov r9,[palabra_1 + 5]
        and r9,mascara
        cmp r9,cero
        je .bloque_pregunta_limiteu2
        jne .bloque_pregunta2

.bloque_pregunta_limiteu2: ;compara unidades de la posición de la barra para el limite izquierdo de la pantalla

        mov r9,[palabra_1 + 6]
        and r9,mascara
        cmp r9,uno
        je .bloque_1
        jne .bloque_pregunta2


.bloque_pregunta2: ;analiza si las unidades se encuentran en 0 ya que al restar posición se debe volver 9

	mov r9,[palabra_1 + 6]
        and r9,mascara
        cmp r9,cero
        je .bloque_cambio2
        jne .bloque_6

.bloque_cambio2: ;intercambia 0 por 9 en las unidades y le resta 1 a las decenas para continuar la cuenta

	mov rax,[palabra_1 + 5]
	and rax,mascara
	sub rax,1
	mov [palabra_1 + 5],rax

	mov r9,nueve
	and r9,mascara
	mov [palabra_1 + 6],r9

      	mov rax,72
        mov [palabra_1 + 7],rax

        mov rax,45
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
        mov rax,45
        mov [palabra_1 + 14],rax

	jmp .bloque_1



.bloque_6: ;le resta 1 a las unidades de la posición de la barra para moverla

	mov r9,[palabra_1 + 6]
	and r9,mascara
	sub r9,1
        mov [palabra_1 + 6],r9
        mov rax,72
        mov [palabra_1 + 7],rax

	mov rax,45
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
        mov rax,45
        mov [palabra_1 + 14],rax



	jmp .bloque_1


.final:
	call canonical_on
	call echo_on
	ret
