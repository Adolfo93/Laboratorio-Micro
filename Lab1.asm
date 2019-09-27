.MODEL small
.DATA
;Variable que contiene el texto que queremos mostrar
	Titulo1 DB 'EJERCICIO 01 - Declaracion de variables$'
	Titulo2 DB 'EJERCICIO 03 - Impresion de caracteres$'
	
	nombre DB 'Nombre: Adolfo Lopez$'
	carnet DB 'Carnet: 1203612$'
	
	Caracter DB 'El simbolo escogido es: $'
	Credito DB 'Hecho por: Adolfo Lopez - 1203612$' 
.STACK

.CODE
PROGRAMA:					;etiqueta de inicio de programa
	;Iniciar un Programa
	MOV AX,@DATA
	MOV DS, AX
	
	MOV DX, OFFSET Titulo1	;Imprimir Titulo 1
	MOV AH,09h				
	INT 21h					
	
	MOV DX, 10				;Saltar linea
	MOV AH,02H
	INT 21h
	
	;imprimir nombre y carnet del estudiante
	MOV DX, OFFSET nombre	;Imprime el nombre
	MOV AH,09h				;Decimos que se imprima la cadena
	INT 21h					;Ejecuta la interrupción, he imprime la cadena
	
	MOV DX, 10				;Saltar linea
	MOV AH,02H
	INT 21h
	
	MOV DX, OFFSET carnet	;Imprime el carnet
	MOV AH,09h				;Decimos que se imprima la cadena
	INT 21h					;Ejecuta la interrupción, he imprime la cadena
	
	MOV DX, 10				;Saltar linea
	MOV AH,02H
	INT 21h
	
	MOV DX, 10				;Saltar linea
	MOV AH,02H
	INT 21h
	
	MOV DX, OFFSET Titulo2	;Imprimir Titulo2
	MOV AH,09h				
	INT 21h					
	
	MOV DX, 10				;Saltar linea
	MOV AH,02H
	INT 21h
	
	;imprimir caracter
	MOV DX, OFFSET Caracter	;Imprime la cadena
	MOV AH,09h				;Decimos que se imprima la cadena
	INT 21h					;Ejecuta la interrupción, he imprime la cadena
	
	MOV DX, 2ah				;Imprime el caracter
	MOV AH,02h				
	INT 21h					
	
Salir:						;Etiqueta de finalización del programa
	MOV DX, 10				;Saltar linea
	MOV AH,02H
	INT 21h
	
	MOV DX, 10				;Saltar linea
	MOV AH,02H
	INT 21h
	
	MOV DX, OFFSET Credito	;Imprimir mensaje de salida
	MOV AH,09h				
	INT 21h	
	
	MOV AH, 4Ch		;Finalizar proceso
	INT 21h			;Ejecutar interrupción
END