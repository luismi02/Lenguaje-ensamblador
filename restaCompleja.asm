%macro escribir 2

	mov eax,4
	mov ebx,1
	mov ecx,%1
	mov edx,%2
	int 80h
%endmacro
section .data
	msj db 'La resta es:'
	len equ $-msj

	n1 db '500'
	n2 db '250'

	suma db '  '

section .text

global _start
_start:
 
	mov ecx, 3		;numero de operaciones
	mov esi, 2		;posicion del numero
	clc			;permite poner la bandera del carry en 0(cf=0)

operacion_suma:

	mov al, [n1 + esi]
	sbb al, [n2 + esi]	; suma normal + carry(esta en binario)
	
	aas;       		; toda operacion que conlleve acarreo hay que ajustar, aaa suma 6 digitos a la parte baja del registro
				; y un digito a la parte alta  

	pushf			;push flag--->envia el estado de las banderas a la pila

	or al,30h		; coveritirde un caracter a un decimal(similar a sub al, '0'
 	popf			; restaura el estado de las banderas almacenadas temporalmente en la pila hacia las banderas	
	
	mov [suma + esi], al	
	dec esi
	loop operacion_suma
	escribir msj, len
	escribir suma, 3

	mov eax, 1
	int 80h