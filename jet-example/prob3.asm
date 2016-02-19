;Stream arithmetic
;Take two sequences a1 a2 a3 a4 ... and b1 b2 b3 b4 ..., and produce the sequence
;	a1 + 3b1 a2 + 3b2 a3 + 3b3 a4 + 3b4 ...

;Need to do checking for two variables on every input read but worry about that later.

main:
	MOV r1, stdin
	TSTSNN r1		;Terminate if end of stream
	JMP @END		
	SPLIT r2, r1, 0		;Save the first variable in r2
	SPLIT r3, r1, 1		;Save the second variable in r3
	TSTSNN r1		;Terminate if we did not have a second parameter in r1
	JMP @END			
	MLT r3, 3		;Multiply the second by 3
	ADD r1, r2, r3		;r1 = r2 + r3
	MOV stdout, r1		;Output the result
	NXT stdin
	JMP main
