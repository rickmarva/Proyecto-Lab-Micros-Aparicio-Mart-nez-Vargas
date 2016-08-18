;---------------------------------Macros-------------------------------------

%macro imprime 4

	mov rax,1               ;rax = "sys_write"
        mov rdi,1               ;rdi = 1 (standard output=pantalla)
        mov rsi,%1           ;rsi= mensaje a imprimir
        mov rdx,%2        ;rdx=tamaño del string a imprimir
        syscall                 ;llamada al sistema

        mov rax,1               ;rax = "sys_write"
        mov rdi,1               ;rdi = 1 (standard output=pantalla)
        mov rsi,%3        ;rsi =mensaje a imrimir
        mov rdx,%4        ;rdx=tamaño del string a imprimir
        syscall                 ;llamada al sistema

;        mov rax,0               ;rax ="sys_read"
;        mov rdi,0               ;rdi = 0(standard input=teclado)
;        mov rsi,variable        ;rsi= direccion de memoria donde será almacenado el dato recibido
;        mov rdx,1               ;rdx=cuantos botones de teclado debe capturar
;        syscall                 ;llamada al sistema

%endmacro

;Para el Macro imprime
;%1 borra1
;%2 tamborra
;%3 bola_1
;%4 tambola_1

;-------------------------Fin de macros-----------------------------------


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

	;-----------------------------bola--------------------------------------

	bola_1:db 0x1b,"[23;22H","@",0x1b,"[11;1H"			;Aqui se asigna la posiciòn inicial de la bola
        tambola_1: equ $-bola_1					;se define el tamaño del dato que se va a imprimir en imprime

        borra1: db 0x1b,"[11;40H"," ",0x1b,"[11;1H"			;Imprime un espacio donde se desea borrar la bola
        tamborra: equ $-borra1					;se define el tamaño

	subebaja: db "1",0xa					;bandera para indicarle al programa si sube o baja
	izqder: db "0",0xa


	;-------------------------------------------------------------------
	num0: equ 48
        num1: equ 0
        num2: equ 50
        num3: equ 25
        num4: equ 6
        num9: equ 9

	num2000: equ 2000



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
	mov r13,0
	mov r14,2000

.bloque_juego:

        call bola
	call barra
	add r13,1
	cmp r13,r14
	jne .bloque_juego
	call borra_1
	call fin_juego

	;Liberacion del sistema

	mov rax,60
	mov rdi,0
	syscall


;Primera funcion

bienvenida_1:
        ;Se realiza las impresiones de los distintos mensajes

	;Imprime mensaje de bienvenida
        mov rax,1
        mov rdi,1
        mov rsi,bienvenida
        mov rdx,bienvenida_tamano
        syscall

	;Imprime nombre del curso y codigo
	mov rax,1
        mov rdi,1
        mov rsi,curso
        mov rdx,curso_tamano
        syscall

	;Imprime banner para ingresar nombre
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

	;Limpia pantalla
	mov rax,1
	mov rdi,1
	mov rsi,borrar
	mov rdx,borrar_tamano
	syscall

        ;retorno de la llamada
        ret

;Segunda funcion

bordes:
	;Imprime mensaje de inicio
	mov rax,1
        mov rdi,1
        mov rsi,mensaje
        mov rdx,mensaje_tamano
        syscall


	;Imprime barra
	mov rax,1
	mov rdi,1
	mov rsi,palabra_1
	mov rdx,tampal_1
	syscall

	;Posiciona cursor en esquina superior izquierda
	mov rax,1
	mov rdi,1
	mov rsi,esquina
	mov rdx,esquina_tamano
	syscall

	;valores asignados a registros para ejecutar ciclos
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

	;Imprime siguiente linea
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
	;Impresion de los bordes del inicio y final respectivamente

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
	;Asignacion de registros

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

	;Limpia pantalla
	mov rax,1
	mov rdi,1
	mov rsi,borrar
	mov rdx,borrar_tamano
	syscall

	;Imprime banner salida
	mov rax,1
	mov rdi,1
	mov rsi,salida
	mov rdx,salida_tamano
	syscall

	;Imprime nombre de estudiantes
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

	;Imprime la informacion del computador a traves de distintos valores que se le dan a rax y que el editor entiende que se dirige a la
	;info del computador
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
	;Imprime mensaje
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
	mov r8,0
	mov r15,1

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

	cmp r8,r15
	jne .bloque_2
	ret

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
	jne .bloque_pregunta

	add r8,1
	jmp .bloque_1

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



	add r8,1
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


	add r8,1
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
        jne .bloque_pregunta2

	add r8,1
	jmp .bloque_1


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

	add r8,1
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


	add r8,1
	jmp .bloque_1

.bloque_final:

	ret

bola:


.bloque_izqder:
;---------------------------------------------
	mov rax,[bola_1 + 2]
	and rax,mascara
	mov [borra1 + 2],rax

	mov rax,[bola_1 + 3]
        and rax,mascara
        mov [borra1 + 3],rax

	mov rax,[bola_1 + 4]
        and rax,mascara
        mov [borra1 + 4],rax

	mov rax,[bola_1 + 5]
        and rax,mascara
        mov [borra1 + 5],rax

	mov rax,[bola_1 + 6]
        and rax,mascara
        mov [borra1 + 6],rax

	mov rax,72
        and rax,mascara
        mov [borra1 + 7],rax

	mov rax,32
	and rax,mascara
        mov [borra1 + 8],rax
	syscall

	mov rax,1
	mov rdi,1
	mov rsi,borra1
	mov rdx,tamborra
	syscall

;----------------------------------------------esto y el [2J
	mov rax,[izqder+1]
	and rax,mascara
	cmp rax,49
	je .bloque_3
	jne .bloque_5


.bloque_3:	;bloque izquierda-derecha

        mov rax,[bola_1 + 5]      ;mueve a rax las decenas de la posiciòn horizontal
        and rax,mascara           ;extiende a los bits necesarios para comparalo  con el 57 eb ascii
        cmp rax,52                ;compara si las decenas son iguales a 5
        je .bloque_2              ;si es igual salta al bloque 5 que es de izquierda arriba-abajo
        jne .bloque_3.5           ;si no es igual salta al bloque 3.5, que es derecha arriba-abajo

.bloque_2:

	mov rax,[bola_1 + 6]
	and rax,mascara
	cmp rax,57
	je .controlhorizontal
	jne .bloque_3.5


.controlhorizontal:

	mov rax,48
	mov [izqder+1],rax
	syscall
	jmp .bloque_izqder

.bloque_3.5:

	mov rax,[subebaja+1]	;mueve a rax la bandera subebaja
	and rax,mascara		;extiende los bits para realizar la comparación
	cmp rax,48		;si la bandera es igual a cero sube, si es igual a 1 baja
	je .bloque_4.2	        ;desplaza derecha  arriba
	jne .bloque_4.1         ;desplaza derecha abajo

.bloque_A:

	mov rax,49
	mov [izqder+1],rax
	ret

.bloque_a:

	mov rax,48		;se le asigna el valor de 0 a rax
	mov [subebaja+1],rax	;se le cambia el valor a la bandera a 0 con ayuda de rax
;	mov rax,49
;	mov [izqder+1],rax
	jmp .bloque_A		;regresa al bloque que pregunta izquierda-derecha

.bloque_b:

	mov rax,49		;se le asigna el valor de 1 a rax
	mov [subebaja+1],rax    ;se le cambia e valor a la bandera a 1 con ayuda de rax
	jmp .bloque_A		;regresa al bloque que pregunta izquierda derecha

.bloque_4.1: ;desplazamientos a la derecha abajo

	mov rax,[bola_1 + 6]     ;mueve a rax  el byte de  memoria almacenado en palabra1_ + 6
        and rax,mascara          ;completa los bits del regisstro eliminando los bit basura
        cmp rax,57               ;compara si el registro es igual a 9
        je .bloque_4.1.2         ;si es igual aumenta decenas, y pone en 0 unidades horizontales
        jne .bloque_4.1.1	 ;si no es igual simplemente incrementa unidades horizontales

.bloque_4.1.1:              ;desplazamientos a la derecha abajo unidades desplazamiento horizontal

	mov rax,[bola_1 + 3]	 ;mueve a rax, las unidades del desplazamiento vertical
	and rax,mascara		 ;completa los bits para la comparación
	cmp rax,57		 ;realiza la comparaciòn con 9, si es igual aumenta decenas
	je .bloque_4.1.1b	 ;aumentan decenas en el desplazamiento vertical
	jne .bloque_4.1.1a	 ;aumentan unidades en el desplazamiento vertical

.bloque_4.1.1a:		    ;Desplazamiento vertical con incremento de unidades

	mov r10,[bola_1 + 2]	;guarda en el registro el valor de las decenas vertical
	and r10,mascara		;elimina los bits basura del registro
	mov r9,[bola_1 + 5]	;guarda en el registro el valor de las decenas horizontal
        and r9,mascara		;elimina los bits basura del registro
        mov rax,[bola_1 + 6]    ;guarda en el registro el valor de las unidades horizontal
        and rax,mascara         ;elimina los bits basura del registro
        inc rax			;incremento en una posición el desplazamiento horizontal
	mov rbx,[bola_1 + 3]	;guarda en el registro el valor de las unidades vertical
	and rbx,mascara		;elimina los bits basura del registro
	inc rbx			;incrementa en una posición las unidades del desplazamiento vertical

	;reconstruyo lo almacenado en bola_1 con los desplazamientos
	mov [bola_1 + 2],r10	;asigna el viejo valor de las decenas del desplazamiento vertical
	mov [bola_1 + 3],rbx	;asigna el nuevo valor de las unidades del desplazamiento vertical
	mov r8,59		;le asigna al registro r8 el caracter ";" en ascii
	mov [bola_1 + 4],r8	;agrega el caracter a bola_1
	mov [bola_1 + 5],r9	;le asigna el viejo valor de decenas del desplazamiento horizontal
        mov [bola_1 + 6],rax	;le asigna el nuevo valor de las unidades al desplazamiento horizontal
        mov rax,72		;le asigna el registro rax el caracter  "H" en ascii
        mov [bola_1 + 7],rax	;le asigna a bola_1 el valor del registro

        mov rax,64		;muevo a rax el caracter "@"
        mov [bola_1 + 8],rax	;agrego a bola_1 el caracter "@"
        syscall			;llamado al sistema

	imprime borra1,tamborra,bola_1,tambola_1	;imprimo la bola en al pantalla


;-------------------------------------------------------------------------- aqui comparo si llego a 30 el limite vertical
	mov rax,[bola_1 + 2]	;mueve a el registro las decenas del desplazamiento vertical
        and rax,mascara		;elimina bits basura
        cmp rax,51	        ;mientras las decenas del eje vertical no sean 3
        je .bloque_a            ;desplaza derecha  arriba
        jne .bloque_b           ;desplaza derecha abajo
;--------------------------------------------------------------------------------

.bloque_4.1.1b:

        mov r10,[bola_1 + 2]    ;guarda en el registro el valor de las decenas vertical
        and r10,mascara		;elimina bits basura guardados en el registro
	inc r10			;incrementa las decenas del desplazamiento vertical
        mov r9,[bola_1 + 5]	;guarda en el registro el valor de las unidades horizontal
        and r9,mascara		;elimina bits basura guardados en el registro
        mov rax,[bola_1 + 6]    ;guarda en el registro el valor de las unidades horizontal
        and rax,mascara         ;elimina bits basura guardados en el registro
        inc rax			;incrementa  las unidades del desplazamiento horizontal

	;reconstruye bola_1 con los nuevos valores
        mov [bola_1 + 2],r10	;le asigna el valor viejo  de decenas del desplazamiento vertical
	mov rbx,48		;asigna al registro rbx el valor de 0
        mov [bola_1 + 3],rbx    ;le asigna el valor de 0 a las unidades del desplazamiento vertical
        mov r8,59		;se le asigna el caracer ";"
        mov [bola_1 + 4],r8	; se agrega a bola_1 el caracter ";"
        mov [bola_1 + 5],r9	;se agregan las decenas del desplazamiento horizonta
        mov [bola_1 + 6],rax	;se agregan las unidades del desplazamiento horizontal
        mov rax,72		;se asigna el caracter "H"
        mov [bola_1 + 7],rax    ;se asigna a bola_1 el caracter "H"

        mov rax,64		;se asigna al registro el "@"
        mov [bola_1 + 8],rax	;se agrega a la posiciòn 8 de bola_1  el  "@"
        syscall

        imprime borra1,tamborra,bola_1,tambola_1		;se imprime en pantalla la bola

;-------------------------------------------------------------------------- aqui comparo si llego a 30 el limite vertical
        mov rax,[bola_1 + 2]	;mueve al registro las decenas del desplazamiento vertical
        and rax,mascara		;elimina bits basura del registro
        cmp rax,51      	;mientras las decenas del eje vertical no sean 3, desplaza derecha arriba
        je .bloque_a  		;desplaza derecha  arriba
        jne .bloque_b		;desplaza derecha abajo
;--------------------------------------------------------------------------------



.bloque_4.1.2:          ;desplazamientos a la derecha abajo incremento decenas horizontal

        mov rax,[bola_1 + 3]	;mueve al registro las unidades del eje vertical
        and rax,mascara		;elimina bits basura
        cmp rax,57		;compara si incrementa unidades o decenas eje vertical
        je .bloque_4.1.2b	;incrementa decenas eje vertical
        jne .bloque_4.1.2a	;incrementa unidades eje vertical

.bloque_4.1.2a:		;incrementa las unidades del eje vertical

	mov r9,[bola_1 + 2]	;guarda en el registro las decenas del eje vertical
	and r9,mascara		;elimina bits basura
        mov r10,[bola_1 + 5]    ;mueve al registro las decenas del eje horizontal
        and r10,mascara         ;elimina bits basura
        inc r10			;incremento decenas eje horizontal
        mov rbx,[bola_1 + 3]	;mueve al registro las unidades del eje vetical
        and rbx,mascara		;elimina bits basura
        inc rbx			;incrementa unidades del eje vertical

	;recontruye bola_1 con los nuevos valores
	mov [bola_1 + 2],r9	;agrega decenas eje vertical
        mov [bola_1 + 3],rbx	;agrega unidades eje vertical
        mov r8,59		;mueve al registro el caracter ";"
        mov [bola_1 + 4],r8	;mueve a bola_1 el caracter de ";"
        mov [bola_1 + 5],r10	;agrega decenas eje horizontal
	mov r8, 48		;mueve al registro el valor de 0
        mov [bola_1 + 6],r8	;agrega el valor de 0 a las unidades del eje horizontal
        mov r8,72		;mueve al registro el caracter "H"
        mov [bola_1 + 7],r8	;agrega a bola_1 el caracter "H"

        mov rax,64		; mueve al registro el caracter "@"
        mov [bola_1 + 8],rax	;agrega a bola_1 el "@"
        syscall			;llamado al sistema


        imprime borra1,tamborra,bola_1,tambola_1		;imprime en pantalla la bola

;-------------------------------------------------------------------------- aqui comparo si llego a 30 el limite vertical
        mov rax,[bola_1 + 2]	;mueve al registro las decenas del eje vertical
        and rax,mascara		;elimina bits basura
        cmp rax,51      	;mientras las decenas del eje vertical no sean 3
        je .bloque_a  		;desplaza derecha  arriba
        jne .bloque_b		;desplaza derecha abajo
;--------------------------------------------------------------------------------

.bloque_4.1.2b:		;incrementa las decenas del eje vertical

	mov r9,[bola_1 + 2]	;mueve al registro las decenas del eje vertical
        and r9,mascara		;elimina bits basura
	inc r9			;incrementa decenas eje vertical
        mov r10,[bola_1 + 5]    ;mueve al registro las decenas del eje horizontal
        and r10,mascara         ;elimina bits basura
        inc r10			;incrementa decenas del eje horizontal

	;recontruye los valores de bola_1
        mov [bola_1 + 2],r9	;agrega decenas eje vertical
	mov rbx,48
        mov [bola_1 + 3 ],rbx	;agrega unidades eje vertical
        mov r8,59
        mov [bola_1 + 4],r8	;agrega caracter ";"
        mov [bola_1 + 5],r10	;agrega decenas eje horizontal
        mov r8, 48
        mov [bola_1 + 6],r8	;agrega unidades eje horizontal
        mov r8,72
        mov [bola_1 + 7],r8	;agrega caracter "H"

        mov rax,64
        mov [bola_1 + 8],rax	;agrega el "@"
        syscall


        imprime borra1,tamborra,bola_1,tambola_1		;imprime la bola

;-------------------------------------------------------------------------- aqui comparo si llego a 30 el limite vertical
        mov rax,[bola_1 + 2]	;mueve las decenas del eje vertical al registro
        and rax,mascara		;elimina bits basura
        cmp rax,51      	;mientas las decenas del eje vertical no sean 3
        je .bloque_a  		;desplaza derecha  arriba
        jne .bloque_b		;desplaza derecha abajo
;--------------------------------------------------------------------------------



.bloque_4.2:   ;desplazamientos a la derecha arriba

	mov rax,[bola_1 + 6]     ;Mueve a rax las unidades del desplazamiento horizontal
        and rax,mascara          ;extiende el byte de rax a los 32 para ppoder compararlo con el 57 enb ascii
        cmp rax,57               ;compara si el registro es igual a 9
        je .bloque_4.2.2         ;si es igual incrementa  decenas, y pone en 9 unidades
        jne .bloque_4.2.1        ;si no es igual simplemente incrementa  unidades


.bloque_4.2.1:		;Incrementos a las unidades desplazamiento horizontal

	mov rax,[bola_1 + 3]	;mueve al registro las unidades del eje vertical
	and rax,mascara		;elimina bits basura
	cmp rax,48	        ;compara si decrementa unidades o decenas en la vertical
	je .bloque_4.2.1b	;decrementa decenas vertical
	jne .bloque_4.2.1a	;decrementa  unidades vertical

.bloque_4.2.1a:		;decrementa unidades del eje vertical

	mov r10,[bola_1 + 2]	;mueve al registro decenas eje vertical
	and r10,mascara		;elimina bits basura
	mov r9,[bola_1 + 5]	;mueve al registro decenas eje horizontal
        and r9,mascara		;elimina bits basura
	mov rax,[bola_1 + 6]    ;mueve al registro unidades del eje horizontal
        and rax,mascara         ;elimina bits basura
        inc rax			;incrementa unidades eje horizontal
        mov rbx,[bola_1 + 3]	;mueve al registro la unidades del eje horizontal
        and rbx,mascara		;elimina bits basura
        dec rbx			;decrementa unidades del eje vertical

	;reconstruye bola_1
	mov [bola_1 + 2],r10	;agrega decenas eje vertical
        mov [bola_1 + 3],rbx	;agrega unidades eje vertical
        mov r8,59
        mov [bola_1 + 4],r8	;agrega el caracter ";"
        mov [bola_1 + 5],r9	;agrega las decenas eje horizontal
        mov [bola_1 + 6],rax	;agrega las unidades del eje horizontal
        mov rax,72
        mov [bola_1 + 7],rax	;agrega el caracter "H"

        mov rax,64
        mov [bola_1 + 8],rax	;agrega el "@"
        syscall			;llamado al sistema


        imprime borra1,tamborra,bola_1,tambola_1
;----------------------------------------------------------------------------revisa si llego a la posicion 01 vertical
	mov rax,[bola_1 + 2]	;mueve al registro las decenas del eje vertical
        and rax,mascara		;elimina bits basura
        cmp rax,48		;compara con 0
        je .revisa  		;si es igual revisa si llego a 01
        jne .bloque_a		;desplaza  arriba

.revisa:
	mov rax,[bola_1 + 3]	;mueve al registro las unidades del eje vertical
	and rax,mascara		;elimina bits basura
	cmp rax,49		;compara con 1
	je .bloque_b 		;desplaza abajo
	jne .bloque_a 		;desplaza arriba

        ;jmp .bloque_3
;-----------------------------------------------------------------------

.bloque_4.2.1b:		;decrementa decenas del eje vertical

        mov r9,[bola_1 + 5]	;mueve al registro las decenas del eje horizontal
        and r9,mascara		;elimina bits basura
        mov rax,[bola_1 + 6]    ;mueve al registro las unidades del eje horizontal
        and rax,mascara         ;elimina bits basura
        inc rax			;incrementa unidades del eje horizontal
        mov r10,[bola_1 + 2]	;mueve al registro las decenas del eje vertical
        and r10,mascara		;elimina bits basura
        dec r10			;decrementa decenas del eje vertical

	;reconstruye bola_1
        mov [bola_1 + 2],r10	;agrega decenas eje vertical
	mov rbx,57
        mov [bola_1 + 3],rbx	;agrega unidades eje vertical
        mov r8,59
        mov [bola_1 + 4],r8	;agrega caracter ";"
        mov [bola_1 + 5],r9	;agrega decenas del eje horizontal
        mov [bola_1 + 6],rax	;agrega unidades del eje horizontal
        mov rax,72
        mov [bola_1 + 7],rax	;agrega caracter "H"

        mov rax,64
        mov [bola_1 + 8],rax	; agrega el caracter "@"
	syscall


        imprime borra1,tamborra,bola_1,tambola_1		;imprime en pantalla la bola
;----------------------------------------------------------------------------compara si llego a la posicion 01 vertical
        mov rax,[bola_1 + 2]	;mueve al registro las decenas eje vertical
        and rax,mascara		;elimina bits basura
        cmp rax,48		;compara con 48
        je .revisa1  		;revisa si las unidades del eje vertical son igual a 1
        jne .bloque_a		;desplaza  arriba

.revisa1:
        mov rax,[bola_1 + 3]	;mueve al registro las unidades eje vertical
        and rax,mascara		;elimina bits basura
        cmp rax,49		;compara con 1
        je .bloque_b 		;desplaza abajo
        jne .bloque_a 		;desplaza arriba

        ;jmp .bloque_3
;-----------------------------------------------------------------------


.bloque_4.2.2:		;incrementa decenas del eje horizontal

	mov rax,[bola_1 + 3]	;mueve al registro las unidades del eje vertical
        and rax,mascara		;elimina bits basura
        cmp rax,48      	;compara si decrementa unidades en la vertical
        je .bloque_4.2.2b       ;decrementa decenas vertical
        jne .bloque_4.2.2a      ;decrementa  unidades vertical

.bloque_4.2.2a:		;decrementa las unidades del eje vertical

	mov r10,[bola_1 + 2]	;mueve al registro las decenas del eje vertical
	and r10,mascara		;elimina los bits basura
	mov rax,[bola_1 + 5]    ;mueve al registro las decenas del eje horizontal
        and rax,mascara         ;elimina los bits basura
        inc rax			;incrementa decenas del eje horizontal
        mov rbx,[bola_1 + 3]	;mueve al registro unidades del eje vertical
        and rbx,mascara		;elimina bits basura
        dec rbx

	;recontruye bola_1
	mov [bola_1 + 2],r10	;agrega decenas eje vertical
        mov [bola_1 + 3 ],rbx	;agrega unidades eje vertical
        mov r8,59
        mov [bola_1 + 4],r8	;agrega el caracter ";"
        mov [bola_1 + 5],rax	;agrega decenas del eje horizontal
        mov r8, 48
        mov [bola_1 + 6],r8	;agrega unidades del eje horizontal
        mov r9,72
        mov [bola_1 + 7],r9	;agrega caracter "H"

        mov rax,64
        mov [bola_1 + 8],rax	;agrega el "@"
        syscall

        imprime borra1,tamborra,bola_1,tambola_1	;imprime en pantalla la bola

;----------------------------------------------------------------------------compara si llego a la posicion 01 vertical
        mov rax,[bola_1 + 2]	;mueve al registro las decenas del eje verticla 
        and rax,mascara
        cmp rax,48		;compara con 0
        je .revisa2  		;revisa si las unidades del eje vertical son igual a 1
        jne .bloque_a		; desplaza  arriba

.revisa2:
        mov rax,[bola_1 + 3]	;mueve al registro las unidades del eje vertical
        and rax,mascara
        cmp rax,49		;compara con 1
        je .bloque_b 		;desplaza abajo
        jne .bloque_a 		;desplaza arriba

        ;jmp .bloque_3
;-----------------------------------------------------------------------


.bloque_4.2.2b:		;decrementa las decenas del eje vertical

	mov rax,[bola_1 + 5]	;mueve al registro las decenas del eje horizontal
        and rax,mascara         ;elimina bits basura
        inc rax		        ;incrementa decenas del eje horizontal
        mov rbx,[bola_1 + 2]    ;mueve al registro las decenas del eje vertical
        and rbx,mascara	        ;elimina bits basura
        dec rbx		        ;decremtenta las decenas del  eje vertical

	;reconstruimos bola_1
	mov [bola_1 +2],rbx	;agregamos decenas del eje vertical
	mov r10,57
	mov [bola_1 + 3],r10	;agregamos unidades del eje vertical
        mov r8,59
        mov [bola_1 + 4],r8	;agregamos el caracter ";"
        mov [bola_1 + 5],rax	;agregamos decenas del eje horizontal
        mov r8, 48
        mov [bola_1 + 6],r8	;agregamos unidades del eje vertical
        mov r9,72
        mov [bola_1 + 7],r9	;agregamos el caracter "H"

        mov rax,64
        mov [bola_1 + 8],rax	;agregamos el "@"
        syscall

        imprime borra1,tamborra,bola_1,tambola_1		;imprime en pantalla la bola

;---------------------------------------------------------------------comprueba si se llego a la posicion 01 eje vertical
        mov rax,[bola_1 + 2]	;mueve al registro las decenas del eje vertical
        and rax,mascara		;elimina bits basura
        cmp rax,48		;compara con 0
        je .revisa3  		;revisa si las unidades del eje vertical son igual a 1
        jne .bloque_a		;desplaza  arriba

.revisa3:
        mov rax,[bola_1 + 3]	;mueve al registro las unidades del eje vertical 
        and rax,mascara		;elimina bits basura
        cmp rax,49		;compara con 1
        je .bloque_b 		;desplaza abajo
        jne .bloque_a 		;desplaza arriba

        ;jmp .bloque_3
;-----------------------------------------------------------------------



;**********************************************IZQUIERDAAAA******************************************************************************************
.bloque_izqder1:

        mov rax,[izqder+1]
        and rax,mascara
        cmp rax,48
        je .bloque_5
        jne .bloque_izqder1

.bloque_5:		;mantiene el desplazamiento a la izquierda hasta la posicion 01 horizontal

        mov rax,[bola_1 + 5]	;mueve al registro las decenas del eje horizontal
        and rax,mascara		;elimina bits basura
        cmp rax,48		;compara con 0
        je .bloque_5.5		;compara si las unidades son igual a 1
        jne .bloque_6		;realiza desplazamientos a la izquierda

.bloque_5.5:		;compara si las unidades son igual a 1

	mov rax,[bola_1 + 6]	;mueve al registro las unidades del eje horizontal
	and rax,mascara		;elimina bits basura
	cmp rax,50		;comparo si llego a la posicion 1
	je .controlhorizontal1		;realiza desplazamientos a la derecha
	jne .bloque_6		;continua con desplazamientos a la izquierda

.controlhorizontal1:

	mov rax,49
        mov [izqder+1],rax
        syscall
        jmp .bloque_izqder


.bloque_6:

	mov rax,48
	mov [izqder+1],rax
	mov rax,[subebaja+1]	;mueve al registro el valor de la bandera
        and rax,mascara		;elimina bits basura
        cmp rax,48      	;si la bandera es igual a cero sube, si es igual a 1 baja
        je .bloque_7.2  	;desplaza izquierda  sube
        jne .bloque_7.1		;desplaza izquierda  baja

.bloque_C:

	mov rax,48
	mov [izqder+1],rax
	ret

.bloque_c:

        mov rax,48		;mueve al registro el valor de 0
        mov [subebaja+1],rax	;cambia el valor de la bandera a 0 con ayuda de rax
        jmp .bloque_C			;bloque_5		;vuelve al ciclo de izquierda

.bloque_d:

        mov rax,49		;mueve al registro el valor de 1
        mov [subebaja+1],rax	;cambia el valor de la bandera a 1 con ayuda de rax
        jmp .bloque_C      ;.bloque_5		;vuelve al ciclo de izquierda

.bloque_7.1:		;desplazamiento izquierda abajo

         mov rax,[bola_1 + 6]     ;mueve al registro las unidades del eje horizontal
         and rax,mascara          ;elimina bits basura
         cmp rax,48               ;compara si el registro es igual a 0
         je .bloque_7.1.2         ;si es igual decrementa  decenas, y pone en 9 unidades
         jne .bloque_7.1.1        ;si no es igual simplemente decrementa  unidades


.bloque_7.1.1:              ;desplazamientos a la izquierda abajo

	mov rax,[bola_1 + 3]	;mueve al registro las unidades del eje horizontal
	and rax,mascara		;elimina bits basura
	cmp rax,57		;compara si el registro es igual a 0
	je .bloque_7.1.1b	;aumentan decenas en la vertical
	jne .bloque_7.1.1a	;aumentan unidades en la vertical


.bloque_7.1.1a:		   ;incremento unidades del eje vertical

	mov r10,[bola_1 + 2]	;mueve al registro decenas del eje vertical
	and r10,mascara		;elimina bits basura
	mov r9,[bola_1 + 5]	;mueve al registro decenas eje horizontal
	and r9,mascara		;elimina bits basura
        mov rax,[bola_1 + 6]    ;mueve al registro las unidades del eje horizontal
        and rax,mascara         ;elimina bits basura
        dec rax			;decrementa unidades del eje horizontal
        mov rbx,[bola_1 + 3]	;mueve al registro las unidades del eje vertical
        and rbx,mascara		;elimina bits basura
        inc rbx			;incrementa unidades del eje vertical

	;recontruye bola_1
	mov [bola_1 + 2],r10	;agregamos decenas eje vertical
        mov [bola_1 + 3 ],rbx	;agregamos unidades del eje vertical
        mov r8,59
        mov [bola_1 + 4],r8	;agregamos el caracter ";"
        mov [bola_1 + 5],r9	;agregamos decenas del eje horizontal
        mov [bola_1 + 6],rax	;agregamos unidades del eje horizontal
        mov rax,72
        mov [bola_1 + 7],rax	;agregamos el caracter "H"

        mov rax,64
        mov [bola_1 + 8],rax	;agregamos el "@"
        syscall			;llamado al sistema

        imprime borra1,tamborra,bola_1,tambola_1		;imprime en pantalla la bola

;-------------------------------------------------------------------------- aqui comparo si llego a 30 el limite vertical
	mov rax,[bola_1 + 2]	;mueve al registro las decenas del eje vertical
        and rax,mascara		;elimina bits basura
        cmp rax,51		; mientas las decenas del eje vertical no sean 3
        je .bloque_c  		;desplaza derecha  arriba
        jne .bloque_d		; desplaza derecha abajo
;--------------------------------------------------------------------------------


.bloque_7.1.1b:		;incremento decenas vertical

	mov r9,[bola_1 + 5]	;mueve al registro las decenas del eje horizontal
        and r9,mascara		;elimina bits basura
        mov rax,[bola_1 + 6]    ;mueve al registro las unidades del eje horizontal
        and rax,mascara         ;elimina bits basura
        dec rax			;decrementa las unidades del eje horizontal
        mov r10,[bola_1 + 2]	;mueve al registro las decenas del eje vertical
        and r10,mascara		;elimina bits basura
        inc r10			;incrementa las decenas del eje vertical
        
	;se reconstruye bola_1
	mov [bola_1 + 2],r10	;agregamos decenas eje vertical
	mov rbx,48
	mov [bola_1 + 3 ],rbx	;agregamos unidades eje vertical
        mov r8,59
        mov [bola_1 + 4],r8	;agregamos caracter ";"
        mov [bola_1 + 5],r9	;agregamos decenas eje horizontal
        mov [bola_1 + 6],rax	;agregamos unidades eje vertical
        mov rax,72
        mov [bola_1 + 7],rax	;agregamos caracter "H"

        mov rax,64
        mov [bola_1 + 8],rax	;agregamos el "@"
        syscall
        imprime borra1,tamborra,bola_1,tambola_1		;imprime la bola en la pantalla

;-------------------------------------------------------------------------- aqui comparo si llego a 30 el limite vertical
        mov rax,[bola_1 + 2]	;mueve al registro las decenas del eje vertical
        and rax,mascara		;elimina bits basura
        cmp rax,51      	; mientas las decenas del eje vertical no sean 3
        je .bloque_c  		;desplaza derecha  arriba
        jne .bloque_d		; desplaza derecha abajo
;--------------------------------------------------------------------------------


.bloque_7.1.2:		;decremento decenas horizontal

	mov rax,[bola_1 + 3]	;mueve al registro las unidades del eje vertical
        and rax,mascara		;elimina bits basura
        cmp rax,57		;compara si es igual a 9
        je .bloque_7.1.2b       ;aumentan decenas en la vertical
        jne .bloque_7.1.2a      ;aumentan unidades en la vertical

.bloque_7.1.2a:		;Incremento unidades vertical

	mov r10,[bola_1 + 2]	;mueve al registro las decenas eje vertical
	and r10,mascara		;elimina bits basura
        mov rax,[bola_1 + 5]    ;mueve al registro las decenas del eje horizontal
        and rax,mascara         ;elimina bits basura
        dec rax			;decrementa las decenas del eje horizontal
        mov rbx,[bola_1 + 3]	;mueve al registro las unidades del eje vertical
        and rbx,mascara		;elimina bits basura
        inc rbx			;incrementa las unidades del eje vertical

	;se recontruye bola_1
	mov [bola_1 + 2],r10	;agregamos decenas eje vertical
	mov [bola_1 + 3 ],rbx	;agregamos unidades eje vertical
        mov r8,59
        mov [bola_1 + 4],r8	;agregamos el caracter ";"
        mov [bola_1 + 5],rax	;agregamos decenas eje horizontal
	mov r9,57
        mov [bola_1 + 6],r9	;agregamos unidades eej horizontal
        mov rax,72
        mov [bola_1 + 7],rax	;agregamos el caracter "H"

        mov rax,64
        mov [bola_1 + 8],rax	;agregamos el "@"
        syscall
        imprime borra1,tamborra,bola_1,tambola_1		;imprime la bola

;-------------------------------------------------------------------------- aqui comparo si llego a 30 el limite vertical
        mov rax,[bola_1 + 2]	;mueve al registro las decenas del eje vertical
        and rax,mascara		;elimina bits basura
        cmp rax,51      	;mientas las decenas del eje vertical no sean 3
        je .bloque_c  		;desplaza derecha  arriba
        jne .bloque_d		;desplaza derecha  abajo
;--------------------------------------------------------------------------------

	;jmp .bloque_5

.bloque_7.1.2b:		;incremento decenas vertical

	mov r10,[bola_1 + 2]	;muevo al registro las decenas del eje vertical
        and r10,mascara		;elimino bits basura
	inc r10			;incremento las decenas del eje vertical
        mov rax,[bola_1 + 5]    ;muevo al registro las decenas del eje horizontal
        and rax,mascara         ;elimino bits basura
        dec rax			;decremento decenas del eje horizontal

	;se recontruye bola_1
        mov [bola_1 + 2],r10	;agregamos decenas eje vertical
	mov rbx,48
        mov [bola_1 + 3],rbx	;agregamos unidades eje vertical
        mov r8,59
        mov [bola_1 + 4],r8	;agregamos caracter ";"
        mov [bola_1 + 5],rax	;agregamos decenas eje horizontal
        mov r9,57
        mov [bola_1 + 6],r9	;agregamos unidades eje horizontal
        mov rax,72
        mov [bola_1 + 7],rax	;agregamos el caracter "H"

        mov rax,64
        mov [bola_1 + 8],rax	;agregamos el "@"
        syscall			;llamado al sistema

        imprime borra1,tamborra,bola_1,tambola_1		;imprime la bola

;-------------------------------------------------------------------------- aqui comparo si llego a 30 el limite vertical
        mov rax,[bola_1 + 2]	;mueve al registro las decenas del eje vertical
        and rax,mascara		;elimina bits basura
        cmp rax,51      	; mientas las decenas del eje vertical no sean 3
        je .bloque_c  		;desplaza derecha  arriba
        jne .bloque_d		; desplaza derecha abajo
;--------------------------------------------------------------------------------

        ;jmp .bloque_5



.bloque_7.2:		;desplazamiento izquierda sube

	 mov rax,[bola_1 + 6]     ;mueve al registro las unidades del eje horizontal
         and rax,mascara          ;elimina bits basura
         cmp rax,48               ;compara si el registro es igual a 0
         je .bloque_7.2.2         ;si es igual decrementa  decenas, y pone en 9 unidades eje horizontal
         jne .bloque_7.2.1        ;si no es igual simplemente decrementa  unidades eje horizontal


.bloque_7.2.1:            ;decrementos unidades eje horizontal

	mov rax,[bola_1 + 3]	;muevo al registro las unidades del eje vertical
	and rax,mascara		;elimino bits basura
	cmp rax,48		;compara si decrementa unidades en la vertical
	je .bloque_7.2.1b	;decrementa decenas vertical
	jne .bloque_7.2.1a	;decrementa  unidades vertical

.bloque_7.2.1a:		;Decremento unidades eje vertical

	mov r10,[bola_1 + 2]	;muevo al registro las decenas eje vertical
	and r10,mascara		;elimino bits basura
	mov r9,[bola_1 + 5]	;muevo al registro las decenas del eje horizontal
	and r9,mascara		;elimino bits basura
        mov rax,[bola_1 + 6]    ;muevo al registro las unidades del eje horizontal
        and rax,mascara         ;elimina bits basura
        dec rax			;decremento unidades eje horizontal
        mov rbx,[bola_1 + 3]	;mueve al registro las unidades del eje vertical
        and rbx,mascara		;elimina bits basura
        dec rbx			;decremento en las unidades del eje vertical

	;se reconstruye bola_1
	mov [bola_1 + 2],r10	;agregamos decenas eje vertical
        mov [bola_1 + 3 ],rbx	;agregamos unidades eje vertical
        mov r8,59
        mov [bola_1 + 4],r8	;agregamos caracter ";"
        mov [bola_1 + 5],r9	;agregamos decenas eje horizontal
        mov [bola_1 + 6],rax	;agregamos unidades eje horizontal
        mov rax,72
        mov [bola_1 + 7],rax	;agregamos caracter "H"

        mov rax,64
        mov [bola_1 + 8],rax	;agregamos el "@"
        syscall			;llamado al sistema

        imprime borra1,tamborra,bola_1,tambola_1		;imprime la bola ne la pantalla

;-------------------------------------------------------------------------compara si el eje vertical llego al limite 01
	mov rax,[bola_1 + 2]	;mueve al registro las decenas del eje vertical
        and rax,mascara		;elimina bits basura
        cmp rax,48		;compara con 0
        je .revisa4 		;revisa si las unidades son igual a 1
        jne .bloque_c		; desplaza  arriba

.revisa4:
	mov rax,[bola_1 + 3]	;mueve al registro las unidades del eje vertical
	and rax,mascara		;elimina bits basura
	cmp rax,49		;compara con 1
	je .bloque_d 		;desplaza abajo
	jne .bloque_c 		;desplaza arriba

;-----------------------------------------------------------------------

        ;jmp .bloque_5

.bloque_7.2.1b:		;decremento decenas vertical

        mov r9,[bola_1 + 5]	;mueve al registro las decenas del eje horizontal
        and r9,mascara		;elimina bits basura
        mov rax,[bola_1 + 6]    ;mueve al registro las unidades del eje horizontal
        and rax,mascara         ;elimina bits basura
        dec rax			;decrementa unidades del eje horizontal
        mov r10,[bola_1 + 2]	;mueve al registro las decenas del eje vertical
        and r10,mascara		;alimina bits basura
        dec r10			;decremento de las decenas del eje vertical

	;se reconstruye bola_1
        mov [bola_1 + 2],r10	;agregamos las decenas eje vertical
	mov rbx,57
        mov [bola_1 + 3 ],rbx	;agregamos las unidades eje vertical
        mov r8,59
        mov [bola_1 + 4],r8	;agregamos el caracter ";"
        mov [bola_1 + 5],r9	;agregamos las decenas eje horizontal
        mov [bola_1 + 6],rax	;agregamos las unidades eje horizontal
        mov rax,72
        mov [bola_1 + 7],rax	;agregamos caracter  "H"

        mov rax,64
        mov [bola_1 + 8],rax	;agregamos el "@"
        syscall
        imprime borra1,tamborra,bola_1,tambola_1

;-----------------------------------------------------------------------comparamos si el eje vertical llego al limite 01
        mov rax,[bola_1 + 2]	;mueve  al registro las decenas eje vertical
        and rax,mascara		;elimina bits basura
        cmp rax,48		;compara con 0
        je .revisa5  		;revisa si las unidades son igual a 1
        jne .bloque_c		;desplaza  arriba

.revisa5:
        mov rax,[bola_1 + 3]	;mueve al registro las unidades del eje vertical
        and rax,mascara		;elimina bits basura
        cmp rax,49		;comopara con 49
        je .bloque_d 		;desplaza abajo
        jne .bloque_c 		;desplaza arriba

;-----------------------------------------------------------------------


.bloque_7.2.2:            ;decrementos decenas eje horizontal

	mov rax,[bola_1 + 3]	;mueve al registro las unidades del eje vertical
        and rax,mascara		;elimina bits basura
        cmp rax,48      	;compara si decrementa unidades en la vertical
        je .bloque_7.2.2b       ;decrementa decenas vertical
        jne .bloque_7.2.2a      ;decrementa  unidades vertical

.bloque_7.2.2a:		;decremento unidades eje vertical

	mov r10,[bola_1 + 2]	;mueve al registro las decenas del eje vertical
	and r10,mascara		;elimina bits basura
        mov rax,[bola_1 + 5]    ;mueve la registro las decenas del eje horizontal
        and rax,mascara         ;elimina bits basura
        dec rax			;decremento decenas eje horizontal
        mov rbx,[bola_1 + 3]	;mueve al registro las unidades del eje vertical
        and rbx,mascara		;elimina bits basura
        dec rbx			;decremento de las unidades del eje vertical

	;se reconstruye bola_1
	mov [bola_1 +2],r10	;agregamos decenas eje vertical
        mov [bola_1 + 3 ],rbx	;agregamos unidades eje vertical
        mov r8,59
        mov [bola_1 + 4],r8	;agregamos caracter ";"
        mov [bola_1 + 5],rax	;agregamos decenas eje horizontal
	mov r8,57
        mov [bola_1 + 6],r8	;agregamos unidades eje horizontal
        mov rax,72
        mov [bola_1 + 7],rax	;agregamos caracter"H"

        mov rax,64
        mov [bola_1 + 8],rax	;agregamos el "@"
        syscall			;llamada al sistema

        imprime borra1,tamborra,bola_1,tambola_1		;imprime la bola en la pantalla

;-----------------------------------------------------------------------compara si se llego al limite vertical 01
        mov rax,[bola_1 + 2]	;mueve al registro las decenas del eje vertical
        and rax,mascara		;elimina bits basura
        cmp rax,48		;compara con 0
        je .revisa6  		;revisa si las unidades del eje vertical son igual a1
        jne .bloque_c		;desplaza  arriba

.revisa6:
        mov rax,[bola_1 + 3]	;mueve al registro las unidades del eje vertical
        and rax,mascara		;elimina bits basura
        cmp rax,49		;compara con 1
        je .bloque_d 		;desplaza abajo
        jne .bloque_c 		;desplaza arriba

;-----------------------------------------------------------------------

        ;jmp .bloque_5


.bloque_7.2.2b:		;decremento decenas vertical

        mov rax,[bola_1 + 5]    ;mueve al registro las decenas del eje horizontal
        and rax,mascara         ;elimina bits basura
        dec rax			;decremento de las decenas del eje horizontal
        mov r10,[bola_1 + 2]	;mueve al registro las decenas del eje vertical
        and r10,mascara		;elimina bits basura
        dec r10			;decremento de las decenas del eje vertical

	;se reconstruye bola_1
        mov [bola_1 +2],r10	;agregamos decenas eje vertical
	mov rbx,57
        mov [bola_1 + 3 ],rbx	;agregamos unidades eje vertical
        mov r8,59
        mov [bola_1 + 4],r8	;agregamos caracter ";"
        mov [bola_1 + 5],rax	;agregamos decenas eje horizontal
        mov r8,57
        mov [bola_1 + 6],r8	;agregamos unidades eje horizontal
        mov rax,72
        mov [bola_1 + 7],rax	;agregamos caracter "H"

	mov rax,64
        mov [bola_1 + 8],rax	;agregamos el "@"
        syscall
        imprime borra1,tamborra,bola_1,tambola_1		;imprime la bola en pantalla

;-------------------------------------------------------------------comapramos si el eje vetical llego al limite 01
        mov rax,[bola_1 + 2]	;mueve al registro las decenas del eje vertical
        and rax,mascara		;elimina bits basura
        cmp rax,48		;compara con 0
        je .revisa7  		;revisa si las unidades son igual a 1
        jne .bloque_c		;desplaza  arriba

.revisa7:
        mov rax,[bola_1 + 3]	;mueve al registro las unidades del eje vertical
        and rax,mascara		;elimina bits basura
        cmp rax,49		;compara con 1
        je .bloque_d 		;desplaza abajo
        jne .bloque_c 		;desplaza arriba

;-----------------------------------------------------------------------

        ;jmp .bloque_5



