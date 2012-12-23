
section .text

global main

main:

	mov eax, 15		; addiere 1 bis 15
	mov ebx, 0		; summe
loop:	
	add ebx, eax		; addiere auf die summe
	dec eax			; verringere zaehler
	jnz loop		; wenn zaehler > 0, weiter machen

ende:	
	mov eax, 1		; ebx enthaelt Ergebnis als Exit-Code, Anzeigen mit echo $?
	int 80h

	