.MODEL Small
.STACK
.DATA
	num1 db ?
	num2 db ?
	
	Primervalor db'Ingrese el primer numero: $'
	Segundovalor db 'Ingrese el segundo numero: $'
	
	RespuestaIguales db 'Los dos numeros son iguales $'
	Respuestamayor db 'El primer numero es mayor al segundo $'
	Respuestamenor db 'El segundo numero es mayor al primero $'
	
	Credito db 'Hecho por: Adolfo Lopez 1203612 $'

.CODE
Programa:
	MOV AX, @data							; Se obtiene la dirección de inicio del segmento de datos
	MOV DS, AX

	;SOLICITAR EL PRIMER NUMERO Y GUARDARLO EN SU VARIABLE
	MOV DX, OFFSET Primervalor				; Imprime la cadena para solicitar num1
	MOV AH,09h				
	INT 21h	
	
	MOV AH,01h								; Comando para leer caracter desde el teclado
	INT 21h									; lee primer caracter
	
	SUB AL, 30h								; resto 30H (48Dec) para obtener el numero real
	MOV num1,AL								; lo guardo en variable num1
	
	MOV DX, 10								; Saltar linea
	MOV AH,02H
	INT 21h
	
    ;SOLICITAR EL SEGUNDO NUMERO Y GUARDARLO EN SU VARIABLE
	MOV DX, OFFSET Segundovalor				; Imprime la cadena para solicitar num2
	MOV AH,09h				
	INT 21h	
	
	MOV AH,01h								; Comando para leer caracter desde el teclado
	INT 21h									; lee primer caracter
	
	SUB AL, 30h								; resto 30H (48Dec) para obtener el numero real
	MOV num2,AL								; lo guardo en variable num2

	;COMPARAR AMBOS NUMEROS Y DECIDIR A DONDE SALTAR SEGUN LA RESPUESTA
	CMP num1,AL								; Se comparan ambos numeros
	JE Igual								; Salta a la etiqueta Igual si ambos son iguales
	JA Mayor1								; Salta a la etiqueta Mayor1 si num1 es mayor que num2
	JB Menor1								; Salta a la etiqueta Menor1 si num1 es menor que num2
	
Igual:
	MOV DX, 10								; Saltar linea
	MOV AH,02H
	INT 21h
	
	MOV AH, 09                      		; Se asigna el valor para impresion de caracteres en pantalla a la parte alta del acumulador
    MOV DX, offset RespuestaIguales 		; Se obtiene la direccion de inicio del RespuestaIguales y se asigna al DX
    INT 21h                         		; Se invoca a la interrupcion del DOS 21h
	
	JMP Finalizar							; Salta a al etiqueta para finalizar el programa
	
Mayor1:
	MOV DX, 10								; Saltar linea
	MOV AH,02H
	INT 21h
	
	MOV AH, 09                      		; Se asigna el valor para impresion de caracteres en pantalla a la parte alta del acumulador
    MOV DX, offset Respuestamayor 			; Se obtiene la direccion de inicio del Respuestamayor y se asigna al DX
    INT 21h                         		; Se invoca a la interrupcion del DOS 21h
	
	JMP Finalizar							; Salta a al etiqueta para finalizar el programa
	
Menor1:
	MOV DX, 10								; Saltar linea
	MOV AH,02H
	INT 21h
	
	MOV AH, 09                      		; Se asigna el valor para impresion de caracteres en pantalla a la parte alta del acumulador
    MOV DX, offset Respuestamenor 			; Se obtiene la direccion de inicio del Respuestamenor y se asigna al DX
    INT 21h                         		; Se invoca a la interrupcion del DOS 21h
	
	JMP Finalizar							; Salta a al etiqueta para finalizar el programa

Finalizar:									; Etiqueta para finalizar el programa
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