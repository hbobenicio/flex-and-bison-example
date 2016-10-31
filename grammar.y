%{
#include <cstdio>
#include <iostream>
using namespace std;

// stuff from flex that bison needs to know about:
extern "C" int yylex();
extern "C" int yyparse();
extern "C" FILE *yyin;
 
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
	char *opval;
}

// define the "terminal symbol" token types I'm going to use (in CAPS
// by convention), and associate each with a field of the union:
%token <ival> INT
%token <fval> FLOAT
%token <sval> STRING
%token <opval> OP

%%
// this is the actual grammar that bison will parse, but for right now it's just
// something silly to echo to the screen what bison gets from flex.  We'll
// make a real one shortly:
snazzle:
	snazzle INT      { cout << "Bison found an int: " << $2 << endl; }
	| snazzle FLOAT  { cout << "Bison found a float: " << $2 << endl; }
	| snazzle STRING { cout << "Bison found a string: " << $2 << endl; }
	| snazzle OP     { cout << "Bison found a operator: " << $2 << endl; }
	| INT            { cout << "Bison found an int: " << $1 << endl; }
	| FLOAT          { cout << "Bison found a float: " << $1 << endl; }
	| STRING         { cout << "Bison found a string: " << $1 << endl; }
	| OP             { cout << "Bison found a operator: " << $1 << endl; }
	;
%%

void yyerror(const char *s) {
	cout << "Parse error!  Message: " << s << endl;
	// might as well halt now:
	exit(-1);
}
