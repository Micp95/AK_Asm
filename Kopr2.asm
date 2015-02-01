section .text
global _start

_start:

	xor	esi,esi
_petla:
	cmp esi,10
	je	_koniec

	FINIT

	FLD	qword	[akt]
	FLD	qword	[akt]
	FMUL	st0,st1 ;x*x
	
	FLD	qword [A]

	FMULP	st1,st0 ; A*x*x

	FLD	qword [B]

	FMUL	st0,st2 ;B*x
	FADDP	st1,st0	;A*x*x + B*x
	
	FLD	qword [C]
	FSUBP	st1,st0

	FABS
	FIST	dword	[tymczas]

	mov	eax,[tymczas]
	add	eax,48
	mov	[tymczas],eax

	mov	eax,4
	mov	ebx,1
	mov	ecx,tymczas
	mov	edx,1
	int	80h
	
	mov	eax,4
	mov	ebx,1
	mov	ecx,endl
	mov	edx,1
	int	80h	

	FLD	qword	[akt]
	FLD	qword	[krok]
	FADDP	st1,st0
	FSTP	qword	[akt]

	inc	esi
jmp _petla
_koniec:

	mov	eax,1
	int	80h

section .data
	tymczas	dq	0
	akt	dq	0
	krok	dq	0.10

	A	dq	12.0
	B	dq	2.25
	C	dq	4.5
	endl	db	0ah
