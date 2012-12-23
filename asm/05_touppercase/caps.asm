	;;
	;; Das Programm soll eine Eingabe vom Nutzer entgegen nehmen und 
	;; alle Kleinbuchstaben in der Eingabe in Groﬂbuchstaben wandeln.
	;; Alle sonstigen Zeichen soll unver‰ndert bleiben. 
	;; Der Text soll am Ende wieder auf dem Bildschirm ausgegeben werden. 
	;; 
section .text

global main

main:
	mov eax, 3		; read input syscall
	mov ebx, 0		; stdin
	mov ecx, mymsg		; where to store the input
	mov edx, 50		; max length
	int 80h			; call it
	mov ecx, eax		; save length in ecx
	
	mov esi, mymsg		; start processing the input
	mov ebx, 0		; array index

loop:
	mov dl,[esi+ebx]	; hole ein zeichen
	cmp dl, 97		; vergleiche mit 'a'
	jl continue		; wenn kleiner, dann groﬂbuchstabe
	cmp dl, 122
	jg continue
	sub dl, 32		; mache daraus einen groﬂbuchstaben
	mov [esi+ebx], dl	; schreibe das byte wieder
		
continue:	
	inc ebx			; index++
	cmp ebx, ecx		; alle zeichen?
	jne loop		; naechste iteration
	
print:
	mov edx, ecx		; laenge muss in edx stehen
	mov eax, 4		; output syscall
	mov ebx, 1		; stdout
	mov ecx, mymsg		; pointer to output
	int 80h			; call 

ende:	
	mov eax, 1
	mov ebx, 0
	int 80h

section .data

	mymsg times 50 db 0
	len equ $-mymsg
	