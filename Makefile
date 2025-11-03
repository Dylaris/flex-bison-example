# ./main < hello.c

.PHONY: all
all: main

main: main.c lex.yy.c parse.tab.c
	gcc -Wall -Wextra -Wno-unused-function -ggdb -o main main.c

parse.tab.c: parse.y
	bison parse.y

lex.yy.c: lex.l
	flex lex.l

.PHONY: clean
clean:
	rm -f main lex.yy.c parse.tab.c
