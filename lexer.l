%{
    #include <iostream>
    using namespace std;
    #define YY_DECL extern "C" int yylex()

    #include "grammar.h"
%}

%option noyywrap

whitespace      [ \t\n]
integer         [0-9]+
float           [0-9]+\.[0-9]+
string          [a-zA-Z0-9]+
op              "="|"<="|">="|"<"|">"|"!="

%%

{whitespace}    ;

{float}         {
                    cout << "Flex found a float: " << yytext << endl;
                    yylval.fval = atof(yytext);
                    return FLOAT;
                }

{integer}       {
                    cout << "Flex found an int: " << yytext << endl;
                    yylval.ival = atoi(yytext);
                    return INT;
                }

{string}        {
                    cout << "Flex found a string: " << yytext << endl;
                    // we have to copy because we can't rely on yytext not changing underneath us:
                    yylval.sval = strdup(yytext);
                    return STRING;
                }

{op}            {
                    cout << "Flex found a operator: " << yytext << endl;
                    // we have to copy because we can't rely on yytext not changing underneath us:
                    yylval.opval = strdup(yytext);
                    return OP;
                }

.               ;

%%
