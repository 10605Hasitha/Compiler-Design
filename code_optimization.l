%{
#include<stdio.h>
#include<string.h>

char expr[20][50];
int count = 0;

int isDuplicate(char *s) {
    for (int i = 0; i < count; i++) {
        if (strcmp(expr[i], s) == 0)
            return 1;
    }
    return 0;
}
%}

%%
[a-zA-Z][a-zA-Z0-9]*[ ]*=[ ]*[a-zA-Z0-9\+\-\*/ ]+ {
    if (!isDuplicate(yytext)) {
        strcpy(expr[count++], yytext);
    }
}
.|\n ;
%%

int main() {
    printf("Enter intermediate code (end with Ctrl+D):\n");
    yylex();

    printf("\nOptimized Code:\n");
    for (int i = 0; i < count; i++)
        printf("%s\n", expr[i]);

    return 0;
}
