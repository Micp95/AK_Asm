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
	mov	edx,1
	int	80h

	mov	eax,[podane]
	sub	eax,48
	mov	[podane],eax	
	
	xor	esi,esi
_linijki:
	cmp	esi,[podane]
	jae	_wyjscie

	inc	esi

	;Zachowanie i podmiana rejestru esi - licznik pustych znakow
	xor	edi,edi
	mov	eax,esi
	push	rsi
	mov	esi,[podane]
	sub	esi,eax

	_puste:	;Rysowanie pustych znakow
	cmp	edi,esi
	je	_kpuste
		mov	eax,4
		mov	ebx,1
		mov	ecx,pusty
		mov	edx,1
		int	80h
		
		inc	edi
		jmp	_puste
	_kpuste:	
	pop rsi ; Przywrucenie esi


	xor	edi,edi
	_znaki: ;Rysowanie znakow
	cmp	edi,esi
	je	_kznaki
	
		mov	eax,4
		mov	ebx,1
		mov	ecx,znak
		mov	edx,1
		int	80h
		
		inc	edi
	jmp	_znaki
	_kznaki:

	mov	eax,4
	mov	ebx,1
	mov	ecx,linijka
	mov	edx,1
	int	80h
	
	jmp	_linijki

_wyjscie:
	
	mov	eax,3 ; Wylapanie smieci ze strumienia - min podany enter 
	mov	ebx,0
	mov	ecx,smiec
	mov	edx,[dlugosc]
	int	80h

	mov	eax,1
	int	80h

section .data

podane	db	0
smiec	times	100	db	0
dlugosc	dd	$-smiec

napis	db	"Podaj wysokosc",0ah
dnapis	dd	$-napis

znak	db	'o'
linijka	db	0ah
pusty	db	' '
