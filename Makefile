PC=fpc -gv -g
TWOD=$(wildcard */*/*.pas)

all:
	fpc Main.pas

vim:
	nvim Main.pas $(TWOD)

run:
	./Main

memcheck:
	valgrind --leak-check=full ./Main --read-var-info

clean:
	find . -type f -name '*.o' -delete
	find . -type f -name '*.ppu' -delete
	rm Main
