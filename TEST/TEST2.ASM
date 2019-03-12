SSEG SEGMENT PARA STACK 'STACK'
	db 64 dup(0)
SSEG ENDS

DSEG SEGMENT PARA 'DATA'
	A db "DCAB"
DSEG ENDS

CSEG SEGMENT PARA 'CODE'
	ASSUME CS:CSEG, DS:DSEG, SS:SSEG

printMinSymbol PROC
	mov DL, A[DI]
	mov AH, 02h
	int 21h
	ret
printMinSymbol ENDP

applicationExit:
	mov ax, 4C00h
	int 21h

setNewMinValue:
	mov DI, SI ; found new min value
	jmp continue

findMin:
	mov AH, A[DI] ; load min value
	cmp A[SI], AH
	jle setNewMinValue
continue:
	inc SI
	loop findMin

	; We get here after CX clears
	call printMinSymbol
	jmp applicationExit

main:
	mov AX, DSEG
	mov DS, AX

	mov SI, 0 ; counter
	mov DI, 0 ; min value index
	mov CX, 4d
	
	jmp findMin
CSEG ENDS
END main