%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_IDENTIFIER_LENGTH 31

// Token types
enum {
    IDENTIFIER = 1,
    CONSTANT,
    OPERATOR,
    COMMENT,
    UNKNOWN
};

char current_token[MAX_IDENTIFIER_LENGTH + 1];
%}

%option noyywrap

%%

[ \t\n]                  ; // skip whitespace and newlines

"//"(.)*                 ; // skip single-line comments

"/*"([^*]|[\r\n]|(\*+([^*/]|[\r\n])))*\*+"/" ; // skip multi-line comments

[a-zA-Z_][a-zA-Z0-9_]*  {
                            strncpy(current_token, yytext, MAX_IDENTIFIER_LENGTH);
                            current_token[MAX_IDENTIFIER_LENGTH] = '\0';
                            printf("Token: %s, Type: %d\n", current_token, IDENTIFIER);
                         }

[0-9]+                   {
                            strncpy(current_token, yytext, MAX_IDENTIFIER_LENGTH);
                            current_token[MAX_IDENTIFIER_LENGTH] = '\0';
                            printf("Token: %s, Type: %d\n", current_token, CONSTANT);
                         }

[-+*/=<>!]+              {
                            strncpy(current_token, yytext, MAX_IDENTIFIER_LENGTH);
                            current_token[MAX_IDENTIFIER_LENGTH] = '\0';
                            printf("Token: %s, Type: %d\n", current_token, OPERATOR);
                         }

.                        ; // catch-all rule for unrecognized characters

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
