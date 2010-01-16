.PHONY: all clean
OOC_FLAGS+=-v -g -t -shout -driver=sequence -sourcepath=source/ -noclean
APP=bvz

all:
	ooc main -o=${APP} ${OOC_FLAGS}

slave:
	OOC_FLAGS="-slave" make

clean:
	rm -rfv ooc_tmp/
