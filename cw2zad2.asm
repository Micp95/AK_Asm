section .text
global _start

_start:

	;Podawanie wyrazu
	mov	eax,3
	mov	ebx,0
	mov	ecx,podane
	mov	edx,[dpodane]
	int	80h

	;Obliczenie wartoscie
	mov	al,[podane]
	sub	al,48
	mov	bl,[podane+2]
	sub	bl,48
	

	;Interpretacja znaku
	mov	cl,[podane+1]
	cmp	cl,'+'
	je	_dodawanie
	
	;Jeslie nie dodawanie to odejmowanie:
	sub	al,bl
	jmp	_koniec
_dodawanie:
	add	al,bl
_koniec:	
	add	al,48
	mov	[wynik],al
	
	mov	eax,4
	mov	ebx,1
	mov	ecx,wynik
	mov	edx,1
	int	80h	

	mov	eax,1
	int	80h

section .data

podane	times	20	db	0
dpodane	dd	$-podane

wynik	db	0

