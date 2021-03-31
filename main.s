;GRADOS=PWM0_CMPA_R -> 90=573, 0=372, -90=175, 45=471, -45=275
		AREA codigo, CODE, READONLY,ALIGN=2
        THUMB
        EXPORT Start
;--------------------------------------
; Puertos a utiliar puertos A, B, C y D-----------------------------------------------------------------------------------------------------------------
;Registros del puerto A
GPIO_PORTA_AMSEL_R  EQU 0x40004528
GPIO_PORTA_PCTL_R   EQU 0x4000452C
GPIO_PORTA_DIR_R    EQU 0x40004400  
GPIO_PORTA_AFSEL_R  EQU 0x40004420  
GPIO_PORTA_DEN_R    EQU 0x4000451C
;Registros del puerto B
GPIO_PORTB_AMSEL_R  EQU 0x40005528
GPIO_PORTB_PCTL_R   EQU 0x4000552C
GPIO_PORTB_DIR_R    EQU 0x40005400  
GPIO_PORTB_AFSEL_R  EQU 0x40005420  
GPIO_PORTB_DEN_R    EQU 0x4000551C
;Registros del puerto C
GPIO_PORTC_AMSEL_R  EQU 0x40006528
GPIO_PORTC_PCTL_R   EQU 0x4000652C
GPIO_PORTC_DIR_R    EQU 0x40006400  
GPIO_PORTC_AFSEL_R  EQU 0x40006420  
GPIO_PORTC_DEN_R    EQU 0x4000651C
;Registros del puerto D
GPIO_PORTD_AMSEL_R  EQU 0x40007528
GPIO_PORTD_PCTL_R   EQU 0x4000752C
GPIO_PORTD_DIR_R    EQU 0x40007400  
GPIO_PORTD_AFSEL_R  EQU 0x40007420  
GPIO_PORTD_DEN_R    EQU 0x4000751C
;Registros del puerto F
GPIO_PORTF_DIR_R   EQU 0x40025400
GPIO_PORTF_AFSEL_R EQU 0x40025420
GPIO_PORTF_DEN_R   EQU 0x4002551C
GPIO_PORTF_AMSEL_R EQU 0x40025528
GPIO_PORTF_PCTL_R  EQU 0x4002552C
;Registros del puerto E
GPIO_PORTE_AMSEL_R	EQU 0x40024528
GPIO_PORTE_AFSEL_R	EQU 0x40024420
GPIO_PORTE_PCTL_R	EQU 0x4002452C
GPIO_PORTE_DIR_R	EQU	0x40024400
GPIO_PORTE_DEN_R	EQU	0x4002451C

;Registro de reloj de puertos
SYSCTL_RCGCGPIO_R   EQU 0x400FE608
;Registro de reloj del pwm0
SYSCTL_RCGCPWM_R  	EQU 0x400FE640
;Registro base del PWM0 0x4002.8000
PWM0_GENA_R			EQU 0x40028060 ; Contro del genrador de pwm0 A
PWM0_LOAD_R			EQU 0x40028050 ; Carga del pwm0 A
PWM0_CMPA_R			EQU 0x40028058 ; Comparador del pwm0 A
PWM0_CTL_R			EQU 0x40028040 ; Control del pwm0
PWM_ENABLE_R		EQU 0x40028008 ; Habilitacion del pwm
SYSCTL_RCC_R		EQU	0x400FE060 ; Configura el reloj del sistema y los osciladores, necesario para hacer la division del reloj del pwm
;-------------------------------------------------------------------------------------------------------------------------------------------------------
;Registros de pines-------------------------------------------------------------------------------------------------------------------------------------
;Entrada
I_TPI_PORTD_R         EQU 0x40007030 ; Pines: PD2=Timbre, PD3=abrir Puerta
I_PI_PORTE_R          EQU 0x4002400C ; Pines: PE0= cerar Puerta y PE1= encender/apagar Iluminacion
I_A_PORTC_R           EQU 0x400061C0 ; Pines: PC4=Aire frio, PC5= Aire caliente y PC6= apagar Aire
I_AM_PORTA_R          EQU 0x40004300 ; Pines: PA6=Automatico y PA7=Manual
;Salida
O_TPIA_PORTB_R        EQU 0x400053C8 ; Pines: PB7=Timbre, PB6=Puerta, PB5= Iluminacion, PB4= Aire frio, PB1 = Aire caliente
O_CONTROL_PORTF_R     EQU 0x40025038 ; Pines: PF1=Proceso, PF2=modo automatico y PF3= modo manual
;Constantes---------------------------------------------------------------------------------------------------------------------------------------------
CONST_DELAY_2S EQU 8000000
CONST_DELAY_4S EQU 16000000
CONST_DELAY_5S EQU 20000000
CONST_DELAY_500MS EQU 2000000 
CONST_DELAY_250MS EQU 1000000
CONST_DELAY_100MS EQU 400000
;-------------------------------------------------------------------------------------------------------------------------------------------------------

Start
;---------------------------------------------------------
    LDR R1, =SYSCTL_RCGCGPIO_R;Habilitacion del reloj para los puertos A, B, C, D y E
    LDR R0,[R1]
    ORR R0, R0,#0x3F
    STR R0,[R1]
    NOP
    NOP
    NOP
    NOP
;---------------------------------------------------------
    LDR R1,=SYSCTL_RCGCPWM_R ; inicializacion del reloj del PWM0
	LDR R0,[R1]
	ORR R0,R0,#0x01;
	STR R0,[R1]
	NOP
	NOP
	NOP
	NOP
;-----------------------Puertos  de entrada----------------
;----------------------------------------------------------
    LDR R1, = GPIO_PORTD_AMSEL_R;Configuración del puerto D
    LDR R0,[R1]
    BIC R0,R0,#0x0C
    STR R0,[R1]
    LDR R1, = GPIO_PORTD_AFSEL_R
    LDR R0,[R1]
    BIC R0,R0,#0x0C
    STR R0,[R1]
    LDR R1, = GPIO_PORTD_PCTL_R
    LDR R0,[R1]
    BIC R0,R0,#0x0000F000
    BIC R0,R0,#0x00000F00
    STR R0,[R1]
    LDR R1, = GPIO_PORTD_DIR_R
    LDR R0,[R1]
    BIC R0,R0,#0x0C
    STR R0,[R1]
    LDR R1, = GPIO_PORTD_DEN_R
    LDR R0,[R1]
    ORR R0,R0,#0x0C
    STR R0,[R1]
;----------------------------------------------------------
    LDR R1, = GPIO_PORTE_AMSEL_R;Configuración del puerto E
    LDR R0,[R1]
    BIC R0,R0,#0x03
    STR R0,[R1]
    LDR R1, = GPIO_PORTE_AFSEL_R
    LDR R0,[R1]
    BIC R0,R0,#0x03
    STR R0,[R1]
    LDR R1, = GPIO_PORTE_PCTL_R
    LDR R0,[R1]
    BIC R0,R0,#0x000000F0
    BIC R0,R0,#0x0000000F
    STR R0,[R1]
    LDR R1, = GPIO_PORTE_DIR_R
    LDR R0,[R1]
    BIC R0,R0,#0x03
    STR R0,[R1]
    LDR R1, = GPIO_PORTE_DEN_R
    LDR R0,[R1]
    ORR R0,R0,#0x03
    STR R0,[R1]
;-------------------------------------------------------------    
    LDR R1, = GPIO_PORTC_AMSEL_R;Configuración del puerto C
    LDR R0,[R1]
    BIC R0,R0,#0x70
    STR R0,[R1]
    LDR R1, = GPIO_PORTC_AFSEL_R
    LDR R0,[R1]
    BIC R0,R0,#0x70
    STR R0,[R1]
    LDR R1, = GPIO_PORTC_PCTL_R
    LDR R0,[R1]
    BIC R0,R0,#0x0F000000
    BIC R0,R0,#0x00F00000
    STR R0,[R1]
    LDR R1, = GPIO_PORTC_DIR_R
    LDR R0,[R1]
    BIC R0,R0,#0x7C
    STR R0,[R1]
    LDR R1, = GPIO_PORTC_DEN_R
    LDR R0,[R1]
    ORR R0,R0,#0x7C
    STR R0,[R1]
;-------------------------------------------------------------    
    LDR R1, = GPIO_PORTA_AMSEL_R;Configuración del puerto A
    LDR R0,[R1]
    BIC R0,R0,#0xC0
    STR R0,[R1]
    LDR R1, = GPIO_PORTA_AFSEL_R
    LDR R0,[R1]
    BIC R0,R0,#0xC0
    STR R0,[R1]
    LDR R1, = GPIO_PORTA_PCTL_R
    LDR R0,[R1]
    BIC R0,R0,#0xF0000000
    BIC R0,R0,#0x0F000000
    STR R0,[R1]
    LDR R1, = GPIO_PORTA_DIR_R
    LDR R0,[R1]
    BIC R0,R0,#0xC0
    STR R0,[R1]
    LDR R1, = GPIO_PORTA_DEN_R
    LDR R0,[R1]
    ORR R0,R0,#0xC0
    STR R0,[R1]
;-------------------------------------------------------------
;---------------Puerto de salida-----------------------------
	LDR R1, = GPIO_PORTB_AMSEL_R;Configuración del puerto B, habilitación de funcion alternativa para el pin PB6
    LDR R0,[R1]
    BIC R0,R0,#0xF2
    STR R0,[R1]
    LDR R1, = GPIO_PORTB_AFSEL_R
    LDR R0,[R1]
    BIC R0,R0,#0xB2
    ORR R0,R0,#0x40
    STR R0,[R1]
    LDR R1, = GPIO_PORTB_PCTL_R
    LDR R0,[R1]
    BIC R0,R0,#0xF0000000
    BIC R0,R0,#0x00F00000
    BIC R0,R0,#0x000F0000
	BIC R0,R0,#0x000000F0
    ORR R0,R0,#0x04000000
    STR R0,[R1]
    LDR R1, = GPIO_PORTB_DIR_R
    LDR R0,[R1]
    ORR R0,R0,#0xB2
    STR R0,[R1]
    LDR R1, = GPIO_PORTB_DEN_R
    LDR R0,[R1]
    ORR R0,R0,#0xF2
    STR R0,[R1]   
;-------------------------------------------------------------
    LDR R1, = GPIO_PORTF_AMSEL_R;Configuración del puerto F
    LDR R0,[R1]
    BIC R0,R0,#0x0E
    STR R0,[R1]
    LDR R1, = GPIO_PORTF_AFSEL_R
    LDR R0,[R1]
    BIC R0,R0,#0x0E
    STR R0,[R1]
    LDR R1, = GPIO_PORTF_PCTL_R
    LDR R0,[R1]
    BIC R0,R0,#0x000000F0
    BIC R0,R0,#0x0000F000
    BIC R0,R0,#0x00000F00
    STR R0,[R1]
    LDR R1, = GPIO_PORTF_DIR_R
    LDR R0,[R1]
    ORR R0,R0,#0x0E
    STR R0,[R1]
    LDR R1, = GPIO_PORTF_DEN_R
    LDR R0,[R1]
    ORR R0,R0,#0x0E
    STR R0,[R1]
;-------------------------------------------------------------
;Configuracion del PWM0---------------------------------------
	LDR R1,=SYSCTL_RCC_R;Activa el divisor de reloj para el PWM
	LDR R0,[R1]
	ORR R0,R0,#0x00100000
	STR R0,[R1]
	LDR R1,=SYSCTL_RCC_R;Divide la frecuencia de reloj entre 64 para ser de 250kHz
	LDR R0,[R1]
	ORR R0,R0,#0x000E0000
	STR R0,[R1]
	LDR R1,=PWM0_GENA_R;[3:2]Cuando el contador = LOAD pwmA estado Alto, cuando el contador disminuya pwmA estado bajo
	LDR R0,[R1]
	ORR R0,R0,#0xC8
	STR R0,[R1]
	LDR R1,=PWM0_LOAD_R; Carga el valor de 5000 para un periodo de 20ms
	LDR R0, [R1]
	MOV R0,#5000
	STR R0,[R1]
	LDR R1,=PWM0_CMPA_R; El contador esta configurado en modo descendente por lo tanto
	LDR R0,[R1]        ; Por lo tanto el valor a cargar en el comparador es (100%-%requerido)PWMLOAD
	LDR R3,=375 ; 0 grados del servo
	ORR R0, R0,R3
	STR R0,[R1]
	LDR R3,=0
	LDR R1,=PWM0_CTL_R; [1]=0,habilita el modo de conteo descendente desde el valor de PWMLOAD hasta 0 y se reinica
	LDR R0,[R1]       ;   y [0]=1,habilita el bloque generador de pwm.
	ORR R0, R0,#0x01
	STR R0, [R1]
	LDR R1,=PWM_ENABLE_R
	LDR R0,[R1]
	ORR R0, R0,#0x01
	STR R0, [R1]
;------------------------------------------------------------------------	
	LDR R3,=CONST_DELAY_2S
	LDR R4,=0x04
	B MAIN_LOOP

delay_Xs
	ADD R2,#1
	NOP
	NOP
	NOP
	NOP
	CMP R2,R3
	BNE delay_Xs
	BX LR

control_on
    LDR R1,=O_CONTROL_PORTF_R
    LDR R0,[R1]
    ORR R0,R0,#0x02
    STR R0,[R1]
    BX LR

control_off
    LDR R1,=O_CONTROL_PORTF_R
    LDR R0,[R1]
    BIC R0,R0,#0x02
    STR R0,[R1]
    BX LR

manual
    LDR R4,=0x08
    LDR R3,=CONST_DELAY_500MS
    BL control_on
    BL delay_Xs
    LDR R2,=0
    BL control_off
    B MAIN_LOOP

automatico
    LDR R4,=0x04
    LDR R3,=CONST_DELAY_500MS
    BL control_on
    BL delay_Xs
    LDR R2,=0
    BL control_off
    B MAIN_LOOP

timbre ; Dos opciones si esta en modo automatico o modo manual
    BL control_on
    LDR R3,=CONST_DELAY_250MS
    LDR R6,=0
    LDR R1,=O_TPIA_PORTB_R
    LDR R0,[R1]
;---------------------------------------
    ORR R0,R0,#0x80
    STR R0,[R1]
    BL delay_Xs
    LDR R2,=0
    BIC R0,R0,#0x80
    STR R0,[R1]
    BL delay_Xs
    LDR R2,=0
    CMP R4,#0x08;      
    BEQ.W MAIN_LOOP;si el modo es manual entonces regresa al programa principal
    ;Cuando el modo es automatico se sigue la jerarquia descrita en la propuesta
;------------- -90, se abre la puerta------------------------------------------
    LDR R3,=CONST_DELAY_4S
    LDR R1,=PWM0_CMPA_R
	LDR R0,=175
	STR R0,[R1]
	BL delay_Xs; Se abre por 4 segundos aproximadamente y luego se cierra
    LDR R2,=0 ; reseteo del contador para el retraso
    LDR R1,=PWM0_CMPA_R
	LDR R0,=375
	STR R0,[R1]
;----Se enciende el sistema de iluminacion-------------------------------------
    LDR R1,=O_TPIA_PORTB_R
    LDR R0,[R1]
    ORR R0,R0,#0x20
    STR R0,[R1]
;---Se enciende el sistema de aire 10 segundos despues por defecto el aire es frio
    LDR R3,=CONST_DELAY_5S
    BL delay_Xs
    LDR R2,=0
    BL delay_Xs
    LDR R2,=0 ; Termina el retraso de 10 segundos
    LDR R1,=O_TPIA_PORTB_R ; Se enciende el sistema de aire acondiciona con aire frio por defecto
    LDR R0,[R1]
    ORR R0,R0,#0x10
    STR R0,[R1]
;----Termina el modo automatico y se regresa al programa principal
    B MAIN_LOOP

puerta_o; abre la puerta en el modo manual
    CMP R4,#0x04
    BEQ MAIN_LOOP; si se encuentra en el modo automatico no realiza nada
    BL control_on
    LDR R1,=PWM0_CMPA_R
	LDR R0,=175
	STR R0,[R1]
    BL delay_Xs
    LDR R2,=0
    BL control_off
    B MAIN_LOOP

puerta_c; cierra la puerta en el modo manual
    CMP R4,#0x04
    BEQ MAIN_LOOP; si se encuentra en el modo automatico no realiza nada
    BL control_on
    LDR R1,=PWM0_CMPA_R
	LDR R0,=375
	STR R0,[R1]
    BL delay_Xs
    LDR R2,=0
    BL control_off
    B MAIN_LOOP

iluminacion
    CMP R4,#0x04
    BEQ MAIN_LOOP; si se encuentra en el modo automatico no realiza nada
    BL control_on
    LDR R1,=O_TPIA_PORTB_R 
    LDR R0,[R1]
	MOV R7,R0
    EOR R7,#0x20    
    BIC R7,#0xD2
    BIC R0,#0X20
    ORR R0,R7
    STR R0,[R1]
    BL delay_Xs
    LDR R2,=0
    BL control_off
    B MAIN_LOOP

aire_f
    CMP R4,#0x04
    BEQ MAIN_LOOP; si se encuentra en el modo automatico no realiza nada
    BL control_on
    LDR R1,=O_TPIA_PORTB_R 
    LDR R0,[R1]
    BIC R0,R0,#0x02
    ORR R0,R0,#0x10
    STR R0,[R1]
    BL delay_Xs
    LDR R2,=0
    BL control_off
    B MAIN_LOOP

aire_c
    CMP R4,#0x04
    BEQ MAIN_LOOP; si se encuentra en el modo automatico no realiza nada
    BL control_on
    LDR R1,=O_TPIA_PORTB_R 
    LDR R0,[R1]
    BIC R0,R0,#0x10
    ORR R0,R0,#0x02
    STR R0,[R1]
    BL delay_Xs
    LDR R2,=0
    BL control_off
    B MAIN_LOOP
aire_o
    CMP R4,#0x04
    BEQ MAIN_LOOP; si se encuentra en el modo automatico no realiza nada
    BL control_on
    LDR R1,=O_TPIA_PORTB_R 
    LDR R0,[R1]
    BIC R0,R0,#0x12
    STR R0,[R1]
    BL delay_Xs
    LDR R2,=0
    BL control_off
    B MAIN_LOOP

MAIN_LOOP
    BL control_off
;--------------Visualizacion de modo manual o automatico-------
    LDR R1,=O_CONTROL_PORTF_R
;    LDR R0,[R1]
    MOV R0,R4
    STR R0,[R1]
;--------------Seleccion modo manual o automatico--------------
    LDR R2,=0
    LDR R1,=I_AM_PORTA_R 
    LDR R0,[R1]
    LDR R3,=CONST_DELAY_100MS
    BL delay_Xs
    LDR R2,=0
    CMP R0,#0x80 ; Modo manual
    BEQ  manual
    CMP R0,#0x40 ; Modo automatico
    BEQ automatico
;--------------Lectura del Timbre, Puerta e Iluminacion----------
    LDR R1,=I_TPI_PORTD_R
    LDR R0,[R1]
    LDR R1,=I_A_PORTC_R
    LDR R5,[R1]
    LDR R1,= I_PI_PORTE_R   
    LDR R8,[R1]
    LDR R3,=CONST_DELAY_100MS ; Registros R0=PORTD, R5=PORTC y R8=PORTE para guardar los botones pulsados
    BL delay_Xs
    LDR R2,=0
    LDR R3,=CONST_DELAY_500MS
    CMP R0,#0x04 ; Se toco el timbre
    BEQ timbre
    CMP R0,#0x08 ; Abrir puerta
    BEQ puerta_o
    CMP R8,#0x01 ; Cerrar puerta
    BEQ puerta_c
    CMP R8,#0x02 ; Enciende/apaga iluminacion
    BEQ iluminacion
    CMP R5,#0x10 ; Aire frio
    BEQ aire_f
    CMP R5,#0x20 ; Aire caliente
    BEQ aire_c
    CMP R5,#0x40 ; Apagar aire
    BEQ aire_o

	B MAIN_LOOP
	ALIGN
	END	