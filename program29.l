%{
#include <stdio.h>
#include <stdlib.h>
%}

%option noyywrap

%%
[ \t]+    { /* Count whitespace (spaces and tabs) */ }
\n        { /* Count newline characters */ }
.         ; /* Ignore all other characters */

%%

int main(int argc, char* argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <input_file>\n", argv[0]);
        return 1;
    }

    FILE* file = fopen(argv[1], "r");
    if (!file) {
        fprintf(stderr, "Error: Cannot open input file %s\n", argv[1]);
        return 1;
    }

    int whitespace_count = 0;
    int newline_count = 0;
    int c;

    yyin = file;
    while ((c = yylex()) != 0) {
        if (c == ' ' || c == '\t') {
            whitespace_count++;
        } else if (c == '\n') {
            newline_count++;
        }
    }

    fclose(file);

    printf("Whitespace count: %d\n", whitespace_count);
    printf("Newline count: %d\n", newline_count);

    return 0;
}
