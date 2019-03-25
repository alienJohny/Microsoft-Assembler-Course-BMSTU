MASM.EXE /Zi MAIN.ASM,,,;
pause
MASM.EXE /Zi SCAN.ASM,,,;
pause

MASM.EXE /Zi f1.asm,,,;
pause
MASM.EXE /Zi f2.asm,,,;
pause
MASM.EXE /Zi f3.asm,,,;
pause
MASM.EXE /Zi f4.asm,,,;
pause
MASM.EXE /Zi f5.asm,,,;
pause
MASM.EXE /Zi f6.asm,,,;
pause

LINK.EXE /CO MAIN.OBJ f1.obj f2.obj f3.obj f4.obj f5.obj f6.obj SCAN.OBJ,,;

DEL *.OBJ *.MAP *.LST *.CRF

MAIN.EXE