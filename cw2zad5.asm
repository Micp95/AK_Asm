section .text
global _start

_start:

	mov	eax,4
	mov	ebx,1
	mov	ecx,napis
	mov	edx,[dnapis]
	int	80h

	;Podawanie wyrazu
	mov	eax,3
	mov	ebx,0
	mov	ecx,a
	mov	edx,2
	int	80h

	mov	eax,3
	mov	ebx,0
	mov	ecx,b
	mov	edx,2
	int	80h
	
	
	mov	al,[a]
	mov	bl,[b]
	cmp	al,bl
	jb	_bwieksze
	je	_takiesame
	mov	[wieksza],al
jmp	_koniec
_bwieksze:
	mov	[wieksza],bl
_koniec:
	mov	eax,4
	mov	ebx,1
	mov	ecx,wieksza
	mov	edx,1
	int	80h

jmp	_wyjscie
_takiesame:

	mov	eax,4
	mov	ebx,1
	mov	ecx,rownen
	mov	edx,1
	int	80h


_wyjscie:
	mov	eax,1
	int	80h

section .data

napis	db	"Podaj 2 liczby:",0ah
dnapis	dd	$-napis

a	times	2	db	0
b	times	2	db	0
wieksza	dd	0

rownen	db	"Podane liczby sa rowne",0ah
drownen	dd	$-rownen
