#include <stdio.h>
#include <stdlib.h>

#define da_append(da, item)                                           \
do {                                                                  \
    if ((da)->count == (da)->capacity) {                              \
        (da)->capacity = (da)->capacity < 8 ? 8 : 2 * (da)->count;    \
        (da)->items = realloc((da)->items, sizeof(*(da)->items) * (da)->capacity); \
        if (!(da)->items) exit(1);                                    \
    }                                                                 \
    (da)->items[(da)->count++] = (item);                              \
} while (0)

typedef enum {
    TOKEN_INTEGER,
    TOKEN_IDENTIFIER,
    TOKEN_STRLIT,
    TOKEN_OPAREN,
    TOKEN_CPAREN,
    TOKEN_OCURLY,
    TOKEN_CCURLY,
    TOKEN_SEMICOLON,
} Token;

typedef struct {
    Token *items;
    size_t count;
    size_t capacity;
} Tokens;

static Tokens tokens = {0};

#include "lex.yy.c"

int yywrap(void)
{
    return 18;
}

int main(void)
{
    int ret = yylex();
    printf("ret = %d\n", ret);
    return 0;
}
