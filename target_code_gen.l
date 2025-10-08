%{
#include <stdio.h>
#include <string.h>
FILE *fp;

void generate_code(char *op, char *arg1, char *arg2, char *res) {
    if (strcmp(op, "+") == 0)
        fprintf(fp, "LOAD %s\nLOAD %s\nADD\nSTORE %s\n", arg1, arg2, res);
    else if (strcmp(op, "-") == 0)
        fprintf(fp, "LOAD %s\nLOAD %s\nSUB\nSTORE %s\n", arg1, arg2, res);
    else if (strcmp(op, "*") == 0)
        fprintf(fp, "LOAD %s\nLOAD %s\nMUL\nSTORE %s\n", arg1, arg2, res);
    else if (strcmp(op, "/") == 0)
        fprintf(fp, "LOAD %s\nLOAD %s\nDIV\nSTORE %s\n", arg1, arg2, res);
    else if (strcmp(op, "uminus") == 0)
        fprintf(fp, "LOAD -%s\nSTORE %s\n", arg1, arg2);
    else if (strcmp(op, "print") == 0)
        fprintf(fp, "OUT %s\n", arg1);
    else if (strcmp(op, "goto") == 0)
        fprintf(fp, "JMP %s\n", arg1);
    else
        fprintf(fp, "# Unknown operation: %s\n", op);
}
%}

%%
"+"[ \t]+[^ \t\n]+[ \t]+[^ \t\n]+[ \t]+[^ \t\n]+    { 
    char op[2], a[10], b[10], c[10];
    sscanf(yytext, "%s %s %s %s", op, a, b, c);
    generate_code("+", a, b, c);
}
"-"[ \t]+[^ \t\n]+[ \t]+[^ \t\n]+[ \t]+[^ \t\n]+    {
    char op[2], a[10], b[10], c[10];
    sscanf(yytext, "%s %s %s %s", op, a, b, c);
    generate_code("-", a, b, c);
}
"*"[ \t]+[^ \t\n]+[ \t]+[^ \t\n]+[ \t]+[^ \t\n]+    {
    char op[2], a[10], b[10], c[10];
    sscanf(yytext, "%s %s %s %s", op, a, b, c);
    generate_code("*", a, b, c);
}
"/"[ \t]+[^ \t\n]+[ \t]+[^ \t\n]+[ \t]+[^ \t\n]+    {
    char op[2], a[10], b[10], c[10];
    sscanf(yytext, "%s %s %s %s", op, a, b, c);
    generate_code("/", a, b, c);
}
"uminus"[ \t]+[^ \t\n]+[ \t]+[^ \t\n]+   {
    char op[10], a[10], b[10];
    sscanf(yytext, "%s %s %s", op, a, b);
    generate_code("uminus", a, b, NULL);
}
"print"[ \t]+[^ \t\n]+   {
    char op[10], a[10];
    sscanf(yytext, "%s %s", op, a);
    generate_code("print", a, NULL, NULL);
}
"goto"[ \t]+[^ \t\n]+   {
    char op[10], a[10];
    sscanf(yytext, "%s %s", op, a);
    generate_code("goto", a, NULL, NULL);
}
\n  { /* ignore newlines */ }
.   { /* ignore others */ }
%%

int main(int argc, char **argv) {
    if (argc < 2) {
        printf("Usage: %s inputfile\n", argv[0]);
        return 1;
    }
    fp = fopen("target.txt", "w");
    if (!fp) { perror("target.txt"); return 1; }
    yyin = fopen(argv[1], "r");
    if (!yyin) { perror(argv[1]); return 1; }

    yylex();

    fclose(fp);
    fclose(yyin);

    printf("\n--- Target Code Generated (target.txt) ---\n");
    system("cat target.txt");
    return 0;
}
