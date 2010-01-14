.PHONY: all clean
OOC_FLAGS=-v -t -shout -driver=sequence

all:
	ooc main ${OOC_FLAGS}

clean:
	rm -rfv ooc_tmp/ main
