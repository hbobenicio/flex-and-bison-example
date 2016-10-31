# flex -o lexer.cpp lexer.l && g++ -Wall -pedantic -g -std=c++14 lexer.cpp main.cpp -o main -lfl && ./main input

CXX_FLAGS = -Wall -Wno-sign-compare -Wno-unused-function -pedantic -g -std=c++14
TARGET_NAME = main
LIBS=-lfl

all: main

main: lexer.o grammar.o main.cpp
	g++ $(CXX_FLAGS) lexer.o grammar.o main.cpp -o $(TARGET_NAME) $(LIBS)

lexer.o: grammar.cpp lexer.cpp
	g++ $(CXX_FLAGS) -c lexer.cpp $(LIBS)

lexer.cpp: lexer.l
	flex -o lexer.cpp lexer.l

grammar.o: grammar.cpp
	g++ $(CXX_FLAGS) -c grammar.cpp $(LIBS)

grammar.cpp: grammar.y
	bison -v --defines=grammar.h --output=grammar.cpp grammar.y

run:
	./$(TARGET_NAME) input

clean:
	rm -f *.o grammar.h grammar.cpp grammar.output lexer.cpp $(TARGET_NAME)
