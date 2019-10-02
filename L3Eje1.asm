.MODEL small			; Modelo para ejecutables
.STACK

.DATA
	Num1 DB 'Numero 1: 4$'
	Num2 DB 'Numero 2: 2$'
	
	suma DB 'Total: $'
	resta DB 'Diferencia: $'
	Multi DB 'Producto: $'	
	divic DB 'Cociente: $'
	divir DB 'Residuo: $'
	res DB ?
	
	Credito DB 'Hecho por: Adolfo Lopez - 1203612$' 
.CODE
programa:
	;INICIAR EL PROGRAMA
	Mov AX,@DATA	; Se obtiene la dirección de inicio del segmento de datos
	Mov DS,AX		; Se asigna al registro data segment la dirección de inicio del segmento de datos
	
	;MOSTRAR LOS NUMEROS A UTILIZAR
	MOV DX, OFFSET Num1				;Imprimir el numero 1
	MOV AH,09h				
	INT 21h	
	
	MOV DX, 10						;Saltar linea
	MOV AH,02H
	INT 21h
	
	MOV DX, OFFSET Num2				;Imprimir el numero 2
	MOV AH,09h				
	INT 21h	
	
	MOV DX, 10						;Saltar linea
	MOV AH,02H
	INT 21h
	
	MOV DX, 10						;Saltar linea
	MOV AH,02H
	INT 21h
	
	;SUMA
	MOV DX, OFFSET suma				;Imprimir la cadena suma
	MOV AH,09h				
	INT 21h
	
	XOR BX,BX						;Se limpia el registro

	MOV BH, 4h						;Se agrega 4h a BH
	MOV BL, 2h						;Se agrega 2h a BL 
		
	ADD BH, BL						;Se suman BH y BL
	ADD BH, 30H						;Valores enteros
	
	MOV DL, BH						;Imprimir en pantalla valor
	Mov AH, 02h						;Imprimir el resultado de la suma
	Int 21h

	MOV DX,10						;salto de linea
	MOV AH,02H
	INT 21H
	
	;RESTA
	MOV DX, OFFSET resta			;Imprimir la cadena resta
	MOV AH,09h				
	INT 21h
	
	XOR BX,BX						;Se limpia el registro
	
	MOV BH, 4h						;Se agrega 4h a BH
	MOV BL, 2h						;Se agrega 2h a BL 
	
	SUB BH, BL						
	ADD BH, 30h						; Valores enteros
	MOV DL, BH
	MOV AH, 02h						; Imrpimir en pantalla valor
	INT 21h

	MOV DX,10						;salto de linea
	MOV AH,02H
	INT 21H
	
	;MULTIPLICACION
	MOV DX, OFFSET Multi			;Imprimir la cadena Multi
	MOV AH,09h				
	INT 21h
	
	MOV DL, 4h						;Se agrega 4h a DL
	MOV AL, 2h						;Se agrega 2h a AL 
	
	MUl DL 							; Multiplicar dato en AL y el otro registo DL
	Add AX, 30h						; Valores enteros
	Mov Dx, Ax 
	MOV AH, 02h						; Imrpimir en pantalla un caracter
	INT 21h

	MOV DX,10						;salto de linea
	MOV AH,02H
	INT 21H
	
	;DIVISION
	MOV DX, OFFSET divic			;Imprimir la cadena divic
	MOV AH,09h				
	INT 21h
	
	MOV AX, 4h						;Se agrega 4h a AX
	MOV DL, 2h						;Se agrega 2h a DL 
	
	DIV DL 							;Dividir los valores AX y DL
	MOV res,AH						;Asignar el valor del residuo a res
	ADD res,30H						;sumar 30h para obtener el valor entero
	
	Add AL, 30H						
	MOV DL, AL
	MOV AH, 02h						; Imprimir en pantalla un caracter
	INT 21h
	
	MOV DX,10						;salto de linea
	MOV AH,02H
	INT 21H
	
	MOV DX, OFFSET divir			;Imprimir la cadena divir
	MOV AH,09h				
	INT 21h
	
	MOV DL,res
	MOV AH, 02h						; Imprimir en pantalla un caracter
	INT 21h
	
	;Finalizar el programa
	MOV DX, 10				;Saltar linea
	MOV AH,02H
	INT 21h
	
	MOV DX, 10				;Saltar linea
	MOV AH,02H
	INT 21h
	
	MOV DX, OFFSET Credito	;Imprimir mensaje de salida
	MOV AH,09h				
	INT 21h	
	
	MOV ah, 4ch						;Condicion para finalizar el programa
	INT 21H
END programa