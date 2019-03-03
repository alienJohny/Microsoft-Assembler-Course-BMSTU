sseg segment para stack 'stack'
sseg ends

dseg segment para 'data'
    shape db 5
    tmp db ?
    A db '11111'
      db '22222'
      db '33333'
      db '44444'
      db '55555'
    B db 25 dup(0)
dseg ends

cseg segment para 'stack'
    assume CS:cseg, DS:dseg, SS:sseg

; Application exit
applicationExit:
    mov ax, 4C00h
    int 21h

; Symbol stdout
print_symbol_from_DL PROC
    mov AH, 02h
    int 21h
    ret
print_symbol_from_DL ENDP

printMatrix PROC
    mov SI, 0
    loopRow:
    
        mov BX, 0
        loopCol:
            call printElement ; A[SI * 5][BX]
            cmp BX, 4h
            je breakLoopCol
            inc BX
            loop loopCol    
        breakLoopCol:
        call printNewLine
    
        cmp SI, 4h
        je breakLoopRow
        inc SI
        loop loopRow
    
    breakLoopRow:
    ret
    
    printElement PROC
        push SI
        call mulSI5
        mov DL, A[SI][BX]
        pop SI
        call print_symbol_from_DL
        ret
    printElement ENDP
    
    printNewLine PROC
        mov DL, 10d ; New line character
        call print_symbol_from_DL
        mov DL, 13d ; New line return
        call print_symbol_from_DL
        ret
    printNewLine ENDP
    
    ; AX = AL(SI) * shape(5)
    mulSI5 PROC
        mov AX, SI
        mul shape
        mov SI, AX ; AX contains the result of multiplication
        ret
    mulSI5 ENDP
printMatrix ENDP

main:
    mov AX, dseg
    mov DS, AX

    call printMatrix

    jmp applicationExit
cseg ends
end main