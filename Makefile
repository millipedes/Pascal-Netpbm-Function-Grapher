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

feh:
	feh --auto-reload docs/uml.png&

plant:
	plantuml docs/uml.txt
	convert docs/uml.png -channel RGB -negate docs/uml.png

gitadd:
	git add README.md GraphingPackage/ Main.pas Makefile docs/uml.*

clean:
	find . -type f -name '*.o' -delete
	find . -type f -name '*.ppu' -delete
	rm Main
