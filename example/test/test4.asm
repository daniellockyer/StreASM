main:
	MOV r2, 0
	ADD r3, r2, r2
	MOV r4, 1
	TSTZ r4, main, notmain
notmain:
	ADD r4, 4, 4
