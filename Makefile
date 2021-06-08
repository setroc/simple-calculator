all: programa

#Regla que compila el programa principal
programa: lex.yy.c sintactico.tab.c
	gcc lex.yy.c sintactico.tab.c -lfl -lm
sintactico.tab.c: sintactico.y
	bison sintactico.y -d
lex.yy.c: lexico.l
	flex lexico.l