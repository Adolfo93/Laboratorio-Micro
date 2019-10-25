.MODEL Small
.STACK
.DATA
	num DB ?								; variable para guardar numero de 2 digitos
	
	Dividendo DB 0							; valor que va a dividir el numero
	Decena DB 0								; variable para guardar las decenas
	Unidad DB 0								; variable para guardar las unidades
	Diez DB 10								; valor que va a multiplicar/dividir las decenas
	
	valor DB'Ingrese un numero: $'
	Factores DB 'Sus factores son: $'
	
	Credito db 'Hecho por: Adolfo Lopez 1203612 $'
	
.CODE
Programa:
	MOV AX, @data							; Se obtiene la dirección de inicio del segmento de datos
	MOV DS, AX
	
	CALL Limpiar_Pantalla
	
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
    MOV DX, offset Factores					; Se obtiene la direccion de inicio de la variable Respuesta y asigna al DX
    INT 21h                         		; Se invoca a la interrupcion del DOS 21h
	
	MOV DX, 10								; Saltar linea
	MOV AH,02H
	INT 21h
	
	MOV ah,02h
    MOV dl, 0 ; 							se imprime el numero 1 ya que es un factor que se repite
    ADD dl,30h
    int 21h
	
	MOV ah,02h
    MOV dl, 1 ; 							se imprime el numero 1 ya que es un factor que se repite
    ADD dl,30h
    int 21h
	
	MOV DX, 10								; Saltar linea
	MOV AH,02H
	INT 21h
	
	MOV CL,99								; Se le asigna a CL un valor x para que vaya decrementando
	
	XOR BX,BX
	
	MOV Dividendo,2							; Asignamos 2 unidades a la varaible Dividendo
	mOV BL,Dividendo						; Se guarda en BL lo que esta en Dividendo
	
Dividir:
	XOR AX,AX
	MOV AL, num								; Guarda en AL lo que tiene num1
	DIV BL									; Divide AX dentro de BL
	CMP AH,0H								; Compara que el residuo sea igual a 0
	JE Imprimir_factor						; Si el residuo es 0 lo imprime en pantalla
	JMP No_factor							; Si no es 0 entonces sigue con el ciclo

Imprimir_factor:							;Imprime lo que hay en BL
	XOR AX,AX
	XOR DX,DX
	
	MOV AL, BL				          		; Movemos lo que esta en BL al registro AL
    DIV Diez                        		; Dividimos lo que esta en AL dentro de 10 para obtener el Cociente
    MOV Decena, Al                  		; Movemos el resultado del cociente a la variable decena
    MOV unidad, AH                  		; Movemos el resultado de residuo a la varaible unidad
	
	MOV DL, Decena		             		; Al registro DL se asigna lo que esta en decena
    ADD DL, 30h                      		; Sumar 30h para obtener numero en decimal
    MOV AH, 02                       		; Se asigna el valor para impresion de numeros en pantalla a la parte alta del acumulador
    INT 21h 

	MOV DL, unidad		             		; Al registro DL se asigna lo que esta en unidad
    ADD DL, 30h                      		; Sumar 30h para obtener numero en decimal
    MOV AH, 02                       		; Se asigna el valor para impresion de numeros en pantalla a la parte alta del acumulador
    INT 21h 
	
	MOV DX, 10								; Saltar linea
	MOV AH,02H
	INT 21h
	
	CMP BL,num								; Comparamos que BL sea igual a 1
	JE salida								; Si es igual a 1 entonces salta a la etiqueta salida
	INC	BL									; Incrementa en 1 el valor de BL
LOOP Dividir

No_factor:									; Etiqueta que no imprime el factor
	XOR AX,AX								; Limpiar el registro AX
	INC BL									; Incrementa en 1 el valor de BL
LOOP Dividir

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
	
	MOV AH, 4CH								; Condicion para finalizar el programa
	INT 21H

END Programa