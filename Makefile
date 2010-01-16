.PHONY: all clean
OOC_FLAGS+=-v -t -shout -driver=sequence -sourcepath=source/ -noclean
APP=bvz

all:
	ooc main -o=${APP} ${OOC_FLAGS}

clean:
	rm -rfv ooc_tmp/ ${APP}
