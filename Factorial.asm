Factor MACRO valor
	MOV valor, AX
	MOV EAX, 1
	MOV res,1
	MOV BX,0

	Factorial:
		INC BX
		MOV CX, BX
		CMP CX,2
		JB Fin
		SUB CX, 1
		MOV EDX, res
		fact:
			ADD EDX,res
			SUB CX,1
			CMP CX,0
			JA fact
			MOV res, EDX
		Fin:
		CMP BX,valor
		JB Factorial
	write "Su factorial es: "
	print str$(res)
ENDM

.386
.MODEL flat, stdcall
option casemap:none

;includes
include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc
include \masm32\include\masm32rt.inc	;Deja imprimir valores que haya en registros

;librerias
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib

;Segmento de Datos
.DATA
	num DW 20 DUP(?)
	res DD 20 DUP(?)

	Credito DB 13,10, "Hecho por: Adolfo Lopez 1203612",0

.DATA?									;Segmento para datos con valores iniciales no definidos
	

;Segmento de Codigo
.CODE
Programa:
Main proc
	;Mensaje Inicial
	write "LABORATORIO 08: FACTORIAL DE UN NUMERO." ,13,10

	;Solicita el numero
	write 13,10, "Ingresa un numero (1-12): "
	INVOKE StdIn, addr num,8				;8 indica el final de una variable
	INVOKE atodw, addr num

	Factor num								;Se llama a la macro

;Finalizar el programa
Finalizar:
	INVOKE StdOut, addr Credito

	INVOKE ExitProcess,0

Main ENDP
END Programa