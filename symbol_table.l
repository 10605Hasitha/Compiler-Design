%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

struct symbol {
    char name[10];
    char type[15];
    int addr;
} symtab[50];

int count = 0;
int address = 1000; // starting memory address
%}

%%
[a-zA-Z] {
    symtab[count].name[0] = yytext[0];
    symtab[count].name[1] = '\0';
    strcpy(symtab[count].type, "identifier");
    symtab[count].addr = address;
    address += 2;
    count++;
}
[+\-\*/=] {
    symtab[count].name[0] = yytext[0];
    symtab[count].name[1] = '\0';
    strcpy(symtab[count].type, "operator");
    symtab[count].addr = address;
    address += 2;
    count++;
}
[\$] {
    printf("\n\nSymbol Table:\n");
    printf("---------------------------\n");
    printf("Symbol\tType\t\tAddress\n");
    printf("---------------------------\n");
    for (int i = 0; i < count; i++)
        printf("%s\t%s\t%d\n", symtab[i].name, symtab[i].type, symtab[i].addr);
    printf("---------------------------\n");
    exit(0);
}
.|\n ;
%%

int main() {
    printf("Enter expression ending with $: ");
    yylex();
    return 0;
}
