// firmware del calcolatore
_zero:
	nop

	// inizializza 256 byte di pila
	mov $00FF, %sp

	// salta all'entrata _main
	jmp _main

// sottoprogrammi di ingresso / uscita
_in_char:
	// leggi l'RSR
	in $0000
	// FI è il bit 0
	and $01, %al
	// se FI è a 0, riprova
	jz _in_char
	// FI è a 1, leggi l'RBR
	in $0001
	ret

_out_char:
	push %al
	// leggi il TSR
	in $0002
	// FO è il bit 4
	and $10, %al
	// se FO è a 0, riprova
	jz _out_char
	// FI è a 1, scrivi in TBR
	pop %al
	out $0003
	ret

// entrata del programma principale 
_main:
	nop
	

	hlt
