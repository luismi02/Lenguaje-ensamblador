%macro escribir 2
    mov eax, 4
    mov ebx, 1 
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

section .data
	msjcociente db 10,'cociente',0xa
	lencociente equ $-msjcociente

	msjresiduo db 10,'residuo',0xa
	lenresiduo equ $-msjresiduo
    
	ingresoa db "Primer numero",10,0
	len_a equ $-ingresoa

	ingresob db 10,"Segundo numero",10,0
	len_b equ $-ingresob

	resultado db 10,'Resultado xxxx',0xa
	lenresl equ $-resultado

    archivo db "/home/luis/Escritorio/Lenguaje ensamblador/archivo.txt",0
	

section .bss
    
    cociente resb 1
	residuo resb 1
    idarchivo resd 1
	a resb 1
	b resb 1
	respuesta resb 2

section .text
	global _start

_start:

    escribir ingresoa,len_a
 
	; Obtenemos el numero 1
	mov eax, 3
	mov ebx, 0
	mov ecx, a
	mov edx, 2
	int 80h
 
    escribir ingresob,len_b
 
	; Obtenemos el numero 2
	mov eax, 3
	mov ebx, 0
	mov ecx, b
	mov edx, 2
	int 80h

    mov eax,8
    mov ebx, archivo
    mov ecx,1
    mov edx,200h
    int 80h

        test eax, eax
    jz salir

    mov dword[idarchivo],eax

    multiplicacion:
        mov ax,[a]
        mov bx,[b]
        sub ax,'0';--> Convierte de cadena a numero
        sub bx,'0';--> Convierte de cadena a numero
        mul bx
        add ax,'0'

        mov [respuesta],ax
        mov[resultado+11],dword '*:'
        
        mov eax,4
        mov ebx,[idarchivo]
        mov ecx,resultado
        mov edx,13
        int 80h
        
            ; Se envia al archivo el texto
        mov eax, 4
        mov ebx, [idarchivo]
        mov ecx, respuesta
        mov edx, 1
        int 80h

        jmp restar


    restar: 

        mov ax,[a]
        mov bx,[b]
        sub ax,'0';--> Convierte de cadena a numero
        sub bx,'0'
        sub ax,bx
        add ax,'0'

        mov [respuesta],ax
        mov[resultado+11],dword '-:'
        
        mov eax,4
        mov ebx,[idarchivo]
        mov ecx,resultado
        mov edx,13
        int 80h

                    ; Se envia al archivo el texto
        mov eax, 4
        mov ebx, [idarchivo]
        mov ecx, respuesta
        mov edx, 1
        int 80h
    
    sumar:
        mov ax,[a]
        mov bx,[b]
        sub ax,'0';--> Convierte de cadena a numero
        sub bx,'0'
        add ax,bx
        add ax,'0'

        mov [respuesta],ax
        mov[resultado+11],dword '+:'

        mov eax,4
        mov ebx,[idarchivo]
        mov ecx,resultado
        mov edx,13
        int 80h

        mov eax, 4
        mov ebx, [idarchivo]
        mov ecx, respuesta
        mov edx, 1
        int 80h


salir: 
        mov eax,1
        mov ebx,0
        int 80h