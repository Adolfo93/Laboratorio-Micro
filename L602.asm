.MODEL Small
.STACK
.DATA
	cadena1 DB 15 DUP ('$')
	cadena2 DB 15 DUP ('$')
	
	MSG1 DB 'Ingrese cadena 01: $'
	MSG2 DB 13,10,'Ingrese cadena 02: $'
	
	Igual DB 13,10,'Las cadenas son iguales$'
	NoIgual DB 13,10,'Las cadenas son diferentes$'
	
	Credito DB 13,10,'Hecho por: Adolfo Lopez 1203612 $'
.CODE
Programa:
	MOV AX, @data							; Se obtiene la dirección de inicio del segmento de datos
	MOV DS, AX
	
	CALL Limpiar_Pantalla
	
	MOV DX, OFFSET MSG1						; Imprime la cadena para solicitar el texto
	MOV AH,09h				
	INT 21h	
	
	CALL Leer_Cadena1
	
	MOV DX, OFFSET MSG2						; Imprime la cadena para solicitar el texto
	MOV AH,09h				
	INT 21h	
	
	CALL Leer_Cadena2
	
	CALL Comparar_cadenas
	
Finalizar:
	MOV DX, 10								; Saltar linea
	MOV AH,02H
	INT 21h
	
	MOV DX, OFFSET Credito					; Imprimir mensaje de salida
	MOV AH,09h				
	INT 21h	
	
	MOV AH, 4CH								; Condicion para finalizar el programa
	INT 21H
	
;---------------------------------PROCEDIMIENTOS------------------------------------------

Leer_Cadena1 Proc Near
    LEA DI,cadena1
    MOV AH,01

    Leer:
        INT 21H
        CMP AL,0DH                			; Se compara si el dato enviado es ENTER 
        JE Fin
        MOV [DI],AL
        INC DI
        JMP Leer
    Fin:
		RET	
Leer_Cadena1 ENDP

Leer_Cadena2 Proc Near
    LEA SI,cadena2
    MOV AH,01

    Leer2:
        INT 21H
        CMP AL,0DH                			; Se compara si el dato enviado es ENTER 
        JE Fin2
        MOV [SI],AL
        INC SI
        JMP Leer2
    Fin2:
		RET	
Leer_Cadena2 ENDP

Comparar_cadenas Proc Near
	LEA DI,cadena1  

    comparar:
        CMP AH,24H							; Compara que el valor sea $
        JE Si_igual							; Si lo es entonces salta a salir2 ya que terminó la cadena y son iguales
        MOV AH, cadena1[DI]
        MOV BH, cadena2[DI]
        INC DI
        CMP AH,BH							; Compara que los caracteres sean iguales
        JE comparar							; Si son iguales regresa a la etiqueta LeerC
        JMP No_igual						; Sino son iguales salta a la etiqueta No_igual
    
	No_igual:
		LEA DX,NoIgual
        MOV AH,09
        INT 21H
        JMP Salir
    
	Si_igual:
        LEA DX,Igual
        MOV AH,09
        INT 21H
        JMP Salir

    Salir:
         RET
Comparar_cadenas ENDP

Limpiar_Pantalla PROC
	MOV AX, 03
	INT 10H
	RET
Limpiar_Pantalla ENDP

END Programa