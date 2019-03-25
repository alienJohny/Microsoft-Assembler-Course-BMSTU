public f6

extrn f5 : near

CSEG SEGMENT PARA PUBLIC 'CODE'
		ASSUME CS:CSEG

f6 PROC NEAR
		PUSH BP
		MOV  BP, SP
		
		MOV  CX, [BP + 4]
		MOV  BX, [BP + 6]
		
		CMP  CL, 0
		JE   F6_SKIP_NEG
		
		MOV  AH, 2
		MOV  DL, '-'
		INT  21H
		
		NEG  BX
		
F6_SKIP_NEG:
		PUSH  BX
		PUSH  CX
		
		CALL  f5
		
		POP BP
		RET 4
f6 ENDP

CSEG ENDS
END