section .text

extern printf
	
global main
	
main:
	push 10			; parameter for printf
	push mymsg		; the text to print
	call printf

	mov eax, 1
	mov ebx, 0
	int 80h

section .data

	mymsg db 'Hello World %d!', 0xa	; text with one parameter, %d stands for print as number
	mylen equ $-mymsg
	
