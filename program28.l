%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
%}

%option noyywrap

%%

"+"     { printf("Operator: +\n"); }
"-"     { printf("Operator: -\n"); }
"*"     { printf("Operator: *\n"); }
"/"     { printf("Operator: /\n"); }

[ \t\n] ;  // skip whitespace, tabs, and newlines

.       ;  // catch-all rule for unrecognized characters

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

    yyin = file;
    yylex();

    fclose(file);
    return 0;
}
