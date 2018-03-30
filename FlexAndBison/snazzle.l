%{
#include <iostream>

#define YY_DECL extern "C" int yylex()
%}

%%

[ \t\n]			; // Do Nothing
[0-9]+\.[0-9]+		{ std::cout << "Found a float: " << yytext << std::endl; }
[0-9]+			{ std::cout << "Found an integer: " << yytext << std::endl; }
[a-zA-Z0-9]+		{ std::cout << "Found a string: " << yytext << std::endl; }

%%

int main(int argc, char* argv[]) {

  yylex();

  return 0;
}

