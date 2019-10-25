.MODEL Small
.STACK
.DATA

	num1 DB ?
	num2 DB ?
	
	Mult DB 0								; variable temporal para guardar la sumatoria
	Decena DB 0								; variable para guardar las decenas
	Unidad DB 0								; variable para guardar las unidades
	Diez DB 10								; valor que va a multiplicar/dividir las decenas
	
	Primervalor DB'Ingrese el primer numero: $'
	Segundovalor DB 'Ingrese el segundo numero: $'
	Respuesta DB 'Su producto es: $'
	
	Credito db 'Hecho por: Adolfo Lopez 1203612 $'
.CODE
Programa:
	MOV AX, @data							; Se obtiene la dirección de inicio del segmento de datos
	MOV DS, AX
	
	CALL Limpiar_Pantalla
	
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
	
	MOV DX, 10								; Saltar linea
	MOV AH,02H
	INT 21h
	
	MOV DX, 10								; Saltar linea
	MOV AH,02H
	INT 21h
	
	;Preparar los valores para el ciclo
	XOR CX,CX
	MOV CL,num2								; Asignamos a CL el valor de num2

Multiplicar:
	MOV AL, num1							; Movemos a AL lo que se encuentra en num1
	ADD Mult,AL								; Se lo sumamos a la variable Mult
	LOOP Multiplicar						; repetimos el ciclo CL veces
	
Imprimir:
	XOR AX,AX								; Limpiar registros
	XOR DX,DX

	MOV AL, Mult			          		; Movemos lo que esta en la variable multiplicacion al registro Al
    DIV Diez                        		; Dividimos lo que esta en Al dentro de 10 para obtener el Cociente
    MOV Decena, Al                  		; Movemos el resultado del cociente a la variable decena
    MOV unidad, AH                  		; Movemos el resultado de residuo a la varaible unidad
	
	MOV AH, 09                      		; Se asigna el valor para impresion de caracteres en pantalla a la parte alta del acumulador
    MOV DX, offset Respuesta				; Se obtiene la direccion de inicio de la variable Respuesta y asigna al DX
    INT 21h                         		; Se invoca a la interrupcion del DOS 21h
	
	MOV DL, Decena		             		; Al registro DL se asigna lo que esta en decena
    ADD DL, 30h                      		; Sumar 30h para obtener numero en decimal
    MOV AH, 02                       		; Se asigna el valor para impresion de numeros en pantalla a la parte alta del acumulador
    INT 21h 

	MOV DL, unidad		             		; Al registro DL se asigna lo que esta en unidad
    ADD DL, 30h                      		; Sumar 30h para obtener numero en decimal
    MOV AH, 02                       		; Se asigna el valor para impresion de numeros en pantalla a la parte alta del acumulador
    INT 21h 
	
	JMP Salida

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