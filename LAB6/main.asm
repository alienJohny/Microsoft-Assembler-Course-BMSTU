extrn SCAN : near
extrn F1 : near	; unsigned bin
extrn F2 : near	; signed bin
extrn F3 : near	; unsigned dec
extrn F4 : near	; signed dec
extrn F5 : near	; unsigned hex
extrn F6 : near	; signed hex

sstack segment para stack 'stack'
    db 64 dup(0)
sstack	ends

dseg segment para public 'DATA'
    F DW F1, F2, F3, F4, F5, F6
    X DW 5
		
    MENU db '    MENU', 10, 13
         db '0. Print menu', 10, 13
         db '1. Input number', 10, 13
         db '2. Num as unsigned bin', 10, 13
         db '3. Num as signed bin', 10, 13
         db '4. Num as unsigned dec', 10, 13
         db '5. Num as signed dec', 10, 13
         db '6. Num as unsigned hex', 10, 13
         db '7. Num as signed hex', 10, 13
         db '8. Exit', 10, 13, '$'

    ENT db '> $'
    NLINE db 10, 13, '$'
dseg ends

cseg segment para public 'CODE'
    ASSUME CS:cseg, DS:dseg, SS:sstack
BEGIN:
    mov  AX, dseg
    mov  DS, AX
PMENU:
    mov  AH, 09h
    mov  DX, offset MENU
    int  21H

PRINT_ENT:
    mov  AH, 09h
    mov  DX, offset ENT
    int  21H
SCAN_CHOICE:
    mov  AH, 08h ;CHARACTER INPUT WITHOUT ECHO, CHAR IN AL
    int  21H

    cmp  AL, '0'
    jb   SCAN_CHOICE
    cmp  AL, '9'
    ja   SCAN_CHOICE

    mov  BL, AL
    xor  BH, BH

    mov  AH, 2
    mov  DL, AL
    int  21H

    mov  AH, 9
    mov  DX, offset NLINE
    int  21H
PROCESS:
    sub  BX, '0'
        
    cmp  BX, 8
    jae  EXIT
        
    cmp  BX, 0
    je   PMENU

    cmp  BX, 1
    je   INPUT_NUMBER

    sub  BX, 2
    SHL  BX, 1

    push X
    push SI
    call F[BX]
    
    jmp  PRINT_ENT

INPUT_NUMBER:
    call SCAN

    mov  X, AX
    mov  SI, DX

    jmp  PRINT_ENT

EXIT:
    mov  AH, 4CH
    xor  AL, AL
    int  21H

cseg ends
end BEGIN