.MODEL small
.STACK
.DATA
	num DB ?							; Variable donde se almacena el numero
	
	msg DB 'Ingrese un numero: $'
	
	espar DB 'El numero es par$'
	noespar DB 'El numero no es par$'
	
	residuo DB ?
	
	Credito DB 'Hecho por: Adolfo Lopez - 1203612$' 
	
.CODE
Programa:
	MOV AX, @DATA
	MOV DS,AX
	
	MOV DX, OFFSET msg
	MOV AH,09H
	INT 21H
	
	;Leer numero
	XOR AX,AX
	
	MOV AH,01h							; Comando para leer caracter desde el teclado
	INT 21h								; lee primer caracter
	
	SUB AL, 30h							; resto 30H (48Dec) para obtener el numero real
	MOV num,AL							; lo guardo en variable num
	
	MOV DX, 10							; Saltar linea
	MOV AH,02H
	INT 21h
	
	;Dividir entre 2
	XOR AX,AX
	
	MOV AL, num
	MOV CL,2
	dIV CL
	MOV residuo,AH						; Guardar residuo
	
	;Comparar si es par
	CMP residuo, 0
	JZ Imprimirpar
	
	MOV DX, OFFSET noespar
	MOV AH,09H
	INT 21H
	
	JMP Finalizar
	
Imprimirpar:
	MOV DX, OFFSET espar
	MOV AH,09H
	INT 21H
	
	JMP Finalizar


Finalizar:								; Etiqueta para finalizar el programa
	MOV DX, 10							; Saltar linea
	MOV AH,02H
	INT 21h
	
	MOV DX, 10							; Saltar linea
	MOV AH,02H
	INT 21h
	
	MOV DX, OFFSET Credito				; Imprimir mensaje de salida
	MOV AH,09h				
	INT 21h	
	
	MOV ah, 4ch							; Condicion para finalizar el programa
	INT 21H
	
END Programa