section .data
	asterisco db "*"
	len_ast equ $ -asterisco
	
	salto db 10,""
	leng_salto equ $ -salto

	espacio db " "
	leng_espacio equ $ -espacio

	
section .bss
	aux_1 resb 10
	aux_2 resb 10

section .text
	global _start

_start:
	;inicializamos la variable para que nos de el numero de columnas
	mov ecx, 20
	mov [aux_2], ecx
	mov ebx,01
	push ecx

linea1:
	push ecx
	push ebx ;ultimo entra primero en salir
	call imprimir_enter ; llamado a funcion
	pop ecx
	mov ebx,ecx
	push ebx

linea2:
	push ecx
	call imprimir_espacio
	pop ecx
	loop linea2	
	; inicio de la edicion
	pop ebx
	
	mov [aux_1], ebx
	push ebx
	mov ebx, [aux_1]
	
linea3:
	mov ebx, [aux_1]
	mov ecx, [aux_2]
	cmp ebx, ecx
	jz lineaSalida
	call imprimir_asterisco
	mov ebx, [aux_1]
	mov ecx, [aux_2]
	inc ebx
	mov [aux_1], ebx
	jmp linea3

lineaSalida:
	pop ebx
	pop ecx
	inc ebx ;cambiamos para invertirlo 
	loop linea1
	jmp salir

imprimir_espacio:
	mov eax, 4
	mov ebx, 1
	mov ecx, espacio 
	mov edx, leng_espacio 
	int 80H	
	ret

imprimir_asterisco:
	mov eax, 4
	mov ebx, 1
	mov ecx, asterisco
	mov edx, len_ast 
	int 80H	
	ret

imprimir_enter:
	mov eax, 4
	mov ebx, 1
	mov ecx, salto 
	mov edx, 1
	int 80H	 
	ret

salir:
	mov eax, 1
	mov ebx, 0
	int 80H