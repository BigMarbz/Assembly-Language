.ORIG x3100


CONSTANT_CHECK
	AND R2, R2, #0
	ldi R0, KPDR
	BRz STOP_SOUND
	BRnp CHECK_INPUT
	ADD R2, R1, R0
	BRz CONSTANT_CHECK
	BRnp CHECK_INPUT

CHECK_INPUT
;; Checks current input key and directs it towards right tone
	ldi R0, KPDR
	ldi R1, KPDR
	NOT R1,R1
	ADD R1, R1, #1
	LD R3, TESTKEY
	ADD R0, R0, R3
	ADD R0, R0, #-1
	BRZ PLAYKEY1
	ADD R0, R0, #-1
	BRZ PLAYKEY2
	ADD R0, R0, #-1
	BRZ PLAYKEY3
	ADD R0, R0, #-1
	BRZ PLAYKEY4
	ADD R0, R0, #-1
	BRZ PLAYKEY5
	ADD R0, R0, #-1
	BRZ PLAYKEY6
	ADD R0, R0, #-1
	BRZ PLAYKEY7
	ADD R0, R0, #-1
	BRZ PLAYKEY8
	ADD R0, R0, #-1
	BRZ PLAYKEY9

PLAYKEY1
;; Plays key1 frequency
	AND R4, R4, #0
	LD R4, NOTE1
	STI R4, FGCR
	STI R4, FGDR
	BRnzp CONSTANT_CHECK
PLAYKEY2
;; Plays key2 frequency
	AND R4, R4, #0
	LD R4, NOTE2
	STI R4, FGCR
	STI R4, FGDR
	BRnzp CONSTANT_CHECK

PLAYKEY3
;; Plays key3 frequency
	AND R4, R4, #0
	LD R4, NOTE3
	STI R4, FGCR
	STI R4, FGDR
	BRnzp CONSTANT_CHECK

PLAYKEY4
;; Plays key4 frequency
	AND R4, R4, #0
	LD R4, NOTE4
	STI R4, FGCR
	STI R4, FGDR
	BRnzp CONSTANT_CHECK

PLAYKEY5
;; Plays key5 frequency
	AND R4, R4, #0
	LD R4, NOTE5
	STI R4, FGCR
	STI R4, FGDR
	BRnzp CONSTANT_CHECK

PLAYKEY6
;; Plays key6 frequency
	AND R4, R4, #0
	LD R4, NOTE6
	STI R4, FGCR
	STI R4, FGDR
	BRnzp CONSTANT_CHECK

PLAYKEY7
;; Plays key7 frequency
	AND R4, R4, #0
	LD R4, NOTE7
	STI R4, FGCR
	STI R4, FGDR
	BRnzp CONSTANT_CHECK

PLAYKEY8
;; Plays key8 frequency
	AND R4, R4, #0
	LD R4, NOTE8
	STI R4, FGCR
	STI R4, FGDR
	BRnzp CONSTANT_CHECK

PLAYKEY9
;; Plays key9 frequency
	AND R4, R4, #0
	LD R4, NOTE9
	STI R4, FGCR
	STI R4, FGDR
	BRnzp CONSTANT_CHECK

STOP_SOUND
	AND R6,R6,#0
	STI R6, FGDR
	STI R6, FGCR
	BRnzp CONSTANT_CHECK

TESTKEY .FILL xFFD0
KEY1 .FILL x0031
KEY2 .FILL x0032
KEY3 .FILL x0033
KEY4 .FILL x0034
KEY5 .FILL x0035
KEY6 .FILL x0036
KEY7 .FILL x0037
KEY8 .FILL x0038
KEY9 .FILL x0039
KPDR .FILL x4400
KPSR .FILL x4402
FGDR .FILL x4408
FGCR .FILL x440a
NOTE1 .FILL x01B8
NOTE2 .FILL x01D2
NOTE3 .FILL x01ED
NOTE4 .FILL x020B
NOTE5 .FILL x022A
NOTE6 .FILL x024B
NOTE7 .FILL x026E
NOTE8 .FILL x02BA
NOTE9 .FILL x030F
.END