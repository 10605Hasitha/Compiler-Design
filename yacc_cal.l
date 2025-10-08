%{
#include "y.tab.h"
#include <ctype.h>
%}

%%

[0-9]+(\.[0-9]+)?   { yylval = atof(yytext); return NUMBER; }
[ \t]               ;   /* ignore spaces */
[\n]                { return '\n'; }
.                   { return yytext[0]; }

%%
int yywrap() { return 1; }
