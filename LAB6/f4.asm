public f4

extrn f3 : near

CSEG SEGMENT PARA PUBLIC 'CODE'
		ASSUME CS:CSEG

f4		PROC NEAR
		PUSH BP
		MOV  BP, SP

		MOV  CX, [BP + 4]
		MOV  BX, [BP + 6]

		CMP  CL, 0
		JE   F4_SKIP_NEG

		MOV  AH, 2
		MOV  DL, '-'
		INT  21H
		
		NEG  BX
		
F4_SKIP_NEG:
		PUSH  BX
		PUSH  CX
		
		CALL  f3
		
		POP BP
		RET 4
f4		ENDP

CSEG ENDS
END