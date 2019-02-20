SSEG SEGMENT PARA STACK 'STACK'
	db 64 DUP(0)
SSEG ENDS

DSEG SEGMENT PARA 'DATA'
	X db 'A'
DSEG ENDS

CSEG SEGMENT PARA 'CODE'
	ASSUME CS:CSEG, DS:DSEG, SS:SSEG

; entry point
main:
	mov AX, DSEG
	mov DS, AX
	
	; printing chars from 'A' to 'E'
	mov CX, 5
	jmp printASCII

printASCII:
	mov DL, X
	call print_symbol_from_DL
	inc X
	loop printASCII
	jmp ExitProcess

print_symbol_from_DL PROC
	; DOS Fn 02H: display output
	; AH = 02H
	; DL = The symbol displayed on the standard output
	mov AH, 02h
	int 21h
	ret
print_symbol_from_DL ENDP

; Exit application
ExitProcess:
	mov AH, 4CH
	INT 21H

CSEG ENDS
END MAIN