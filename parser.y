%code requires {
    typedef struct {
        char *text;
        int is_var;
        char *varname;
    } Operand;
}

%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex(void);
void yyerror(const char *s);

#define MAXLIVE 128
static char *live[MAXLIVE];
static int live_count = 0;

static int is_live(const char *v) {
    for (int i = 0; i < live_count; i++)
        if (strcmp(live[i], v) == 0) return 1;
    return 0;
}

static void add_live(const char *v) {
    if (!v) return;
    if (is_live(v)) return;
    if (live_count < MAXLIVE)
        live[live_count++] = strdup(v);
}

static void remove_live(const char *v) {
    if (!v) return;
    for (int i = 0; i < live_count; i++) {
        if (strcmp(live[i], v) == 0) {
            free(live[i]);
            live[i] = live[--live_count];
            return;
        }
    }
}

%}

%union {
    char *sval;
    int ival;
    Operand opnd;
}

%token <sval> ID
%token <ival> NUMBER

%token LBRACE RBRACE COMMA SEMICOLON ASSIGN
%token PLUS MINUS STAR SLASH CARET

%type <opnd> operand
%type <ival> binop

%start program

%%

program
    : live_line stmts
    ;

live_line
    : LBRACE id_list RBRACE
    ;

id_list
    : ID               { add_live($1); free($1); }
    | id_list COMMA ID { add_live($3); free($3); }
    ;

stmts
    :
    | stmts stmt
    ;

stmt
    : ID ASSIGN operand SEMICOLON
      {
        if (is_live($1)) {
            printf("%s=%s;\n", $1, $3.text);
            remove_live($1);
            if ($3.is_var) add_live($3.varname);
        }
        free($1);
        free($3.text);
      }
    | ID ASSIGN operand binop operand SEMICOLON
      {
        if (is_live($1)) {
            printf("%s=%s%c%s;\n", $1, $3.text, (char)$4, $5.text);
            remove_live($1);
            if ($3.is_var) add_live($3.varname);
            if ($5.is_var) add_live($5.varname);
        }
        free($1);
        free($3.text);
        free($5.text);
      }
    ;

binop
    : PLUS   { $$ = '+'; }
    | MINUS  { $$ = '-'; }
    | STAR   { $$ = '*'; }
    | SLASH  { $$ = '/'; }
    | CARET  { $$ = '^'; }
    ;

operand
    : ID
      {
        $$.text = $1;
        $$.is_var = 1;
        $$.varname = $1;
      }
    | NUMBER
      {
        char buf[64];
        snprintf(buf, sizeof(buf), "%d", $1);
        $$.text = strdup(buf);
        $$.is_var = 0;
        $$.varname = NULL;
      }
    | MINUS NUMBER
      {
        char buf[64];
        snprintf(buf, sizeof(buf), "-%d", $2);
        $$.text = strdup(buf);
        $$.is_var = 0;
        $$.varname = NULL;
      }
    | PLUS NUMBER
      {
        char buf[64];
        snprintf(buf, sizeof(buf), "+%d", $2);
        $$.text = strdup(buf);
        $$.is_var = 0;
        $$.varname = NULL;
      }
    ;

%%

int main(void) {
    return yyparse();
}

void yyerror(const char *s) {
    fprintf(stderr, "Parse error: %s\n", s);
}
