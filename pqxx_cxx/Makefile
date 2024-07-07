LFLAGS= -lpqxx -lpq

all: clean main

main: main.cpp clientmanager.cpp
	g++ main.cpp clientmanager.cpp -o main ${LFLAGS}
	./main

clean: 
	rm -rf main