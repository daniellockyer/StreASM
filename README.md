# plc

| SYNTAX | DESC |
|---|---|
| ADD dest, src1, src2 | |
| SUB dest, src1, src2 | |
| MUL dest, src1, src2 | |
| DIV dest, src1, src2 | |
|---|---|
| TSTZ reg, if0, ifn0 | |
| TSTE reg1, reg2, ifeq, ifneq | |
| TSTG reg1, reg2, ifg, ifng | |
| TSTGE reg1, reg2, ifge, ifnge | |
| TSTL reg1, reg2, ifl, ifnl | |
| TSTLE reg1, reg2, ifle, ifnle | |
|---|---|
| AND dest, src1, src2 | |
| OR dest, src1, src2 | |
| NOR dest, src1, src2 | |
| XOR dest, src1, src2 | |
| NAND dest, src1, src2 | |
| COM dest, src1 | |
|---|---|
| JMP label | |
| CALL label | |
| RET | |
| MOV dest, src | |
| CLR reg | |
| BS reg, bit | |
| BC reg, bit | |
| BT reg, bit, if1, if0 | |
| INCR reg | |
| DECR ref | |
|---|---|
| NXT name, name | |
| @END | |
| @NEXT | PC+1 |
