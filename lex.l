DIGIT [0-9]
ID    [a-zA-Z][a-zA-Z0-9]*

%%

[" "\n] {}

{DIGIT}+ {
    da_append(&tokens, TOKEN_INTEGER);
}

{ID} {
    da_append(&tokens, TOKEN_IDENTIFIER);
}

"\"".*"\"" {
    da_append(&tokens, TOKEN_STRLIT);
}

"(" {
    da_append(&tokens, TOKEN_OPAREN);
}

")" {
    da_append(&tokens, TOKEN_CPAREN);
}

"{" {
    da_append(&tokens, TOKEN_OCURLY);
}

"}" {
    da_append(&tokens, TOKEN_CCURLY);
}

";" {
    da_append(&tokens, TOKEN_SEMICOLON);
}
