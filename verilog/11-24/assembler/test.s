_main:
	nop

	mov $00, %al
	mov $0000, %dp

_print:
	mov %al, (%dp)
	
	add $1, %al
	inc %dp
	
	cmp $10, %al
	jne _print

	hlt
