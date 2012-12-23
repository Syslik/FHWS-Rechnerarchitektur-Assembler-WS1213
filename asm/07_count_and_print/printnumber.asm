	;; Berechne die Summe der Zahlen von 1 bis 25 und gib das Ergebnis auf dem
	;; Bildschirm aus. Zur Ausgabe soll der System-call (und nicht printf) verwendet werden.
	;; Die Zahl muss also in ihre Ziffern zerlegt werden und jede Ziffer wird einzeln
	;; auf dem Bildschirm ausgegeben.
	
section .text

global main

main:

	mov ebx, 25		; addiere bis 25
	mov eax, 0		; summe
	mov esi, 0		; anzahl ziffern auf 0 setzen

loop:	
	add eax, ebx		; addiere auf die summe
	dec ebx			; verringere zaehler
	jnz loop		; wenn zaehler > 0, weiter machen
	
digits:	
	cdq			; erweitern auf edx:eax
	mov ecx, 10
	div ecx			; durch 10 teilen
	push edx		; rest auf stack
	inc esi			; anzahl stellen merken in esi
	cmp eax, 0		; quotient == 0?
	jnz digits

	mov ebx, 1		; einige Register fuer Bildschirmausgabe setzen
	mov ecx, mymsg
	mov edx, 1
		
printziffer:
	pop dword [mymsg]
	add dword [mymsg], 48
	mov eax, 4		; eax wird von system call ueberschrieben
	int 80h
	dec esi
	jnz printziffer

ende:	
	mov eax, 1
	mov ebx, 0
	int 80h

section .data

	mymsg dd 0
	