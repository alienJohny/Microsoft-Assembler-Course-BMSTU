; ======= Build =======
; MASM /Zi MAIN.ASM,,,;
; LINK /CO MAIN.OBJ,,;
; CV.EXE MAIN.EXE
; =====================

sseg segment para stack 'stack'
	db 64 dup(0)
sseg ends

dseg segment para 'data'
	;Some data
dseg ends

cseg segment para 'code'
	assume CS:cseg, DS:dseg, SS:sseg

;Exit application
ExitProcess:
	mov AH, 4Ch
	int 21h

;Entry point
main:
	;Some code ...

	jmp ExitProcess
cseg ends
end main