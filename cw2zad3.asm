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
	mov	ecx,podane
	mov	edx,[dpodane]
	int	80h

	xor	esi,esi

	mov	al,0ah
	mov	dl,'a'
	xor	ebx,ebx
_petla:
	cmp	[podane+esi],al
	je	_koniec
	inc	esi

	cmp	[podane+esi-1],dl
	jne	_petla

	inc	ebx

jmp _petla
_koniec:

	cmp	ebx,9
	jnbe	_blad

	add	ebx,48
	mov	[licznik],ebx


	mov	eax,4
	mov	ebx,1
	mov	ecx,licznik
	mov	edx,1
	int	80h
	
jmp	_wyjscie
_blad:
	mov	eax,4
	mov	ebx,1
	mov	ecx,blad
	mov	edx,[dblad]
	int	80h
	
_wyjscie:

	mov	eax,1
	int	80h

section .data

podane	times	100	db	0
dpodane	dd	$-podane

licznik	db	0

napis	db	"Podaj wyraz (max 9 liter)",0ah
dnapis	dd	$-napis

blad	db	"Podany wyraz jest za dlugi! ",0ah
dblad	dd	$-blad
