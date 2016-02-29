;Accumulator
;Take a sequence a1 a2 a3 a4 . . . and output the sequence a1 a1+a2 a1+a2+a3 a1+a2+a3+a4 . . .,
;where each term of the output is the sum of all the input terms up to that point.

MOV r2, 0 ;Initialise total to 0. r2 is 0 anyway but nice to make it explicit.

main:
	READ r1, stdin ;Read input and store in r1
	CMPNULL r1, @END ;Jump to end if null
	ADD r2, r1 ;Add the number to our total
	OUT r2 ;Output the total
	JMP main ;Loop around to main
