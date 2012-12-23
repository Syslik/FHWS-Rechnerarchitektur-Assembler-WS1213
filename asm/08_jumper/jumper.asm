	;;
	;; Bestimme die Anzahl der möglichen Sprünge in einem Array A. Begonnen wird bei k=0, der nächste Index ergibt sich aus
	;; k' = k+A[k]. Dies bezeichnen wir als einen Sprung. Wenn k den Gültigkeitsbereich für den Array Index verlässt, soll die Anzahl 
	;; der bisherigen Sprünge zurückgegeben werden. Wenn man in eine Schleife gerät, soll als Ergebnis -1 ausgegeben werden.
	;; 
	
section .text

extern printf
	
global main

main:
	mov edx, 0		; Anzahl Spruenge
	mov esi, buffer
	mov edi, visited
	mov ebx, 0

loop:
	cmp ebx, 0		; ist index < 0
	jl print		; dann Ausgabe
	cmp ebx, len		; ist index >= len
	jge print		; dann Ausgabe
	movzx ecx, byte [edi+ebx] ; lade byte und loesche obere Bits in ecx (movzx = mov with zero extend)
	cmp ecx, 0		; waren wir hier schon mal?
	jnz infinity		; Schleife gefunden, Ende
	inc edx			; wir machen einen Schritt
	movsx ecx, byte [esi+ebx] ; movsz = mov with signed extend
	mov byte [edi+ebx], 1	; Stelle als besucht markieren
	add ebx, ecx
	jmp loop
	
infinity:
	mov edx, -1
	
print:
	push edx
	push output
	call printf
	add esp, 8

ende:	
	mov eax, 1
	mov ebx, 0
	int 80h

section .data
	output db 'Ergebnis %d', 0xa, 0x0
	;buffer db 2, 3, -1, 2, -1 ; ergebnis = 5
	buffer db 2, 3, -1, 2, -2 ;ergebnis -1
	len equ $-buffer
	visited db 0, 0, 0, 0, 0 
