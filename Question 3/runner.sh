lex calculator.l
yacc -d calculator.y
gcc lex.yy.c y.tab.c -lm -o calculator
./calculator
