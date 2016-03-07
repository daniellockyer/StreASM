main:
	MOV r1,3
	TSTB r1, 2, main, notmain
notmain:
	MOV r2, 54323
