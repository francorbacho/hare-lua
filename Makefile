LIBS := $(shell pkg-config --libs lua5.4)

demo:
	hare build $(LIBS) cmd/demo

run:
	hare run $(LIBS) cmd/demo

clean:
	rm -rf demo

.PHONY: clean demo run
