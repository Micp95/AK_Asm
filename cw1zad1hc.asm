section .text
global _start

string_to_int:
	xor	ebx,ebx
.next
	movzx	eax,byte[esi]
	inc	esi
	sub	al,'0'
	imul	ebx,10
	add	ebx,eax
	loop	.next
	mov	eax,ebx
ret

policz_wyraz:
	xor	ebx,ebx
.nextd
	movzx	eax,byte[esi]
	cmp	eax,0
	je	koniec
	inc	esi
	inc	ebx

	loop	.nextd
koniec:
	sub	ebx,1
	mov	eax,ebx
ret

_start:
	;Podanie zmiennej a
	mov	eax,4
	mov	ebx,0
	mov	ecx,podaj
	mov	edx,[podaj_dl]
	int	80h

	mov	eax,3
	mov	ebx,1
	mov	ecx,a
	mov	edx,[dlugosc_tab]
	int	80h

	;Podanie zmiennej b
	mov	eax,4
	mov	ebx,0
	mov	ecx,podaj
	mov	edx,[podaj_dl]
	int	80h

	mov	eax,3
	mov	ebx,1
	mov	ecx,b
	mov	edx,[dlugosc_tab]
	int	80h


	;Zmiana liczba a
	lea	esi,[a]
	call	policz_wyraz

	mov	ecx,eax

	lea	esi,[a]
	call	string_to_int
	mov	[aliczba],eax

	;Zmiana liczby b
	lea	esi,[b]
	call	policz_wyraz

	mov	ecx,eax

	lea	esi,[b]
	call	string_to_int
	mov	[bliczba],eax


	;Przeprowadzenie dzialania
	mov	eax,[aliczba]
	add	eax,[bliczba]
	mov	[wynik],eax




	;Zapisywanie wyniku do stringu
	xor	esi,esi
	xor	eax,eax
	mov	ax,[wynik]
petla1:
	cmp	ax,0
	je	kon_petla

	mov	ebx,10

	xor	edx,edx
	div	ebx
	add	dl,48
	mov	[wynik_tekst + esi],dl

inc	esi
jmp	petla1
kon_petla:

	mov	[dlugosc_tekst],esi
	xor	edi,edi

	mov	esi,[dlugosc_tekst]
	mov	eax,[dlugosc_tekst]
	inc	eax
	mov	[dlugosc_tekst],eax

;Odwrocenie kolejnosci cyfr
petla2:
	cmp	edi,[dlugosc_tekst] 
	je	kon_petla2

	mov	edx,[wynik_tekst+esi]
	mov	[wynik_poprawny+edi],edx

sub	esi,1
inc	edi
jmp	petla2
kon_petla2:

	;Wyswietlanie napisu
	mov	eax,4
	mov	ebx,1
	mov	ecx,napis
	mov	edx,[dlugosc_napis]
	int	80h

	;Wyswietlanie wyniku
	mov	eax,4
	mov	ebx,1
	mov	ecx,wynik_poprawny
	mov	edx,[dlugosc_tekst]
	int	80h

	;Pzrejscie do nowej linii
	mov	eax,4
	mov	ebx,1
	mov	ecx,koniecd
	mov	edx,1
	int	80h

	;Przerwanie programu
	mov	eax,1
	int	80h

section .data
	napis	db	"Winik to: "
	dlugosc_napis	dd	$-napis
	a	times	20	db	0
	b	times	20	db	0
	dlugosc_tab	dd	$-b
	aliczba	dd	0
	bliczba	dd	0

	wynik	dd	0
	wynik_tekst	times	20	db	0
	dlugosc_tekst	dd	0
	wynik_poprawny	times	20	db	0
	rozmiar	dd	20
	koniecd	db	0ah
	podaj	db	"Podaj liczbe: "
	podaj_dl	dd	$-podaj


