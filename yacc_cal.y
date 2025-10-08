%{
#include <stdio.h>
#include <stdlib.h>
int yylex();
int yyerror();
%}

%token NUMBER
%left '+' '-'
%left '*' '/'
%right UMINUS

%%
lines:
      lines expr '\n'   { printf("Result = %g\n", $2); }
    | lines '\n'
    | /* empty */
    ;

expr:
      expr '+' expr     { $$ = $1 + $3; }
    | expr '-' expr     { $$ = $1 - $3; }
    | expr '*' expr     { $$ = $1 * $3; }
    | expr '/' expr     { $$ = $1 / $3; }
    | '-' expr %prec UMINUS { $$ = -$2; }
    | '(' expr ')'      { $$ = $2; }
    | NUMBER
    ;
%%

int main() {
    printf("Enter expressions (press Ctrl+D to end):\n");
    yyparse();
    return 0;
}

int yyerror() {
    printf("Syntax Error!\n");
    return 1;
}
