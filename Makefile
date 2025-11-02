.PHONY: all
all: main
	./main < hello.c

main: main.c lex.yy.c
	gcc -Wall -Wextra -Wno-unused-function -ggdb -o main main.c

lex.yy.c: lex.l
	flex lex.l

.PHONY: clean
clean:
	rm -f main lex.yy.c
