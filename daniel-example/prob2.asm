;Copying
;Take a sequence a1 a2 a3 a4 a5 . . . as an input and output two copies of it

main:
	READ r1, stdin ;Read stdin and store in r1
	CMPNULL r1, @END ;Jump to end if null
	OUT r1, r1 ;Output r1 twice
	JMP main ;Loop back around to main