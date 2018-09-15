;28-08-2018
;Universidad Rafael Landivar
;Arquitectura del computador II
;Mynor Oswaldo Alvarez Hernández 22-81416
	
list p=16f84a					;Listo el Pic a utilizar
#include <p16f84a.inc>				;Incluyo la librería p16f84a.inc
	org	    0x00			;Inicializo en el vector 0 que es el reset
	goto	    Inicio			;Salto a inicio para la configuracion del puerto
	org	    0x05			;Me muevo a la posicion 5 de la ram para empezar a ecribir el programa
	contador    EQU	0xBB			;Variable que me sirve para generar mi tiempo
	contador1   EQU	0xFF			;Otra variable para hacer un tiempo anidado
   
Inicio:						;Confgurar los registros
	bsf	    STATUS, RP0			;Salta al banco 1
	clrf	    TRISB			;Configura el puerto b como salida
	bcf	    STATUS, RP0			;Salta al banco 0
	clrf	    PORTB 			;puerto b apagado

Bascular:					
	BTFSC	    PORTB, 0			;Si(portb.RB0==0) encender
	goto	    Apagar			;Sino apagar
	BSF	    PORTB, 0			;PORTB.RB0=1
	goto	    Retardo			;SALTA A RETARDO
Apagar:
	bcf	    PORTB,0			;PORTB.RB0=0
Retardo:
	decfsz	    contador, 1			;DECREMENTA CONTADOR Y EVALUA SI ES 0
	goto	    Retardo1			;Sino slta a retardo1
	movlw	    0xBB			;si cumple asignamos Decimal 187 BB en hexadecimal al registro W
	movwf	    contador			;Movemos lo que tiene el registro w a contador "contador=255"
	goto	    Bascular			;Salta a Bascular
Retardo1:
	decfsz	    contador1, 1		;DECREMENTA CONTADOR1 Y EVALUA SI ES 0
	goto	    Retardo1			;Sino slta a retardo1
	movlw	    0xFF			;si cumple asignamos 255 al registro W
	movwf	    contador1			;Movemos lo que tiene el registro w a contador1 "contador1=255"
	goto	    Retardo			;Salta a Bascular
END						;Termina el programa.