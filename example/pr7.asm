;Copying + Stream Arithmetic
;Take two sequences a1 a2 a3 a4 ...
;and b1 b2 b3 b4 ...
;and produce two sequences
;a1 - b1, a2 - b2, a3 - b3, a4 - b4, ...
;a1,      a2,      a3,      a4,      ...

main:
	NXT i, stdin	;Get the input
	TSTZ i0, @END, @NEXT
	SUB o1, i1, i2	;Col 1 = i1 - i2
	MOV o2, i1		;Col 2 = i1
	NXT stdout, o
	JMP main		;Loop

