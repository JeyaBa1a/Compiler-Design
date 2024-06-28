%{
#include <stdio.h>
#include <string.h>

// Variable to keep count of the word occurrences
int count = 0;
char word[100];

// Function to compare the matched word with the given word
void check_word(char text[]) {
    if (strcmp(text, word) == 0) {
        count++;
    }
}

// Definition of yywrap
int yywrap() {
    return 1;
}
%}

%%

[[:alpha:]]+     { 
    char temp[100];
    strcpy(temp, yytext);
    check_word(temp); 
}

\n              { return 0; }

.               { /* Ignore other characters */ }

%%

int main() {
    char sentence[1000] = "";

    // Read the word to be counted
    printf("Enter the word to be counted: ");
    scanf("%s", word);

    // Clear input buffer
    getchar();

    // Read the sentence
    printf("Enter the sentence: ");
    fgets(sentence, sizeof(sentence), stdin);

    // Set up the input buffer
    yy_scan_string(sentence);

    // Run the lexer
    yylex();

    // Output the count
    printf("The word '%s' appears %d times.\n", word, count);

    return 0;
}
