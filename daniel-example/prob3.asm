;Stream arithmetic
;Take two sequences a1 a2 a3 a4 ... and b1 b2 b3 b4 ..., and produce the sequence
;	a1 + 3b1 a2 + 3b2 a3 + 3b3 a4 + 3b4 ...

;Need to do checking for two variables on every input read but worry about that later.
;TODO - finish this.

READ r1, stdin
CMPNULL r1, @END
SPLIT r2, r1, 0 ;Save the first variable in r2
OUT r2 ;Output the first variable

main:
	READ r1, stdin
	CMPNULL r1, @END
	JMP main