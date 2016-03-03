;Prefixing
;Take a sequence a1 a2 a3 a4 a5 . . . as an input and output the sequence 0 a1 a2 a3 . . ., that is,
;the sequence that is the same as the input sequence, but starting with a single 0 character.

	MOV r2, 0 	;First output variable to be 0. r2 is 0 anyway but nice to make it explicit.
	MOV o0, 1
main:
	NXT i, stdin
	MOV r1, i1
	MOV o1, r2
	NXT stdout, o
	MOV r2, r1
	TSTZ i0, main, @END
