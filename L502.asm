.MODEL Small
.STACK
.DATA
	Letra DB 'X $'
	Tecla_Enter equ 0dh    					; Guarda el codigo para la tecla ENTER 
	
	Credito db 'Hecho por: Adolfo Lopez 1203612 $'
.CODE
Programa:
	MOV AX, @data							; Se obtiene la dirección de inicio del segmento de datos
	MOV DS, AX
	
	CALL Limpiar_Pantalla					; Se llama a la etiqueta limpiar pantalla
	
	MOV CX, 3333							; Se le asigna a CX un valor random

Imprimir:			
	LEA DX, Letra							; Se imprime la letra X
	MOV AH, 09h
	INT 21H
Loop Imprimir
	
	MOV AH, 01h								; Interrupcion para solicitar una entrada al teclado
	INT 21H									; Se ejecuta la interrupcion
	CMP AL, Tecla_Enter						; Se compara que AL sea igual a la tecla ENTER
	JNE Salida								; Si es igual culmina el programa

Limpiar_Pantalla PROC						; Funcion para limpiar pantalla
	MOV AX, 03H
	INT 10H
	RET
Limpiar_Pantalla ENDP

Salida:
	MOV DX, 10								; Saltar linea
	MOV AH,02H
	INT 21h
	
	MOV DX, 10								; Saltar linea
	MOV AH,02H
	INT 21h
	
	MOV DX, OFFSET Credito					; Imprimir mensaje de salida
	MOV AH,09h				
	INT 21h	
	
	MOV ah, 4ch								; Condicion para finalizar el programa
	INT 21H

END Programa