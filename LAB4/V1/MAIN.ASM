SSEG SEGMENT PARA STACK 'STACK'
	db 100 dup(0)
SSEG ENDS

DSEGA SEGMENT para public 'DATA'
	A db 'A'
DSEGA ENDS

DSEGB SEGMENT para public 'DATA'
	B db 'B'
DSEGB ENDS

CSEG SEGMENT para public 'CODE'
	assume CS:CSEG, DS:DSEGA, SS:SSEG	

ExitProcess:
	mov ax, 4C00h
	int 21h

main:
	mov AX, DSEGA
	MOV DS, AX
	
	jmp ExitProcess
CSEG ENDS
END main