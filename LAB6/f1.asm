public f1

DSEG	SEGMENT PARA PUBLIC 'DATA'
	NLINE DB 10, 13, '$'
        simbols DB '0123456789ABCDEF'
        number DB ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,'$'
DSEG	ENDS

CSEG	SEGMENT PARA PUBLIC 'CODE'
		ASSUME CS:CSEG, DS:DSEG

f1		PROC NEAR
		PUSH BP
		MOV  BP, SP
		
		MOV  BX, [BP + 6]
		
		MOV CX, 16
		
		F1_1:
			SHL BX, 1
			JNC F1_2
			MOV DH, 1
			JMP F1_4
		F1_2:
			DEC CX
			JNZ F1_1
		F1_3:
			MOV DH, 0
			SHL BX, 1
			JNC F1_4
			INC DH
		F1_4:
			MOV  DL, '0'
			ADD  DL, DH
			
			MOV  AH, 2
			INT  21h
			
			DEC  CX
			JNZ  F1_3

		MOV  AH, 9
		MOV  DX, OFFSET NLINE
		INT  21H

		POP BP
		RET 4
f1		ENDP

CSEG	ENDS
END