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
	Unidad DB 0,0
	Decena DB 0,0

	Diez DB 10,0

	Credito DB 13,10, "Hecho por: Adolfo Lopez 1203612",0

.DATA?
	num1 DB ?						
	num2 DB ?

;Segmento de Codigo
.CODE
Programa:
main PROC
	;Mensaje Inicial
	write "LABORATORIO 07: COMPARACION DE NUMEROS"

	;Solicita el primer numero
	write 13,10, "Ingresa numero 01 de un digito: "
	INVOKE StdIn, addr num1,3					; indica el final de una variable
	SUB num1,30H

	;Solicita el segundo numero
	write  "Ingresa numero 02 de un digito: "
	INVOKE StdIn, addr num2,3					; indica el final de una variable
	SUB num2,30h

	;/////////////////////// SUMA ///////////////////////
SUMA:
	XOR AX,AX

	MOV AL,num1
	ADD AL,num2
	DIV Diez

	MOV Decena,AL
	ADD Decena,30H

	MOV Unidad,AH
	ADD Unidad,30H

	write 13,10, "Total es: "
	INVOKE StdOut, addr Decena
	INVOKE StdOut, addr Unidad

	;/////////////////////// RESTA ///////////////////////
RESTA:
	XOR AX,AX

	MOV AL,num1
	SUB AL,num2
	DIV Diez

	MOV Decena,AL
	ADD Decena,30H

	MOV Unidad,AH
	ADD Unidad,30H

	write 13,10, "Diferencia es: "
	INVOKE StdOut, addr Decena
	INVOKE StdOut, addr Unidad

	;/////////////////////// COMPARACION ///////////////////////
Comparar:
	XOR AX,AX

	MOV AL,num2
	CMP num1, AL
	JE Igual
	JA Mayor_num1
	JB Menor_num1

Igual:
	write 13,10, "Los numeros son iguales" ,13,10
	JMP Finalizar

Mayor_num1:
	write 13,10, "El primer numero es mayor que el segundo" ,13,10
	JMP Finalizar

Menor_num1:
	write 13,10, "El segundo numero es mayor que el primero" ,13,10
	JMP Finalizar

;Finalizar el programa
Finalizar:
	INVOKE StdOut, addr Credito

	INVOKE ExitProcess,0
main ENDP
END Programa