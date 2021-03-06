%{
#include <cstdio>
#include <iostream>
using namespace std;

// stuff from flex that bison needs to know about:
extern "C" int yylex();
extern "C" int yyparse();
extern "C" FILE *yyin;

extern int line_number;
 
void yyerror(const char *s);
%}

// Bison fundamentally works by asking flex to get the next token, which it
// returns as an object of type "yystype".  But tokens could be of any
// arbitrary data type!  So we deal with that in Bison by defining a C union
// holding each of the types of tokens that Flex could return, and have Bison
// use that union instead of "int" for the definition of "yystype":
%union {
	int ival;
	float fval;
	char *sval;
}

// define the constant-string tokens:
%token SEMICOLON
%token ENDL

// define the "terminal symbol" token types I'm going to use (in CAPS
// by convention), and associate each with a field of the union:
%token <ival> INT
%token <fval> FLOAT
%token <sval> ID
%token <sval> OP
%token <sval> STRING_LITERAL

//%type<foo> value

%start file_grammar

%%

// this is the actual grammar that bison will parse, but for right now it's just
// something silly to echo to the screen what bison gets from flex.  We'll
// make a real one shortly:
file_grammar :  /* empty */
             | file_grammar exp
             ;

exp          : ID OP value SEMICOLON endls {
                   cout << "Bison found filter expression: "
                        << $1 << " " << $2 << " $exp" << '\n';
               }
             ;

value        : INT                        { cout << "Bison found a int: " << $1 << '\n'; /*$$ = $1;*/ }
             | FLOAT                      { cout << "Bison found a float: " << $1 << '\n'; }
             | STRING_LITERAL             { cout << "Bison found a string literal: " << $1 << '\n'; }
             ;

endls        : endls ENDL
             | ENDL
             ;

%%

void yyerror(const char *s) {
	cout << "Parse error on line " << line_number << "!  Message: " << s << '\n';
	// might as well halt now:
	exit(-1);
}
