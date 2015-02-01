section .text
global _start

_start:

	FINIT

	FLD	qword	[A]
	FLD	qword	[B]
	
	FCOMI	st0,st1
	ja	_bwieksze
	jb	_awieksze

	mov	eax,4
	mov	ebx,1
	mov	ecx,nap3
	mov	edx,[dl3]
	int	80h	

	jmp	_koniec
_awieksze:

	mov	eax,4
	mov	ebx,1
	mov	ecx,nap1
	mov	edx,[dl1]
	int	80h
	
	jmp	_koniec
_bwieksze:

	mov	eax,4
	mov	ebx,1
	mov	ecx,nap2
	mov	edx,[dl2]
	int	80h

	jmp	_koniec
_koniec:	

	mov	eax,1
	int	80h

section .data
	A	dq	30.5
	B	dq	30.5

	nap1	db	"A wieksze",0ah
	dl1	dd	$-nap1
	nap2	db	"B wieksze",0ah
	dl2	dd	$-nap2	
	nap3	db	"Rowne",0ah
	dl3	dd	$-nap3

