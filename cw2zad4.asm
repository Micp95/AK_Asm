section .text
global _start

_start:

	mov	eax,4
	mov	ebx,1
	mov	ecx,napis
	mov	edx,[dnapis]
	int	80h

_petla:
	mov	eax,3
	mov	ebx,0
	mov	ecx,a
	mov	edx,2
	int	80h
	
	mov	al,[a]
	cmp	al,'k'
	je	_wyjscie
	jmp _petla

_wyjscie:
	mov	eax,4
	mov	ebx,1
	mov	ecx,koniec
	mov	edx,[dkoniec]	
	int	80h

	mov	eax,1
	int	80h

section .data

napis	db	"Podaj k:",0ah
dnapis	dd	$-napis

a	times	2	db	0

koniec	db	"Koniec",0ah
dkoniec	dd	$-koniec
