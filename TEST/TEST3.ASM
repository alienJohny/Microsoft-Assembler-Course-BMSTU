; Author: Artur Yumaev, IU7-45B
; Microsoft Assembler x86 16 bit
; Program founds a first symbol,
; which greater than a second

sseg segment para stack 'stack'
	db 64 dup(0)
sseg ends

dseg segment para 'data'
	A db "PSP" ; Value from the leaked task
	ErrorMessage db "The second element is maximum$"
dseg ends

cseg segment para 'code'
	assume CS:cseg, DS:dseg, SS:sseg

applicationExit:
	mov AX, 4c00h
	int 21h

elementFound:
	mov DL, A[SI]
	mov AH, 02h ; Printing
	int 21h
	jmp applicationExit

; Find first greater than a second element
findFGS:
	cmp A[SI], DH
	jg elementFound
	inc SI
	loop findFGS

	; Element not found, print ErrorMessage
	mov AH, 09h
	mov DX, offset ErrorMessage
	int 21h
	jmp applicationExit

; <<< Entry point, program starts here <<<
main:
	mov AX, dseg
	mov DS, AX ; Load data segment

	mov CX, 3  ; Initialize loop register
	mov SI, 0  ; Initialize indexing register
	mov DI, 0  ; Supporting thing

	; Save second element. 'S' has a 53h ASCII code
	mov DH, A[1]

	jmp findFGS
cseg ends
end main