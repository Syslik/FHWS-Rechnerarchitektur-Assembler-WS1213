section .text

global main

main:
	mov eax, 3		; read input syscall
	mov ebx, 0		; stdin
	mov ecx, mymsg		; where to store the input
	mov edx, 50		; max length
	int 80h			; call it
	dec eax
	mov ecx, eax		; save length in ecx
	
	mov esi, mymsg		; start processing the input
	mov ebx,0		; array index

loop:
	mov dl,[esi+ebx]	; load a character
	cmp dl, 97		; if it's smaller than 'a'
	jl nocharacter		; 
	cmp dl, 122		; or greater than 'z'
	jg nocharacter		; take care of this character
	
	add dl, offset		; add the given offset
	cmp dl, 122		; if the "new" character is now larger than 'z'
	jl store		; 
	sub dl, 26		; rotate back to beginning of the alphabet
	jmp store		; continue with store
	
nocharacter:
	mov dl, 35		; if it was not a valid character, write '#' instead
	
store:
	mov [esi+ebx], dl	; store the character
	inc ebx			; next index
	cmp ebx, ecx		; any characters left?
	jl loop			; jump back in loop
	
	mov edx, ecx	
	mov eax, 4	
	mov ebx, 1	
	mov ecx, mymsg	
	int 80h		

ende:	
	mov eax, 1
	mov ebx, 0
	int 80h

section .data

	mymsg times 50 db 0
	offset equ 2