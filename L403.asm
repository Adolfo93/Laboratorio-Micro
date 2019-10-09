.MODEL Small
.STACK
.DATA
	num1 db ?
	num2 db ?
	
	Decena db 0								; Variable para guardar la decena
	unidad db 0								; Variable para guardar la unidad
	diez db 10
	uno db 1

	Multiplicacion db 0						; Variable para guardar la multiplicacion
	Division db 0							; Variable para guardar el cociente de la division
	ResultadoDiv db 0						; Variable para guardar el residuo de la division

	Primervalor db'Ingrese el primer numero: $'
	Segundovalor db 'Ingrese el segundo numero: $'
	
	msg1 db 'Producto = $'
	msg2 db 'Cociente = $'
	msg3 db 'Residuo = $'
	
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
	
	MOV DX, 10								; Saltar linea
	MOV AH,02H
	INT 21h
	
	MOV DX, 10								; Saltar linea
	MOV AH,02H
	INT 21h

;//////////////////////// MULTIPLICACION ////////////////////////
	XOR CX,CX        						; Se limpia CX
    XOR AX,AX         						; Se limpia AX
	
    MOV CL, num2							; Se guarda en CL lo almacenado en num2
	
	JMP multi 								; Se realiza un salto a la operacion
	JMP ImprimirMul

	XOR AX,AX                       		; Limpiamos el registro AX
    MOV AL, num1               				; Le asignamos al registro Al el valor en num1
    MOV division, Al               			; Le asignamos a la variable division lo que esta en Al

    JMP Divi  								; Salta a la etiqueta Divi

multi:
	MOV Al, num1               				; Movemos lo que esta en num1 al registro AL
    ADD Multiplicacion, AL  	    		; Le sumamos lo que esta en num1 a la variable multiplicacion 
    LOOP multi 								; Se vuelve a utilizar la etiqueta multi hasta que CX sea 0

ImprimirMul:
    XOR AX,AX                       		; Limpiamos el registro AX
    XOR DX,DX                       		; Limpiamos el registro DX

    MOV Al, Multiplicacion          		; Movemos lo que esta en la variable multiplicacion al registro Al
    DIV diez                        		; Dividimos lo que esta en Al dentro de 10 para obtener el Cociente
    MOV Decena, Al                  		; Movemos el resultado del cociente a la variable decena
    MOV unidad, AH                  		; Movemos el resultado de residuo a la varaible unidad
                
    MOV AH, 09                      		; Se asigna el valor para impresion de caracteres en pantalla a la parte alta del acumulador
    MOV DX, offset msg1  					; Se obtiene la direccion de inicio de la variable msg1 y asigna al DX
    INT 21h                         		; Se invoca a la interrupcion del DOS 21h
                
    MOV DL, Decena		             		; Al registro DL se asigna lo que esta en decena
    ADD DL, 30h                      		; Sumar 30h para obtener numero en decimal
    MOV AH, 02                       		; Se asigna el valor para impresion de numeros en pantalla a la parte alta del acumulador
    INT 21h 

	MOV DL, unidad		             		; Al registro DL se asigna lo que esta en unidad
    ADD DL, 30h                      		; Sumar 30h para obtener numero en decimal
    MOV AH, 02                       		; Se asigna el valor para impresion de numeros en pantalla a la parte alta del acumulador
    INT 21h 

    XOR AX,AX                      			; Limpiamos el registro AX
	
    MOV AL, num1               				; Asignamos lo que esta en variable1 al registro Al
    MOV Division, Al            			; Asignamos lo que esta en el registro Al a la variable division

	MOV DX, 10								; Saltar linea
	MOV AH,02H
	INT 21h

;/////////////////////////// DIVISION ///////////////////////////
Divi:
    MOV Al, num2               				; Asignamos lo que esta en variable2 al registro Al
    SUB Division, Al						; Restamos a la varaible division lo que contiene el registro Al

    XOR BX,BX                       		; Limpiamos el registro BX
    MOV BL, uno                     		; A BL le asiganmos la varaible uno
    ADD ResultadoDiv, BL            		; Incrementa en una unidad la variable resultadoDiv, este sera el contador

    XOR AX, AX                      		; Limpiamos la variable AX
    MOV Al, Division            			; Movemos lo que esta en division al registro Al
    
    CMP Al, num2              				; Compara si el valor de Al con el de num2
    JL menor                      			; Salta si el primer numero es menor que el segundo
    JGE mayor                       		; Salta si el primer numero es mayor que el segundo
                
mayor:
    JMP Divi                        		; Regresamos a la instruccion Divi para que se ejecute de nuevo

menor:     
    JMP ImprimirDivi                		; Imprimimos los resultados pues ya no se puede dividir mas
                
ImprimirDivi:
	XOR AX,AX                       		; Limpiamos el registro AX
    XOR DX,DX                       		; Limpiamos el registro DX

    MOV Al, resultadoDiv          			; Movemos lo que esta en la variable resultadoDiv al registro Al
    DIV diez                        		; Dividimos lo que esta en Al dentro de 10 para obtener el Cociente
    MOV Decena, Al                  		; Movemos el resultado del cociente a la variable decena
    MOV unidad, AH  

    MOV AH, 09                       		; Se asigna el valor para impresion de caracteres en pantalla a la parte alta del acumulador
    MOV DX, offset msg2 	         		; Se obtiene la direccion de inicio de la variable msg4 y asigna al DX
    INT 21h                          		; Si invoca a la interrupcion del DOS 21h
    
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
	
    ;///////////////////////////// IMPRIMIR EL RESIDUO /////////////////////////////////////////////
    XOR AX,AX                         		; Limpiamos el registro AX
    XOR DX,DX                        		; Limpiamos el registro DX
	
	MOV Al, division		          		; Movemos lo que esta en la variable division al registro Al
    DIV diez                        		; Dividimos lo que esta en Al dentro de 10 para obtener el Cociente
    MOV Decena, Al                  		; Movemos el resultado del cociente a la variable decena
    MOV unidad, AH  						; Movemos el resultado de residuo a la varaible unidad
	
    MOV AH, 09                  		    ; Se asigna el valor para impresion de caracteres en pantalla a la parte alta del acumulador
    MOV DX, offset msg3               		; Se obtiene la direccion de inicio de la variable msg3 y asigna al DX
    INT 21h                           		; Se invoca a la interrupcion del DOS 21h
	
    MOV DL, Decena		             		; Al registro DL se asigna lo que esta en decena
    ADD DL, 30h                      		; Sumar 30h para obtener numero en decimal
    MOV AH, 02                       		; Se asigna el valor para impresion de numeros en pantalla a la parte alta del acumulador
    INT 21h 

	MOV DL, unidad		             		; Al registro DL se asigna lo que esta en unidad
    ADD DL, 30h                      		; Sumar 30h para obtener numero en decimal
    MOV AH, 02                       		; Se asigna el valor para impresion de numeros en pantalla a la parte alta del acumulador
    INT 21h 
	
	JMP Salida								; Saltamos a la etiqueta de salida

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

end Programa