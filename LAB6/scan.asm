PUBLIC SCAN

DSEG	SEGMENT PARA PUBLIC 'DATA'
		ENT	DB	'>> $'
		NLINE	DB	10, 13, '$'
DSEG	ENDS

CSEG	SEGMENT PARA PUBLIC 'CODE'
		ASSUME CS:CSEG
		
SCAN PROC NEAR
	MOV  AH, 9
	MOV  DX, OFFSET ENT
	INT  21H
	
	XOR  BX, BX
	XOR  CX, CX
	
	INPUT_LOOP:
		MOV  AH, 8
		INT  21H
		
		CMP  AL, 13
		JE   INPUT_END
		
		CMP  AL, 45
		JE   NEG_NUM
		
		CMP  AL, '0'
		JB   INPUT_LOOP
		CMP  AL, '9'
		JA   INPUT_LOOP
		
		MOV  AH, 2
		MOV  DL, AL
		INT  21H
		
		MOV  CL, AL
		MOV  AX, BX
		
		SHL  AX, 1
		SHL  AX, 1
		ADD  AX, BX
		SHL  AX, 1
		
		MOV  BL, CL
		SUB  BL, '0'
		XOR  BH, BH
		ADD  BX, AX
		
		JMP  INPUT_LOOP
		
	NEG_NUM:
		MOV  AH, 2
		MOV  DL, AL
		INT  21H
		
		MOV  CH, 1

		JMP  INPUT_LOOP
		
	INPUT_END:
		MOV  AH, 9
		MOV  DX, OFFSET NLINE
		INT  21H
		
		CMP  CH, 1
		JNE  SCAN_END
		
		NEG  BX
		
	SCAN_END:
		XOR  DH, DH
		MOV  DL, CH
		MOV  AX, BX
		
		RET
		
SCAN ENDP

CSEG	ENDS
END