.MODEL small							; Modelo para ejecutables
.STACK

.DATA
	;Variable donde vamos a guardar el primer y segundo digito ingresado
	num1 DB ?			
	num2 DB ?

	Tnum1 DB 'Ingrese el primer numero: $'
	Tnum2 DB 'Ingrese el segundo numero: $'
	
	suma DB 'Total: $'
	resta DB 'Diferencia: $'
	Multi DB 'Producto: $'	
	divic DB 'Cociente: $'
	divir DB 'Residuo: $'
	res DB ?
	
	Credito DB 'Hecho por: Adolfo Lopez - 1203612$' 
	
.CODE
Programa:
	;INICIAR EL PROGRAMA
	Mov AX,@DATA						; Se obtiene la dirección de inicio del segmento de datos
	Mov DS,AX							; Se asigna al registro data segment la dirección de inicio del segmento de datos
	
	;SOLICITAR EL PRIMER NUMERO Y GUARDARLO EN SU VARIABLE
	MOV DX, OFFSET Tnum1				;Imprime la cadena para solicitar num1
	MOV AH,09h				
	INT 21h	
	
	MOV AH,01h							;Comando para leer caracter desde el teclado
	INT 21h								;lee primer caracter
	
	SUB AL, 30h							;resto 30H (48Dec) para obtener el numero real
	MOV num1,AL							;lo guardo en variable num1
	
	MOV DX, 10							;Saltar linea
	MOV AH,02H
	INT 21h
	
	;SOLICITAR EL SEGUNDO NUMERO Y GUARDARLO EN SU VARIABLE
	MOV DX, OFFSET Tnum2				;Imprime la cadena para solicitar num2
	MOV AH,09h				
	INT 21h	
	
	MOV AH,01h							;Comando para leer caracter desde el teclado
	INT 21h								;lee primer caracter
	
	SUB AL, 30h							;resto 30H (48Dec) para obtener el numero real
	MOV num2,AL							;lo guardo en variable num1
	
	MOV DX, 10							;Saltar linea
	MOV AH,02H
	INT 21h
	
	MOV DX, 10							;Saltar linea
	MOV AH,02H
	INT 21h
	
	;SUMA
	MOV DX, OFFSET suma					;Imprimir la cadena suma
	MOV AH,09h				
	INT 21h
	
	XOR BX,BX							;Se limpia el registro

	MOV BH, num1						;Se agrega a BH el valor en num1
	MOV BL, num2						;Se agrega a BL el valor en num2 
		
	ADD BH, BL							;Se suman BH y BL
	ADD BH, 30H							;Valores enteros
	
	MOV DL, BH							;Imprimir en pantalla valor
	Mov AH, 02h							;Imprimir el resultado de la suma
	Int 21h
	
	MOV DX, 10							;Saltar linea
	MOV AH,02H
	INT 21h
	
	;RESTA
	MOV DX, OFFSET resta				;Imprimir la cadena resta
	MOV AH,09h				
	INT 21h
	
	XOR BX,BX							;Se limpia el registro
	
	MOV BH, num1						;Se agrega a BH el valor en num1
	MOV BL, num2						;Se agrega a BL el valor en num2
	
	SUB BH, BL						
	ADD BH, 30h							; Valores enteros
	MOV DL, BH
	MOV AH, 02h							; Imrpimir en pantalla valor
	INT 21h

	MOV DX,10							;salto de linea
	MOV AH,02H
	INT 21H
	
	;MULTIPLICACION
	MOV DX, OFFSET Multi				;Imprimir la cadena Multi
	MOV AH,09h				
	INT 21h
	
	MOV DL, num1						;Se agrega el valor de num1 a DL
	MOV AL, num2						;Se agrega el valor de num2 a AL 
	
	MUl DL 								; Multiplicar dato en AL y el otro registo DL
	Add AX, 30h							; Valores enteros
	Mov Dx, Ax 
	MOV AH, 02h							; Imrpimir en pantalla un caracter
	INT 21h

	MOV DX,10							;salto de linea
	MOV AH,02H
	INT 21H
	
	;DIVISION
	MOV DX, OFFSET divic				;Imprimir la cadena divic
	MOV AH,09h				
	INT 21h
	
	MOV AH, 0H							;Se asigna 0 a la parte baja de AX
	MOV AL, num1						;Se agrega el valor de num1 a AX
	MOV BL, num2						;Se agrega el valor de num2 a DL
	
	DIV BL 								;Dividir los valores AX y DL
	MOV res,AH							;Asignar el valor del residuo a res
	ADD res,30H							;sumar 30h para obtener el valor entero
	
	Add AL, 30H	
	
	MOV DL, AL
	MOV AH, 02h							;Imprimir en pantalla un caracter
	INT 21h
	
	MOV DX,10							;salto de linea
	MOV AH,02H
	INT 21H
	
	MOV DX, OFFSET divir				;Imprimir la cadena divir
	MOV AH,09h				
	INT 21h
	
	MOV DL,res
	MOV AH, 02h							; Imprimir en pantalla un caracter
	INT 21h
	
	
	;Finalizar el programa
	MOV DX, 10							;Saltar linea
	MOV AH,02H
	INT 21h
	
	MOV DX, 10							;Saltar linea
	MOV AH,02H
	INT 21h
	
	MOV DX, OFFSET Credito	;Imprimir mensaje de salida
	MOV AH,09h				
	INT 21h	
	
	MOV ah, 4ch						;Condicion para finalizar el programa
	INT 21H
	
END Programa
