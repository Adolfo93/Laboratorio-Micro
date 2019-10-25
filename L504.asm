.MODEL Small
.STACK
.DATA
	num DB ?								; numero de dos digitos
	Aux DB ?								; variable auxiliar
	cadena  DB 7 DUP('?'),'$'				; cadena de 7 posiciones
	
	Diez DB 10
	Dividendo DB 2
	
	valor DB'Ingrese un numero: $'
	Respuesta DB 'Su respuesta en binario es: $'
	
	Credito db 'Hecho por: Adolfo Lopez 1203612 $'
.CODE
Programa:
	MOV AX, @data							; Se obtiene la dirección de inicio del segmento de datos
	MOV DS, AX
	
	CALL Limpiar_Pantalla					; Se llama a la funcion limpiar pantalla
	
	;SOLICITAR EL NUMERO DE 2 DIGITOS
	MOV DX, OFFSET valor					; Imprime la cadena para solicitar al numero
	MOV AH,09h				
	INT 21h	
	
	MOV AH,01h								; Comando para leer caracter desde el teclado
	INT 21h									; lee primer caracter
	
	SUB AL, 30h								; resto 30H (48Dec) para obtener el numero real
	MUL Diez								; Multiplica por 10 el valor para obtener su parte decimal
	MOV num,AL								; lo guardo en variable num
	
	MOV AH,01h								; Comando para leer caracter desde el teclado
	INT 21h									; lee primer caracter
	SUB AL, 30h								; resto 30H (48Dec) para obtener el numero real
	ADD num, AL							; Se suman las dos mitades del numero que se solicita

	MOV DX, 10								; Saltar linea
	MOV AH,02H
	INT 21h
	
	MOV AH, 09                      		; Se asigna el valor para impresion de caracteres en pantalla a la parte alta del acumulador
    MOV DX, offset Respuesta				; Se obtiene la direccion de inicio de la variable Respuesta y asigna al DX
    INT 21h                         		; Se invoca a la interrupcion del DOS 21h
	
	MOV SI,6								; Se coloca SI en la posicion 6 que seria el primer valor de izquierda a derecha
	MOV CL,99								; Se le asigna a CL un valor x para que vaya decrementando
	
Conversion:
	XOR AX,AX								; Se limpia el registro AX
	MOV AL,num								; Se asigna a AL el valor del numero
	DIV Dividendo							; Dividimos dentro de 2
	MOV Aux,AH								; Se guarda el residuo en una variable auxiliar
	MOV num,AL								; num se reemplaza por el valor del cociente
	
	MOV DL,Aux								; DL toma lo que hay en Aux
	ADD DL,30H								; Sumar 30h para obtener numero en decimal
	MOV Cadena[SI],DL						; El valor en DL se almacena en una posicion de la cadena
	
	CMP num,1								; Se compara que num sea igual a 1
	DEC SI									; Se decrementa una posicion en SI
	JE Salida								; Si num es igual a 1 salta a la etiqueta salida
LOOP Conversion								; Se repite el ciclo
	
Limpiar_Pantalla PROC						; Funcion para limpiar pantalla
	MOV AX, 03H
	INT 10H
	RET
Limpiar_Pantalla ENDP

Salida:
	MOV DL,num								; Se almacena en DL lo que hay en num
	ADD DL,30H								; Sumar 30h para obtener numero en decimal
	
	MOV Cadena[SI],DL						; Ese valor se almacena en la ultima posicion de la cadena
	
	LEA DX,Cadena							; Se asinga el valor de la cadena en DX
	MOV AH,09								; Se llama a la interrupcion 09 para imprimir la cadena
	INT 21H									; Se ejecuta la interrupcion 21h

	MOV DX, 10								; Saltar linea
	MOV AH,02H
	INT 21h
	
	MOV DX, 10								; Saltar linea
	MOV AH,02H
	INT 21h
	
	MOV DX, OFFSET Credito					; Imprimir mensaje de salida
	MOV AH,09h				
	INT 21h	
	
	MOV AH, 4CH								; Condicion para finalizar el programa
	INT 21H

END Programa