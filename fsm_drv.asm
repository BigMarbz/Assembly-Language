
; This program controls the robot car in the following way:
;    Both LR track sensors ON (car is completely on track) => Drive Straight
;    Either LR track sensors OFF => Reverse the car
; Monitor the output (motors) by looking at address x4010 (memory mapped address for WDCR)

.orig x3000

;; This implements the steering using an FSM-style design with two states


DRIVE_STATE
	;; The car is completely on the track
	and R0, R0, #0        ; R0 <- 0 (which is 0000 binary)
	and R2, R2, #0        ; Clear R2
	and R1, R1, #0        ; Clear R1

	                       ; Use indirect addressing mode to write to WDCR (at address 0x4010)
	sti R0, WDCR_ADDR      ; Drive forward (all four motors OFF)

	ldi R1, LSDR_ADDR      ; Use indirect load to read LSDR (at address 0x4000)

	add R2, R1, #-3        ; Is it equal to 3 (equals 11 binary)?
	brz DRIVE_STATE        ; If yes, then stay in DRIVE state
                               ;If not fall back to reverse state

	and R2, R2, #0        ; Clear R2
	and R1, R1, #0        ; Clear R1
	ldi R1, LSDR_ADDR      ; Use indirect load to read LSDR (at address 0x4000)
	add R2, R1, #-1        ; Is it equal to 1 (equals 01 binary)?
	brz TURN_LEFT        ; If yes, then go to turn right state

	and R2, R2, #0        ; Clear R2
	and R1, R1, #0        ; Clear R1
	ldi R1, LSDR_ADDR      ; Use indirect load to read LSDR (at address 0x4000)
	add R2, R1, #-2        ; Is it equal to 2 (equals 10 binary)?
	brz TURN_LEFT        ; If yes, then go to turn left state

REVERSE_STATE
	;; The car is at least partially off the track
	and R0, R0, #0        ; Clear R0
	and R2, R2, #0        ; Clear R2
	and R1, R1, #0        ; Clear R1
	add R0, R0, #15	      ; R0 <- 15  (which is 1111 binary)

	                       ; Use indirect addressing mode to write to WDCR
	sti R0, WDCR_ADDR      ; Reverse (all four motors in REVERSE)

	ldi R1, LSDR_ADDR      ; Use indirect load to view value at 0x4000 

	and R2, R2, #0        ; Clear R2
	and R1, R1, #0        ; Clear R1
	ldi R1, LSDR_ADDR      ; Use indirect load to read LSDR (at address 0x4000)
	add R2, R1, #-1        ; Is it equal to 1 (equals 01 binary)?
	brz TURN_LEFT        ; If yes, then go to turn right state

	and R2, R2, #0        ; Clear R2
	and R1, R1, #0        ; Clear R1
	ldi R1, LSDR_ADDR      ; Use indirect load to read LSDR (at address 0x4000)
	add R2, R1, #-2        ; Is it equal to 2 (equals 10 binary)?
	brz TURN_LEFT        ; If yes, then go to turn left state

	add R2, R1, #-3        ; Is it equal to 3 (equals 11 binary)?
	brz DRIVE_STATE        ; If yes, then move back to DRIVE state		

	brnzp REVERSE_STATE       ; Stay within the REVERSE state



TURN_LEFT
;; Car is left of track
        and R0, R0, #0        ; Clear R0
	and R2, R2, #0        ; Clear R2
	and R1, R1, #0        ; Clear R1

	add R0, R0, #10	      ; R0 <- 10  (which is 1010 binary)

	                       ; Use indirect addressing mode to write to WDCR
	sti R0, WDCR_ADDR      ; Turn Left (left wheels powered back right wheels powered forward)

	ldi R1, LSDR_ADDR      ; Use indirect load to view value at 0x4000 

	add R2, R1, #-3        ; Is it equal to 3 (equals 11 binary)?
	brz DRIVE_STATE        ; If yes, then move back to DRIVE state	

	add R2, R1, #-1        ; Is it equal to 1 (equals 01 binary)?
	brz TURN_RIGHT          ; If yes, then go to TURN_RIGHT STATE	

	brnzp TURN_LEFT       ; Stay within the TURN_LEFT state

	
TURN_RIGHT
;; Car is right of track
        and R0, R0, #0        ; Clear R0
	and R2, R2, #0        ; Clear R2
	and R1, R1, #0        ; Clear R1
	add R0, R0, #5	      ; R0 <- 5  (which is 0101 binary)

	                       ; Use indirect addressing mode to write to WDCR
	sti R0, WDCR_ADDR      ; Turn Right(right wheels powered back left wheels powered forward)

	ldi R1, LSDR_ADDR      ; Use indirect load to view value at 0x4000 

	add R2, R1, #-3        ; Is it equal to 3 (equals 11 binary)?
	brz DRIVE_STATE        ; If yes, then move back to DRIVE state	
	
	add R2, R1, #-2        ; Is it equal to 2 (equals 10 binary)?
	brz TURN_LEFT          ; If yes, then go to TURN_LEFT STATE

	brnzp TURN_RIGHT       ; Stay within TURN-RIGHT


;; Data
LSDR_ADDR                      ; Helper variable which contains the memory mapped address used to 
                               ;  read the sensors
	.fill x4000

WDCR_ADDR		       ; Another helper variable. Used to access the wheel/motor controls
	.fill x4010

.end
