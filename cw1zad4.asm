section .text
global _start

policz_wyraz:
	xor	ebx,ebx
.next
	movzx	eax,byte[esi]
	cmp	eax,0
	je	koniec
	inc	esi
	inc	ebx
	
	loop .next
koniec:
	sub	ebx,1
	mov	eax,ebx
ret



_start:
	;Wczytanie slowa:
	mov	eax,4
	mov	ebx,1
	mov	ecx,napis1
	mov	edx,[nap1dl]
	int	80h

	mov	eax,3
	mov	ebx,0
	mov	ecx,slowo
	mov	edx,[dlugosc_slowo]
	int	80h

	lea	esi,[slowo]
	call	policz_wyraz
	mov	[dlugosc],eax
	
	xor	esi,esi
petla:
	cmp	esi,[dlugosc]
	je	koniecp
	mov	eax,[slowo+esi]
	add	eax,4
	
	mov	[zaszyfrowane+esi],eax
	inc	esi
jmp	petla
koniecp:

	mov	eax,4
	mov	ebx,1
	mov	ecx,zaszyfrowane
	mov	edx,[dlugosc]
	int	80h
	
	;Przerwanie programu
	mov	eax,1
	int	80h

section .data
	napis1	db	"Podaj swoje imie:",0ah
	nap1dl dd	$-napis1	

	slowo	times 20	db 0
	dlugosc_slowo	dd	$-slowo

	zaszyfrowane	times 20	dd 0
	dlugosc	dd	0
