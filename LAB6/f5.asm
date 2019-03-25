public f5

DSEG	SEGMENT PARA PUBLIC 'DATA'
	NLINE	DB	10, 13, '$'
        simbols DB '0123456789ABCDEF'
        number DB ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,'$'
DSEG	ENDS

CSEG	SEGMENT PARA PUBLIC 'CODE'
		ASSUME CS:CSEG, DS:DSEG

f5 PROC NEAR
		PUSH BP
        push si
		MOV  BP, SP

        mov  dx, [bp + 8]
		mov si,16
        mov cl,4

		F5_1:
			mov  ax, 15
			and  ax, dx
            
            dec si
            mov bx, offset simbols
            mov al, al
            xlat
            mov bx, offset number
            mov [bx+si], al
           
			shr  dx, cl
			jne  F5_1
            
            mov dx, offset number
            add dx,si
            mov ah,9
            int 21h
            
	mov  ah, 9
	mov  dx, offset nline
	int  21h
	
    pop si
	pop  bp
	ret  4
f5 ENDP

CSEG	ENDS
END