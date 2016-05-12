all:
	clang -Wall -framework Foundation -framework ApplicationServices main.m -o cgorigin
clean:
	rm cgorigin
