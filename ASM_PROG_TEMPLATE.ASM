; ======= Build =======
; MASM /Zi MAIN.ASM,,,;
; LINK /CO MAIN.OBJ,,;
; CV.EXE MAIN.EXE
; =====================

SSEG SEGMENT PARA STACK 'STACK'
	db 64 DUP(0)
SSEG ENDS

DSEG SEGMENT PARA 'DATA'
	; Some data
DSEG ENDS

CSEG SEGMENT PARA 'CODE'
	ASSUME CS:CSEG, DS:DSEG, SS:SSEG

; Exit application
ExitProcess:
	mov AH, 4CH
	INT 21H

; entry point
main:
	; Some code ...
	jmp ExitProcess

CSEG ENDS
END main











