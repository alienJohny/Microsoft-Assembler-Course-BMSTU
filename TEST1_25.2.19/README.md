<h1><a id="____1_0"></a>Подготовка к контрольной работе №1</h1>
<p><strong>Образование физического адреса</strong><br>
Память представляет собой линейную последовательность байтов, поделенную на параграфы.<br>
<strong><em>Параграфы</em></strong> - последовательности из 16 байт, у первого из которых адрес кратен 16.<br>
Параграф является минимально возможным x86 сегментом.<br>
Полный физический адрес составляется из номера сегмента и смещения относительно<br>
начала этого сегмента (“байт 5 сегмента 3”).</p>
<pre><code>&lt;full address&gt; = &lt;segment number&gt; * &lt;segment size&gt; + &lt;bias (or offset)&gt;
</code></pre>
<hr>
<p><strong>Структура одномодульной программы на 16 битном Microsoft Assembler x8086</strong></p>
<pre><code>; ОПИСАНИЕ СЕГМЕНТА СТЕКА
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
</code></pre>
<p>Повторные описания сегментов обынно используются, когда один и тот же сегмент описывается в нескольких модулях, или чтобы расположить данные рядом с операциями между ними.</p>
<h2><a id="____42"></a>Возможные структуры кодового сегмента</h2>
<pre><code>&lt;CODE_SEGMENT_NAME&gt; SEGMENT [&lt;ALIGNING_TYPE&gt;] ['CODE']
    ASSUME CS:CODE_SEGMENT_NAME,
           DS:DATA_SEGMENT_NAME,
           SS:STACK_SEGMENT_NAME
           
    &lt;PROC1&gt; PROC [FAR|NEAR]
        CALL &lt;PROC2&gt;
        CALL &lt;PROC3&gt;
    &lt;PROC1&gt; ENDP
    
    &lt;PROC2&gt; PROC
        ; SOME CODE HERE...
        RET
    &lt;PROC2&gt; ENDP
    
    &lt;PROC3&gt; PROC FAR
        ; SOME CODE HERE...
        RET ; WILL BE CHANGED TO RETF AUTOMATICLY
    &lt;PROC3&gt; ENDP
    
    &lt;ENTRY_POINT_LABEL&gt;:
        ; SOME CODE HERE...
    
&lt;SEGMENT_CODE_NAME&gt; ENDS
END &lt;ENTRY_POINT_LABEL&gt;
</code></pre>
<p><strong>FAR</strong> - подпрограмма дальнего вызова (можно вызывать из других сегментов).<br>
<strong>NEAR</strong> - ближнего (вызов только из этого сегмента).<br>
<strong>RET</strong> - дальнего вызова.</p>
<p><code>&lt;ALIGNMENT TYPE&gt;</code> может быть <strong>PARA</strong>, <strong>BYTE</strong>, <strong>WORD</strong>, <strong>PAGE</strong>.<br>
Указывает, чему должны быть кратны адрес начала и конца сегмента. По умолчанию <strong>PARA</strong>.</p>