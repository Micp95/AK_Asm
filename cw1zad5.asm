section .text
global _start


_start:
	;Wczytanie imienia:
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
	
;Poprawa imienia - usuniecie entera
xor	esi,esi
petla:
	cmp 	esi,[dlugosc_slowo]
	je 	koniecp
	mov	eax,[slowo+esi]

	cmp	eax,0ah
	jne	koniecznak
	mov	eax,0
	mov	[slowo+esi],eax
koniecznak:
	inc	esi
jmp petla
koniecp:


	;Wczytanie koloru
	mov	eax,4
	mov	ebx,1
	mov	ecx,napis3
	mov	edx,[nap3dl]
	int	80h

	mov	eax,3
	mov	ebx,0
	mov	ecx,kolor
	mov	edx,[dlugosc_slowo]
	int	80h

	;Wyswietlanie napisu:
	mov	eax,4
	mov	ebx,1
	mov	ecx,slowo
	mov	edx,[dlugosc_slowo]
	int	80h

	mov	eax,4
	mov	ebx,1
	mov	ecx,napis2
	mov	edx,[nap2dl]
	int	80h

	mov	eax,4
	mov	ebx,1
	mov	ecx,kolor
	mov	edx,[dlugosc_slowo]
	int	80h
	
	;Przerwanie programu
	mov	eax,1
	int	80h

section .data
	napis1	db	"Podaj swoje imie:",0ah
	nap1dl	dd	$-napis1

	napis2	db	" lubi kolor "
	nap2dl	dd	$-napis2

	napis3	db	"Ulubiony kolor: ",0ah
	nap3dl	dd	$-napis3

	slowo	times 20	db 0
	dlugosc_slowo	dd	$-slowo

	kolor	times 20	dd 0
