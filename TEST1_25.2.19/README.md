# Подготовка к контрольной работе №1
**Образование физического адреса**
Память представляет собой линейную последовательность байтов, поделенную на параграфы.
***Параграфы*** - последовательности из 16 байт, у первого из которых адрес кратен 16.
Параграф является минимально возможным x86 сегментом.
Полный физический адрес составляется из номера сегмента и смещения относительно
начала этого сегмента ("байт 5 сегмента 3").
```
<full address> = <segment number> * <segment size> + <bias (or offset)>
```

***
**Структура одномодульной программы на 16 битном Microsoft Assembler x8086**
```
; ОПИСАНИЕ СЕГМЕНТА СТЕКА
SEGMENT_STACK SEGMENT PARA STACK 'STACK'
    DB 64 DUP('STACK')
SEGMENT_STACK ENDS

; ОПИСАНИЕ СЕГМЕНТА ДАННЫХ
SEGMEMT_DATA SEGMENT PARA 'DATA'
    S DW 42
SEGMENT_DATA ENDS

; ОПИСАНИЕ СЕГМЕНТА КОДА
SEGMENT_CODE SEGMENT PARA 'CODE'
    ASSUME CS:SEGMENT_CODE,
           DS:SEGMENT_DATA,
           SS:SEGMENT_STACK

PROGSTART:
    MOV AX, SEGMENT_DATA
    MOV DS, AX
    ; WRITE SOME CODE HERE...
    MOV AH, 4CH
    INT 21H
SEGMENT_CODE ENDS
END PROGSTART
```

Повторные описания сегментов обынно используются, когда один и тот же сегмент описывается в нескольких модулях, или чтобы расположить данные рядом с операциями между ними.

## Возможные структуры кодового сегмента
```
<CODE_SEGMENT_NAME> SEGMENT [<ALIGNING_TYPE>] ['CODE']
    ASSUME CS:CODE_SEGMENT_NAME,
           DS:DATA_SEGMENT_NAME,
           SS:STACK_SEGMENT_NAME
           
    <PROC1> PROC [FAR|NEAR]
        CALL <PROC2>
        CALL <PROC3>
    <PROC1> ENDP
    
    <PROC2> PROC
        ; SOME CODE HERE...
        RET
    <PROC2> ENDP
    
    <PROC3> PROC FAR
        ; SOME CODE HERE...
        RET ; WILL BE CHANGED TO RETF AUTOMATICLY
    <PROC3> ENDP
    
    <ENTRY_POINT_LABEL>:
        ; SOME CODE HERE...
    
<SEGMENT_CODE_NAME> ENDS
END <ENTRY_POINT_LABEL>
```

**FAR** - подпрограмма дальнего вызова (можно вызывать из других сегментов).
**NEAR** - ближнего (вызов только из этого сегмента).
**RET** - дальнего вызова.

`<ALIGNMENT TYPE>` может быть **PARA**, **BYTE**, **WORD**, **PAGE**.
Указывает, чему должны быть кратны адрес начала и конца сегмента. По умолчанию **PARA**.
