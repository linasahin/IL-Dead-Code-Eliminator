%{
#include "parser.tab.h"
#include <stdlib.h>
#include <string.h>
%}

%%

[ \t\r\n]+               ;

"{"                      { return LBRACE; }
"}"                      { return RBRACE; }
","                      { return COMMA; }
";"                      { return SEMICOLON; }
"="                      { return ASSIGN; }

"+"                      { return PLUS; }
"-"                      { return MINUS; }
"*"                      { return STAR; }
"/"                      { return SLASH; }
"^"                      { return CARET; }

[0-9]+                   { yylval.ival = atoi(yytext); return NUMBER; }

[a-zA-Z_][a-zA-Z0-9_]*   { yylval.sval = strdup(yytext); return ID; }

.                        ;

%%

int yywrap(void) { return 1; }
