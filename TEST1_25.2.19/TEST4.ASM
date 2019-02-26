SSEG SEGMENT PARA STACK 'STACK'
	db 64 DUP(0)
SSEG ENDS

DSEG SEGMENT PARA 'DATA'
	min db 88
	max db 99
DSEG ENDS

CSEG SEGMENT PARA 'CODE'
	ASSUME CS:CSEG, DS:DSEG, SS:SSEG

print_symbol_from_DL PROC
	; DOS Fn 02H: display output
	; AH = 02H
	; DL = The symbol displayed on the standard output
	mov AH, 02h
	int 21h
	ret
print_symbol_from_DL ENDP

applicationExit:
	mov AX, 4c00h
	int 21h

printChars:
	
	call print_symbol_from_DL
	inc DL
	cmp DL, max
	jne printChars
	jmp applicationExit

; entry point
main:
	mov AX, dseg
	mov DS, AX ; Load data segment

	mov DL, min
	jmp printChars
CSEG ENDS
END main





