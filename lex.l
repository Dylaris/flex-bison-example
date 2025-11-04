DIGIT [0-9]
ID    [a-zA-Z][a-zA-Z0-9]*

/* match keyword before identifier */

%%

int        return INT;
return     return RETURN;
repeat     return REPEAT;
void       return VOID;

{ID}       { yylval.s_value = strdup(yytext); return ID;     }
{DIGIT}+   { yylval.i_value = atoi(yytext);   return NUMBER; }
"\"".*"\"" { yylval.s_value = strndup(yytext+1, strlen(yytext)-2); return STRLIT; }
"("        return OPAREN;
")"        return CPAREN;
"{"        return OCURLY;
"}"        return CCURLY;
";"        return SEMICOLON;
[" "\n]
