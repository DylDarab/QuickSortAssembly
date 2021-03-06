NumArr		DCD		138, 101, 217, 149, 57, 92, 96, 132, 48, 63, 233, 190, 178, 229, 37, 193, 227, 3, 53, 65
			
StackOne		DCD		-1,0,19,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30 ; index 1 and 2 is index first and index last
StackTwo		DCD		-1
			ADR		R0,NumArr ; R0 => Array
			ADR		R11,StackOne
			ADR		R12,StackTwo
			ADD		R11,R11,#8
			ADD		R12,R12,#4
			B		LOAD_PR
						
QUICKSORT
			CMP		R1,R2
			BGE		LOAD_PR
			B		PARTITION
			
PARTITION
			LDR		R3,[R0,R2,LSL #2] ; R3 => X
			SUB		R4,R1,#1 ; R4 => i
			MOV		R5,R1 ; R5 => j
			SUB		R6,R2,#1 ; R6 => r-1
			CMP		R5,R6
			BLE		LOOP
			
LOOP
			CMP		R5,#-1
			BEQ		STOP
			LDR		R7,[R0,R5,LSL #2] ; R7 => A[j]
			CMP		R7,R3 ; A[j] <= X
			BLE		SWAP
			B		LOOPGOON
			
LOOPGOON
			ADD		R5,R5,#1 ; j++
			CMP		R5,R6
			BLE		LOOP
			B		LOOPEND
			
SWAP
			ADD		R4,R4,#1 ; i++
			LDR		R8,[R0,R4,LSL #2] ; R8 => A[i]
			MOV		R13,R8 ; R13 => TEMP A[i]
			STR		R7,[R0,R4,LSL #2] ; A[i] = A[j]
			STR		R13,[R0,R5,LSL #2] ; A[j] = TEMP
			ADD		R5,R5,#1 ; j++
			CMP		R5,R6
			BLE		LOOP
			B		LOOPEND
			
LOOPEND
			ADD		R4,R4,#1 ; i++
			LDR		R8,[R0,R4,LSL #2] ; R8 => A[i]
			MOV		R13,R8 ; R13 => TEMP
			STR		R3,[R0,R4,LSL #2] ; A[i] = A[r]
			STR		R13,[R0,R2,LSL #2] ; A[r] = TEMP
					
			ADD		R11,R11,#4
			STR		R1,[R11]
			SUB		R1,R4,#1
			ADD		R11,R11,#4
			STR		R1,[R11]
			
			ADD		R12,R12,#4
			ADD		R1,R4,#1
			STR		R1,[R12]
			ADD		R12,R12,#4
			STR		R2,[R12]
				
			B		LOAD_PR
						
STOP
			END
			
LOAD_PR
			LDR		R2,[R11]
			CMP		R2,#-1
			BEQ		LOAD_PR_TWO
			SUB		R11,R11,#4
			LDR		R1,[R11]
			SUB		R11,R11,#4
			B		QUICKSORT
			
LOAD_PR_TWO
			LDR		R2,[R12]
			CMP		R2,#-1
			BEQ		STOP
			SUB		R12,R12,#4
			LDR		R1,[R12]
			SUB		R12,R12,#4
			B		QUICKSORT
