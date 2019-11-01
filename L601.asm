.MODEL small
.STACK
.DATA
	cadena DB 30 DUP ('$')
	
	MSG1 DB 'Ingrese una cadena en minuscula: $'
	MSG2 DB 13,10,'Cadena en Mayuscula: $'
	
	Credito DB 13,10,'Hecho por: Adolfo Lopez 1203612 $'
.CODE
Programa:

	Mov AX, @DATA
    MOV DS, AX
	
	CALL Limpiar_Pantalla
	
	MOV DX, OFFSET MSG1						; Imprime mensaje para solicitar la cadena
	MOV AH,09h				
	INT 21h	
	
	CALL Leer_Cadena
	CALL MAYUS
	
	MOV DX, OFFSET MSG2						; Imprime mensaje para mostrar la cadena
	MOV AH,09h				
	INT 21h	
	
	LEA DX,cadena							; Imprime la cadena en Mayuscula
    MOV AH,09
    INT 21H
	
	;FINALIZAR
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

Leer_Cadena Proc Near

    LEA DI,cadena
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
Leer_Cadena ENDP

MAYUS Proc Near
	
    LEA DI,cadena

    Cambio:
		MOV AH, cadena[DI]
        SUB AH,20H
        MOV cadena[DI],AH
        INC DI
        CMP cadena[DI],24H
        JE Salir
        JMP Cambio
    Salir:
		RET 
MAYUS ENDP	

Limpiar_Pantalla PROC
	MOV AX, 03
	INT 10H
	RET
Limpiar_Pantalla ENDP

END Programa