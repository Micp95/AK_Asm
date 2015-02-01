section .text
global _start

_start:

	FINIT

	FLD	qword	[A]
	FLD	qword	[B]
	FMULP	st1,st0 ;x*x
	FLD	qword	[C]
	FMULP	st1,st0

	FLD	qword	[B]
	FLD	qword	[D]
	FDIVP	st1,st0

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

	mov	eax,1
	int	80h

section .data
	tymczas	dq	0

	A	dq	4.5
	B	dq	3.0
	C	dq	0.5
	D	dq	0.2

	endl	db	0ah
