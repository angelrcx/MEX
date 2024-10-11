;leeArch.asm
section .data
	rojo db 01bh, '[1;91m',0
	lrojo equ $-rojo
	verde db 01bh, '[2;92m',0
	lverde equ $-verde
	blanco db 01bh, '[97m',0
	lblanco equ $-blanco
	narch db "archa.txt", 0

section .bss
	fp resb 1 ; file pointer
	bufer resb 10 ; mini bufer  caracteres

section .text
	global _start
	_start:
	;fopen
	mov eax, 5 ; sys_open
	mov ebx, narch ;nombre archivo
	mov ecx, 0 ; 0=read,  1= write, 2=read&write
	mov edx, 0777; permiso de chmod
	int 80h

	mov [fp], eax; asigna el apuntador

	;Sys_Read from file
	mov eax, 3
	mov ebx, [fp] ; donde leeras
	mov ecx, bufer
	mov edx, 10
	int 80h

	;Sys_fclose()
	mov eax, 6
	mov ebx, [fp]
	int 80h

	mov esi, bufer
otro:
	mov al, [esi]
	cmp al, 'M'
	je pinta_verde
	cmp al, 'E'
	je pinta_blanco
	cmp al, 'X'
	je pinta_rojo
	jmp otro

pinta_verde:
	mov eax, 4
	mov ebx, 1
	mov ecx, verde
	mov edx, lverde
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, esi
	mov edx, 1
	int 80h
	inc esi
	jmp otro

pinta_rojo:
	mov eax, 4
	mov ebx, 1
	mov ecx, rojo
	mov  dx, lrojo
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, esi
	mov edx, 1
	int 80h
	inc esi
	jmp otro

pinta_blanco:
	mov eax, 4
	mov ebx, 1
	mov ecx, blanco
	mov  dx, lblanco
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, esi
	mov edx, 1
	int 80h
	inc esi
	jmp otro

	mov eax, 1
	mov ebx, 0
	int 80h
