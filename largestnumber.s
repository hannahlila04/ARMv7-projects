/* Program that finds the largest number in a list of integers	*/
            
            .text                   // executable code follows
            .global _start                  
_start:                             
            MOV     R4, #RESULT     // R4 points to result location
            LDR     R0, [R4, #4]    // R0 holds the number of elements in the list
            MOV     R1, #NUMBERS    // R1 points to the start of the list
			MOV R2, R0 //Store number of elements in R2 isntead of R0
			LDR R0, [R1] //R0 holds the largest number so far
            BL      LARGE           
            STR     R0, [R4]        // R0 holds the subroutine return value
			
      

/* Subroutine to find the largest integer in a list
 * Parameters: R0 has the number of elements in the list
 *             R1 has the address of the start of the list
 * Returns: R0 returns the largest item in the list */
 
LARGE:      SUBS R2, #1 //Reduce total number of items in the list
			BEQ DONE //only one item was in list, result is 0 so exit loop
			ADD R1, #4 //change R1's value to the adress of the next number in list
			LDR R3, [R1] //R3 holds the value of next number in the list
			CMP R0, R3 //Check if R3 is larger than R2
			BGE LARGE 
			MOV R0, R3 //Update Largest Number
			B LARGE
			
DONE:		STR R0, [R4]

END:        B       END       

RESULT:     .word   0           
N:          .word   7           // number of entries in the list
NUMBERS:    .word   4, 5, 3, 6  // the data
            .word   1, 8, 2                 

            .end                            
