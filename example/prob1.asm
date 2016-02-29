;Prefixing
;Take a sequence a1 a2 a3 a4 a5 . . . as an input and output the sequence 0 a1 a2 a3 . . ., that is,
;the sequence that is the same as the input sequence, but starting with a single 0 character.

DEF i
DEF o
DEF r
MOV r2, 0 	;First output variable to be 0. r2 is 0 anyway but nice to make it explicit.

main:
	NXT i, stdin
	MOV r1, i1
	MOV o[1], r2
	NXT stdout, o
	MOV r2, r1
	TSTN r2, main, @END

	bs r[1], 0