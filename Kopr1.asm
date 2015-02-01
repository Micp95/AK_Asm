section .text
global _start

_start:

	FINIT
	mov	eax,4
	mov	[tymczas],eax
	FILD	qword [tymczas]

	mov	eax,3
	mov	[tymczas],eax
	FILD	qword	[tymczas]
	
	FDIVP	st1,st0
	FLDPI
	FMULP	st1,st0
	
	FLD	qword [r]
	FMUL	st1,st0
	FMUL	st1,st0
	FMULP	st1,st0
	

	FISTP	dword	[tymczas]

	mov	eax,[tymczas]
	add	eax,48
	mov	[tymczas],eax

	mov	eax,4
	mov	ebx,1
	mov	ecx,tymczas
	mov	edx,1
	int	80h

	mov	eax,1
	int	80h

section .data
	tymczas	dq	0
	r	dq	1.2
