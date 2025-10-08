%{
#include <stdio.h>
#include <string.h>

int temp = 1;
char lhs;
%}

%%

[a-zA-Z][ ]*=[ ]*[a-zA-Z0-9\+\-\*/]+ {
    char expr[100];
    strcpy(expr, yytext);

    // Split LHS and RHS
    char *eq = strchr(expr, '=');
    lhs = expr[0];
    char rhs[100];
    strcpy(rhs, eq + 1);

    printf("\nIntermediate Code Generation:\n");
    int len = strlen(rhs);
    for (int i = 0; i < len; i++) {
        if (rhs[i] == '+' || rhs[i] == '-' || rhs[i] == '*' || rhs[i] == '/') {
            char op1 = rhs[i - 1];
            char op2 = rhs[i + 1];
            printf("t%d = %c %c %c\n", temp, op1, rhs[i], op2);
            rhs[i + 1] = 't';   // replace operand2 with temp variable
            rhs[i + 2] = temp + '0';
            temp++;
        }
    }
    printf("%c = t%d\n", lhs, temp - 1);
}

.|\n   ;    // ignore other input
%%

int main() {
    printf("Enter an expression (e.g., a=b+c*d): ");
    yylex();
    return 0;
}
