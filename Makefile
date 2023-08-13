LIBS := $(shell pkg-config --libs lua)

demo:
	hare build $(LIBS) cmd/demo

run:
	hare run $(LIBS) cmd/demo

clean:
	rm -rf demo

.PHONY: clean demo run
