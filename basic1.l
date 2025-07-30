%{
#include <stdio.h>
int vowels = 0;
int cons = 0;
%}

%%
[aeiouAEIOU]              { vowels++; }
[b-df-hj-np-tv-zB-DF-HJ-NP-TV-Z]   { cons++; }
.|\n                     { /* Ignore other characters */ }
%%

int yywrap() {
    return 1;
}

int main() {
    printf("Enter the string.. at end press Ctrl+D (Unix/Linux) or Ctrl+Z (Windows)\n");
    yylex();
    printf("No of vowels = %d\nNo of consonants = %d\n", vowels, cons);
    return 0;
}
