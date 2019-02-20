<h1><a id="____1_0"></a>���������� � ����������� ������ �1</h1>
<p><strong>����������� ����������� ������</strong><br>
������ ������������ ����� �������� ������������������ ������, ���������� �� ���������.<br>
<strong><em>���������</em></strong> - ������������������ �� 16 ����, � ������� �� ������� ����� ������ 16.<br>
�������� �������� ���������� ��������� x86 ���������.<br>
������ ���������� ����� ������������ �� ������ �������� � �������� ������������<br>
������ ����� �������� (����� 5 �������� 3�).</p>
<pre><code>&lt;full address&gt; = &lt;segment number&gt; * &lt;segment size&gt; + &lt;bias (or offset)&gt;
</code></pre>
<hr>
<p><strong>��������� ������������� ��������� �� 16 ������ Microsoft Assembler x8086</strong></p>
<pre><code>; �������� �������� �����
SEGMENT_STACK SEGMENT PARA STACK 'STACK'
    DB 64 DUP('STACK')
SEGMENT_STACK ENDS

; �������� �������� ������
SEGMEMT_DATA SEGMENT PARA 'DATA'
    S DW 42
SEGMENT_DATA ENDS

; �������� �������� ����
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
<p>��������� �������� ��������� ������ ������������, ����� ���� � ��� �� ������� ����������� � ���������� �������, ��� ����� ����������� ������ ����� � ���������� ����� ����.</p>
<h2><a id="____42"></a>��������� ��������� �������� ��������</h2>
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
<p><strong>FAR</strong> - ������������ �������� ������ (����� �������� �� ������ ���������).<br>
<strong>NEAR</strong> - �������� (����� ������ �� ����� ��������).<br>
<strong>RET</strong> - �������� ������.</p>
<p><code>&lt;ALIGNMENT TYPE&gt;</code> ����� ���� <strong>PARA</strong>, <strong>BYTE</strong>, <strong>WORD</strong>, <strong>PAGE</strong>.<br>
���������, ���� ������ ���� ������ ����� ������ � ����� ��������. �� ��������� <strong>PARA</strong>.</p>