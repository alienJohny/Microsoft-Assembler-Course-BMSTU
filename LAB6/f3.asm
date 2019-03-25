public f3

DSEG	SEGMENT PARA PUBLIC 'DATA'
	NLINE	DB	10, 13, '$'
        simbols DB '0123456789ABCDEF'
        number DB ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,'$'
DSEG	ENDS

CSEG	SEGMENT PARA PUBLIC 'CODE'
		ASSUME CS:CSEG, DS:DSEG

f3		PROC NEAR
		PUSH BP
		MOV	 BP, SP
		
		MOV	 AX, [BP + 6]
		
        F3_1:
            XOR CX, CX
            MOV BX, 10
        F3_2:
            XOR DX,DX
            DIV BX
            ADD DX, '0'
            PUSH DX
            INC CX
            CMP AX,0
            JNE F3_2

            MOV AH,2
        F3_3:
            POP DX
            INT 21h
            LOOP F3_3
		
		MOV  AH, 9
		MOV  DX, OFFSET NLINE
		INT  21H
		
		POP BP
		RET 4
f3		ENDP

CSEG	ENDS
END