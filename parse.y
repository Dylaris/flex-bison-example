%union {
    char *s_value;
    int i_value;
    Stmt *stmt_value;
}

%token <i_value> NUMBER
%token <s_value> ID STRLIT
%token OPAREN CPAREN OCURLY CCURLY SEMICOLON /* punctuation */
%token INT VOID RETURN REPEAT /* keyword */

%type <stmt_value> stmt

%%
start: main
     ;
main: INT ID OPAREN VOID CPAREN block
    ;
block: OCURLY stmt_list CCURLY
     {
        for (size_t i = stmts.count; i > 0; i--) {
            stmt_eval(stmts.items[i-1]);
        }
     }
     ;
stmt_list: /* empty */
         | stmt stmt_list
         {
            /* stmt is pushed into array in reversed order */
            da_append(&stmts, $1);
         }
         ;
stmt: ID OPAREN STRLIT CPAREN SEMICOLON
    {
        $$ = stmt_printf($3);
    }
    | RETURN NUMBER SEMICOLON
    {
        $$ = stmt_return($2);
    }
    | REPEAT NUMBER stmt
    {
        $$ = stmt_repeat($2, $3);
    }
    ;
