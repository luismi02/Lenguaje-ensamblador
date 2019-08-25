%macro imprimir 2
	mov eax, 4
	mov ebx, 1
	mov ecx, %1
	mov edx, %2
	int 80h
%endmacro
section .data	
	mensaje db "Serie Fibo: ",10
	len_mensaje equ $-mensaje
	
	espacio db 10
	len_espacio equ $-espacio
	
section .bss
	numero resb 2
	cont resb 1
	aux resb 2
	i resb 2
section .text
	global _start

_start:

    imprimir mensaje, len_mensaje
	mov esi,0
	mov al, 1
	mov bl, 0
	mov [aux], al
	mov [i], bl
	bucle:
		inc esi
		mov al, [i]
		mov bl, [aux]
		mov [aux], al
		add al, bl
		
		mov [i], al
		mov cl, 10
		div cl
		add ax, '00'
		mov [numero], ax
		imprimir numero, 2
		imprimir espacio, len_espacio
		
		cmp esi, 10
		jz salir
		jmp bucle
	
	salir:
		mov eax,1
		mov ebx,0
		int 80h