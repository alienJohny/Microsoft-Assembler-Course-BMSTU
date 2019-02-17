# LAB2
## Задание 1
Подготовить приведенную ниже программу к отладке: <br />
а) скопировать текст программы в файл KR_1.ASM; <br />
б) выполнить трансляцию: `MASM /Zi KR_1.ASM,,;` <br />
в) выполнить компоновку: `LINK /CO KR_1.OBJ;`  <br />
```
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
```

## Задание 3

**шаг 1** <br />
Установить командой W слежение: <br />  
а) за переменной  С$, <br />
* `command...`

б) за выражениями KCH1-'0', KCH2-'0',<br />
* `W? KCH1-'0',d // Наблюдение в десятичном виде`  <br />
* `W? KCH2-'0',d // Наблюдение в десятичном виде`

в) за верхней частью стека (двумя способами). <br />
* `WW SS:SP // Вторая W-двойное слово, следим за двумя верхними байтами стека`

Команды установок записать в соответствующих пунктах a), б), в) задания 3. <br />
Проследить за их изменениями по шагам. <br />
* `command...`

Удалить точки слежения. <br />
* `command...`


**шаг 2** <br />
Установить условные точки останова так, чтобы останов был: <br />
a) при изменении переменных KCH1 и KCH2; <br />
* `TP? KCH1`

* `TP? KCH2`

б) когда переменная C$ имеет значение 'B'. <br />
* `WP? C$=='B'`

Проверить останов при этих условиях.<br />

**шаг 3** <br />
Установить безусловные точки останова на строках программы с метками MB,  MC и M3. <br />
* `command...`

Обеспечить в них вывод в окно диалога байтов из диапазона от TXT до MSG0  и продолжение  выполнения программы с задержкой в 3 секунды. Перед вводом команд установить вывод информации в окно диалога. <br />
* `D TXT MSG0`
* `BP MB "D TXT MSG0; ::::::; E"`
* `BP MC "D TXT MSG0; ::::::; E"`
* `BP M3 "D TXT MSG0; ::::::; E"`

