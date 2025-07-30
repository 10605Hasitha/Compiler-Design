%{
#include <stdio.h>

int characters = 0;
int words = 0;
int spaces = 0;
int lines = 0;

int in_word = 0;  // flag to track if currently inside a word
%}

%%
[ \t]                  { spaces++; in_word = 0; characters += yyleng; }
\n                     { lines++; spaces++; in_word = 0; characters++; }
[a-zA-Z0-9]+           { words++; characters += yyleng; in_word = 1; }
.                      { characters++; in_word = 0; }
%%

int yywrap() {
    return 1;
}

int main(int argc, char *argv[]) {
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            perror("Cannot open file");
            return 1;
        }
        yyin = file;
    } else {
        printf("Enter input (Ctrl+D to end):\n");
    }

    yylex();

    printf("Characters = %d\n", characters);
    printf("Words = %d\n", words);
    printf("Spaces = %d\n", spaces);
    printf("Lines = %d\n", lines);

    return 0;
}
