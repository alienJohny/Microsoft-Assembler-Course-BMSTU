SSTACK	SEGMENT PARA STACK  'STACK'
		DB   64 DUP('STACK____')
SSTACK  ENDS

DSEG	SEGMENT  PARA PUBLIC 'DATA'
     CA        DB      'A'
     KA        DB      '65'
     TXT       DB      'symbol "'
     C$        DB      ?
               DB      '" has code '
    KCH1       DB      ?
    KCH2       DB      ?
               DB      10,13,'$'
    MSG0       DB      'WORK BEGIN',13,10,'$'
    MSG1       DB      'END OF WORK',13,10,'$'
DSEG	ENDS

SUBTTL         MAIN PROGRAM
PAGE
     CSEG      SEGMENT PARA PUBLIC 'CODE'
               ASSUME CS:CSEG,DS:DSEG,SS:SSTACK

     BEGIN     PROC FAR

               PUSH  DS ; LOAD IN STACK PARAGRAPH'S NUMBER OF RETURN ADDRESS
               MOV  AX,0
               PUSH  AX

     ; LOAD DATA SEGMENT ADDRESS: DS
     M1:       MOV  AX,DSEG
               MOV  DS,AX

     ; TEXT OUTPUT "WORK BEGIN"
     M2:       MOV  AH,9
               MOV  DX,OFFSET MSG0
               INT  21H

     ; STRING OUTPUT "SYMBOL 'A' HAS CODE 65"
     MA:       MOV  AL,CA
               MOV  C$,AL
                  MOV  AX,WORD PTR KA
                  MOV  WORD PTR KCH1,AX
               MOV  AH,9
               MOV DX,OFFSET TXT
               INT  21H

     ; STRING "SYMBOL 'B' HAS CODE 66"
     MB:       INC  C$
               INC  KCH1+1
               INT  21H

     ; STRING OUTPUT "SYMBOL 'C' HAS CODE 67"
     MC:       INC  C$
               INC  KCH1+1
               INT  21H

     ; STRING OUTPUT "END OF WORK"
     M3:       MOV  AH,9
               MOV  DX,OFFSET MSG1
               INT  21H

     ; RETURN TO MS DOS (DEBUGGER)
               RET
BEGIN     ENDP
CSEG      ENDS
END  BEGIN