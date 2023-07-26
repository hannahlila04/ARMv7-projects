/* Program that counts consecutive 1's */

          .text                   // executable code follows
          .global _start 
		  
_start:   MOV	  R4, #TEST_NUM
		  LDR	  R1, [R4]
		  MOV	  R5, #0
		  MOV	  R6, #0
		  MOV	  R7, #0 
		  MOV	  R10, #0 // initializing counting registers
		  
LOOP1:	  MOV	  R8, R1 
		  CMP	  R8, #0
		  BEQ	  END // main loop to go through words list
		  
		  BL	  ONES // ones checking
		  CMP	  R0, R5
		  BLT	  SKIP1
		  MOV	  R5, R0 // updates r5 if r0 is > r5, otherwise continues
		  
SKIP1:	  MOV	  R1, R8 // checking the longest string of 0s
		  MVN	  R1, R1 
		  BL	  ONES // zeros checking
		  CMP	  R0, R6
		  BLT	  SKIP2
		  MOV	  R6, R0 // updates r6 if r0 > r6

SKIP2:	  MOV	  R1, R8 // this checks alternating
		  BL	  ALTERNATE 
RETURN:	  CMP	  R0, R7
		  BLT	  SKIP
		  MOV	  R7, R0 // alternate checking
		  
SKIP:	  ADD	  R4, #4
		  LDR	  R1, [R4]
		  B		  LOOP1
	
ONES:     MOV     R0, #0          // R0 will hold the result
LOOP2:    CMP     R1, #0          // loop until the data contains no more 1's
          MOVEQ   PC, LR             
          LSR     R2, R1, #1      // perform SHIFT, followed by AND
          AND     R1, R1, R2      
          ADD     R0, #1          // count the string length so far
          B       LOOP2		
	
ALTERNATE:MOV     R0, #0          // R0 will hold the result
		  MOV	  R11, #XOR_NUM
		  LDR	  R11, [R11]
		  EOR	  R1, R11
		  MOV	  R9, R1
		  BL	  ONES
		  CMP	  R0, R10
		  BLT	  SKIP3
		  MOV	  R10, R0		  
SKIP3:	  MOV	  R1, R9
		  MVN	  R1, R1
		  BL	  ONES
	 	  CMP	  R0, R10
		  BLT	  SKIP4
		  MOV	  R10, R0
SKIP4:	  MOV	  R0, R10
		  B		  RETURN

END:      B       END             

TEST_NUM: .word   0x103fe00f, 0x100ff0e1, 0x100cdae1, 0x010cc030, 0x10fff0e1, 0x55555555, 0x01, 0xffffffff, 0x0
// 10000001111111110000000001111, 10000000011111111000011100001,
// 10000000011001101101011100001, 1000011001100000000110000,
// 10000111111111111000011100001, 1010101010101010101010101010101
// 00000000000000000000000000001, 1111111111111111111111111111111
XOR_NUM:  .word	  0x55555555

          .end                            
