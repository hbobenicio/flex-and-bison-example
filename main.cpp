/**
 * flex -o lexer.cpp lexer.l && g++ -Wall -pedantic -g -std=c++14 lexer.cpp main.cpp -o main -lfl
 */
#include <iostream>
#include <cstdio>
#include <cstdlib>
#include <cassert>
#include <string>

using namespace std;

extern "C" int yylex();
extern "C" int yyparse();
extern "C" FILE *yyin;

int main(int argc, char* argv[])
{
    if (argc == 2) {
        FILE* inputFile = fopen(argv[1], "r");
        if (!inputFile) {
            cerr << "Couldn't open file '" << string(argv[1]) << "'. Aborting." << endl;
            return EXIT_FAILURE;
        }
        yyin = inputFile;
    }

    //yylex();

	// parse through the input until there is no more:
	do {
		yyparse();
	} while (!feof(yyin));

    return 0;
}
