%{
#include <stdio.h>
#include <string.h>

#define MAX_IDENTIFIER_LENGTH 31

// Function to check if a string is a keyword
int isKeyword(char* str) {
    // List of example keywords (expand as needed)
    char* keywords[] = {
        "int", "char", "float", "double", "if", "else", "while", "for", "return"
    };
    int num_keywords = sizeof(keywords) / sizeof(keywords[0]);

    for (int i = 0; i < num_keywords; ++i) {
        if (strcmp(str, keywords[i]) == 0) {
            return 1;
        }
    }
    return 0;
}
%}

%option noyywrap

DIGIT       [0-9]
LETTER      [a-zA-Z]
IDENTIFIER  {LETTER}({LETTER}|{DIGIT}|"_")*
%%
{IDENTIFIER} {
    if (strlen(yytext) <= MAX_IDENTIFIER_LENGTH) {
        if (!isKeyword(yytext)) {
            printf("Valid identifier: %s\n", yytext);
        } else {
            printf("Invalid identifier (keyword): %s\n", yytext);
        }
    } else {
        printf("Invalid identifier (too long): %s\n", yytext);
    }
}
.|\n        ; // skip all other characters

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
