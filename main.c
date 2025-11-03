#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s)
{
    printf("%s\n", s);
}

extern int yylex(void);
#include "parse.tab.c"
#include "lex.yy.c"

int yywrap(void)
{
    return 18;
}

int main(void)
{
    int ret = yyparse();
    // asm("int3");
    printf("ret = %d\n", ret);
    return 0;
}
