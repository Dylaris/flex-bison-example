#include <stdio.h>
#include <stdlib.h>

typedef enum {
    STMT_RETURN,
    STMT_PRINTF,
    STMT_REPEAT,
} Stmt_Type;

typedef struct Stmt Stmt;

struct Stmt {
    Stmt_Type type;
    union {
        int exit_code;
        const char *message;
        struct {
            size_t count;
            Stmt *body;
        };
    };
};

typedef struct {
    Stmt **items;
    size_t count;
    size_t capacity;
} Stmt_List;

#define da_append(da, item)                                                      \
do {                                                                             \
    if ((da)->count == (da)->capacity) {                                         \
        (da)->capacity = (da)->capacity < 8 ? 8 : 2*(da)->capacity;              \
        (da)->items = realloc((da)->items, sizeof(*(da)->items)*(da)->capacity); \
    }                                                                            \
    (da)->items[(da)->count++] = (item);                                         \
} while (0)

static Stmt_List stmts = {0};

Stmt *stmt_printf(const char *message)
{
    Stmt *stmt = malloc(sizeof(Stmt));
    stmt->type = STMT_PRINTF;
    stmt->message = message;
    return stmt;
}

Stmt *stmt_return(int code)
{
    Stmt *stmt = malloc(sizeof(Stmt));
    stmt->type = STMT_RETURN;
    stmt->exit_code = code;
    return stmt;
}

Stmt *stmt_repeat(size_t count, Stmt *body)
{
    Stmt *stmt = malloc(sizeof(Stmt));
    stmt->type = STMT_REPEAT;
    stmt->count = count;
    stmt->body = body;
    return stmt;
}

void stmt_eval(Stmt *stmt)
{
    switch (stmt->type) {
    case STMT_PRINTF:
        printf("%s\n", stmt->message);
        break;
    case STMT_RETURN:
        printf("exit code: %d\n", stmt->exit_code);
        break;
    case STMT_REPEAT:
        for (size_t i = 0; i < stmt->count; i++) {
            stmt_eval(stmt->body);
        }
        break;
    }
}

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
    printf("ret = %d\n", ret);
    return 0;
}
