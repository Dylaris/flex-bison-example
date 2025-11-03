%union {
    char *s_value;
    int i_value;
}

%token <i_value> NUMBER
%token <s_value> ID STRLIT
%token OPAREN CPAREN OCURLY CCURLY SEMICOLON /* punctuation */
%token INT VOID RETURN /* keyword */

%%
start: main
     ;
main: INT ID OPAREN VOID CPAREN block
    ;
block: OCURLY stmts CCURLY
     ;
stmts: /* empty */
     | stmt stmts
     ;
stmt: ID OPAREN STRLIT CPAREN SEMICOLON
    {
        printf("%s\n", $3);
    }
    | RETURN NUMBER SEMICOLON
    {
        exit($2);
    }
    ;
