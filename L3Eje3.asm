.MODEL small							; Modelo para ejecutables
.STACK

.DATA
	;Variable donde vamos a guardar el primer y segundo digito ingresado
	num1 DB ?							; Primer numero
	num2 DB ?							; Segundo numero
	
	Decena DB ?							; Variable donde se almacenaran las decenas
	Unidad DB ?							; Variable donde se almacenaran las unidades
	diez DB 10							; Valor que se utilizará para calcular las decenas

	Tnum1 DB 'Ingrese el primer numero: $'
	Tnum2 DB 'Ingrese el segundo numero: $'
	
	suma DB 'Total: $'
	resta DB 'Diferencia: $'
	Multi DB 'Producto: $'	
	divic DB 'Cociente: $'
	divir DB 'Residuo: $'

	cociente DB ?						; Variable donde se almacenara el cociente
	residuo DB ?						; Variable donde se almacenara el residuo
	
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
	
	;//////////////////////////// SUMA ////////////////////////////
	XOR AX,AX
	
	MOV AL, num1						; Se asigna a AL el valor de num1
	ADD AL, num2						; Se suman los valores de num1 y num2
	DIV diez							; Se divide AL dentro de la variable diez
	MOV Decena, AL						; Se guarda el cociente en Decena
	MOV Unidad, AH						; Se guarda el residuo en Unidad
	
	MOV DX, OFFSET suma					;Imprimir la cadena suma
	MOV AH,09h				
	INT 21h
	
	Mov DL, Decena                  	; Movemos lo que esta en la varaible decena al registro DL
    Add DL, 30h 						; Se le suman los valores enteros
	Mov AH, 02                      	; Se asigna el valor para impresi�n de numeros en pantalla a la parte alta del acumulador
    Int 21h    
	
	Mov DL, Unidad                  	; Movemos lo que esta en la varaible decena al registro DL
    Add DL, 30h 
	Mov AH, 02							; Se asigna el valor para impresi�n de numeros en pantalla a la parte alta del acumulador
    Int 21h    
	
	MOV DX, 10							; Saltar linea
	MOV AH,02H
	INT 21h
	
	;//////////////////////////// RESTA ////////////////////////////
 	XOR AX,AX
	
	MOV AL, num1						; Se asigna a AL el valor de num2
	SUB AL, num2						; Se suman los valores de num1 y num2
	DIV diez							; Se divide AL dentro de la variable diez
	MOV Decena, AL						; Se guarda el cociente en Decena
	MOV Unidad, AH						; Se guarda el residuo en Unidad
	
	MOV DX, OFFSET resta				; Imprimir la cadena suma
	MOV AH,09h				
	INT 21h
	
	Mov DL, Decena                  	; Movemos lo que esta en la varaible decena al registro DL
    Add DL, 30h 						; Se le suman los valores enteros
	Mov AH, 02                      	; Se asigna el valor para impresion de numeros en pantalla a la parte alta del acumulador
    Int 21h    
	
	Mov DL, Unidad                  	; Movemos lo que esta en la varaible decena al registro DL
    Add DL, 30h 						; Se le suman los valores enteros
	Mov AH, 02							; Se asigna el valor para impresion de numeros en pantalla a la parte alta del acumulador
    Int 21h   
	
	MOV DX, 10							; Saltar linea
	MOV AH,02H
	INT 21h
	
	;//////////////////////////// MULTIPLICACION ////////////////////////////
	XOR AX,AX							; Se limpia el registro AX
	XOR DX,DX							; Se limpia el registro DX
	
	MOV DL, num1						;Se agrega el valor de num1 a DL
	MOV AL, num2						;Se agrega el valor de num2 a AL 
	
	MUl DL 								; Multiplicar dato en AL y el otro registo DL
	DIV diez							; Se divide AL dentro de la variable diez
	MOV Decena, AL						; Se guarda el cociente en Decena
	MOV Unidad, AH						; Se guarda el residuo en Unidad
	
	MOV DX, OFFSET Multi				;Imprimir la cadena Multi
	MOV AH,09h				
	INT 21h
	
	Mov DL, Decena                  	; Movemos lo que esta en la varaible decena al registro DL
    Add DL, 30h 						; Se le suman los valores enteros
	Mov AH, 02                      	; Se asigna el valor para impresion de numeros en pantalla a la parte alta del acumulador
    Int 21h    
	
	Mov DL, Unidad                  	; Movemos lo que esta en la varaible decena al registro DL
    Add DL, 30h 						; Se le suman los valores enteros
	Mov AH, 02							; Se asigna el valor para impresion de numeros en pantalla a la parte alta del acumulador
    Int 21h   
	
	MOV DX, 10							; Saltar linea
	MOV AH,02H
	INT 21h
	
	;//////////////////////////// DIVISION ////////////////////////////
	XOR AX,AX							; Se limpia el registro AX
	XOR BX,BX							; Se limpia el registro BX
	
	MOV AH, 0H							; Se asigna 0 a la parte baja de AX
	MOV AL, num1						; Se agrega el valor de num1 a AL
	MOV BL, num2						; Se agrega el valor de num2 a BL
	
	DIV BL 								; Dividir los valores AX y BL
	MOV cociente, AL					; Asignar el valor de AL a cociente
	MOV residuo, AH						; Asignar el valor de AH a residuo
	
	;COCIENTE
	XOR AX,AX							; Se limpia el registro AX
	XOR DX,DX							; Se limpia el registro DX
	
	MOV AL, cociente					
	DIV diez							; Se divide AL (cociente) dentro de la variable diez
	MOV Decena, AL						; Se guarda el cociente en Decena
	MOV Unidad, AH						; Se guarda el residuo en Unidad
	
	MOV DX, OFFSET divic				;Imprimir la cadena divic
	MOV AH,09h				
	INT 21h
	
	Mov DL, Decena                  	; Movemos lo que esta en la varaible decena al registro DL
    Add DL, 30h 						; Se le suman los valores enteros
	Mov AH, 02                      	; Se asigna el valor para impresion de numeros en pantalla a la parte alta del acumulador
    Int 21h    
	
	Mov DL, Unidad                  	; Movemos lo que esta en la varaible decena al registro DL
    Add DL, 30h 						; Se le suman los valores enteros
	Mov AH, 02							; Se asigna el valor para impresion de numeros en pantalla a la parte alta del acumulador
    Int 21h   
	
	MOV DX,10							;salto de linea
	MOV AH,02H
	INT 21H
	
	;RESIDUO
	XOR AX,AX							; Se limpia el registro AX
	XOR DX,DX							; Se limpia el registro DX
	
	MOV AL, Residuo						; Se asigna a AL el valor del residuo
	DIV diez							; Se divide AL dentro de la variable diez
	MOV Decena, AL						; Se guarda el cociente en Decena
	MOV Unidad, AH						; Se guarda el residuo en Unidad
	
	MOV DX, OFFSET divir				;Imprimir la cadena divir
	MOV AH,09h				
	INT 21h
	
	Mov DL, Decena                  	; Movemos lo que esta en la varaible decena al registro DL
    Add DL, 30h 						; Se le suman los valores enteros
	Mov AH, 02                      	; Se asigna el valor para impresion de numeros en pantalla a la parte alta del acumulador
    Int 21h    
	
	Mov DL, Unidad                  	; Movemos lo que esta en la varaible decena al registro DL
    Add DL, 30h 						; Se le suman los valores enteros
	Mov AH, 02							; Se asigna el valor para impresion de numeros en pantalla a la parte alta del acumulador
    Int 21h   

	
	;Finalizar el programa
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
