all: tests

tests:
	cd test && tools/roundup *roundup.sh

install:
	false TODO