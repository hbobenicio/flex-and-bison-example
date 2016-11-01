%{
    #include <iostream>
    using namespace std;
    #define YY_DECL extern "C" int yylex()

    #include "grammar.h"

    int line_number = 1;
%}

/* We're parsing only one file at a time.*/
/* There is no need for a custom yywrap function*/
%option noyywrap

whitespace      [ \t]
endl            \n
integer         -?[0-9]+
float           -?[0-9]+\.[0-9]+
string          [a-zA-Z0-9]+
id              {string}(-{string})*
string_literal  \"{string}\"|\'{string}\'
op              "="|"<="|">="|"<"|">"|"!="
semicolon       ";"

%%

{whitespace}    ;
{endl}          { line_number++; return ENDL; }

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

{id}            {
                    cout << "Flex found a id: " << yytext << endl;
                    // we have to copy because we can't rely on yytext not changing underneath us:
                    yylval.sval = strdup(yytext);
                    return ID;
                }

{string_literal} {
                    cout << "Flex found a string literal: " << yytext << endl;
                    yylval.sval = strdup(yytext);
                    return STRING_LITERAL;
                 }

{op}            {
                    cout << "Flex found a operator: " << yytext << endl;
                    // we have to copy because we can't rely on yytext not changing underneath us:
                    yylval.sval = strdup(yytext);
                    return OP;
                }

{semicolon}     {
                    cout << "Flex found a semicolon" << endl;
                    return SEMICOLON;
                }

.               ;

%%
