PC=fpc -glh
TWOD=$(wildcard */*/*.pas)

all:
	$(PC) Main.pas

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
	git add README.md GraphingPackage/ Main.pas Makefile docs/uml.* FunctionalCFG/ FileIO/

clean:
	find . -type f -name '*.o' -delete
	find . -type f -name '*.ppu' -delete
	rm Main
