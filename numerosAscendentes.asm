%macro imprimirData 2
    mov eax, 4
    mov ebx, 1
    mov ecx, %1 
    mov edx, %2
    int 80H 
%endmacro

%macro leerData 2
    mov eax, 3
    mov ebx, 0
    mov ecx, %1 
    mov edx, %2
    int 80H 
%endmacro


section .data
    msg db 'Ingrese 5 numeros: ',10
    lenMsj equ $-msg

    msg2 db 'Arreglo ascendente: ',10
    lenMsj2 equ $-msg2

    arreglo db 0,0,0,0,0
    lenArreglo equ $-arreglo

section .bss
    resultado resb 2
    vara resb 2
    varb resb 2
    
section .text
    global _start
    
_start:
    mov esi, arreglo ;indice fuente
    mov edi,0 ; indice destino

    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, lenMsj
    int 80H         

leer:
    mov eax,3
    mov ebx,2
    mov ecx, resultado
    mov edx, 2
    int 80H 

    mov al, [resultado]  
    sub al, '0'
    mov[esi], al
    inc esi
    inc edi

    cmp edi, lenArreglo ;cuando edi es menor
    jb leer

    mov al, 0

vuelta1:
    mov [vara], al
    cmp al, lenArreglo
    jz variable
    mov bl, 0

vuelta2:
    mov [varb], bl
    cmp bl, lenArreglo
    jz termina1

    mov cl, [arreglo + eax]
    mov dl, [arreglo + ebx]

    cmp dl, cl
    ja orden ; ja para ordenar de menor a mayor y jb de mayor a menor
    
termina2:
    mov bl, [varb]
    mov al, [vara]; recuperamos el valor de eax
    inc bl
    jmp vuelta2


termina1:
    mov al, [vara]
    inc al
    jmp vuelta1

salir:
    mov eax, 1
    mov ebx, 0
    int 80H

variable:
    imprimirData msg2,lenMsj2
    mov ecx, 0
    jmp imprimir

imprimir:
    push ecx

    mov al, [arreglo + ecx]
    add al,'0'
    mov [resultado], al
    
    mov eax, 4
    mov ebx, 1
    mov ecx, resultado
    mov edx, 2
    int 80H 

    pop ecx
 
    inc ecx

    cmp ecx, lenArreglo
    jb imprimir
    jmp salir

orden:
    mov [arreglo + eax], dl
    mov [arreglo + ebx], cl
    jmp termina2