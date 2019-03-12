; Application exit
applicationExit:
	mov ax, 4C00h
	int 21h

; Printing symbol from DL, <procedure implementation>
print_symbol_from_DL PROC
	; DOS Fn 02H: display output
	; AH = 02H
	; DL = The symbol displayed on the standard output
	mov AH, 02h
	int 21h
	ret
print_symbol_from_DL ENDP

; Printing symbol from DL, <label implementation>
print_symbol_from_DL:
	; DOS Fn 02H: display output
	; AH = 02H
	; DL = The symbol displayed on the standard output
	mov AH, 02h
	int 21h

; Read without echo
read_from_stdin:
	mov AH, 07h
	int 21h

; Simple loop
simpleLoop:
	; <some code> ...
	loop simpleLoop






