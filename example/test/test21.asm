	MOV r0, 0

collect:
	NXT i, stdin
	TSTZ i0, reverse, @NEXT
	INCR r0
	MOV r[r0], i1
	JMP collect

reverse:
	TSTZ r0, @END, @NEXT
	MOV o1, r[r0]
	NXT stdout, o
	DECR r0
	JMP reverse