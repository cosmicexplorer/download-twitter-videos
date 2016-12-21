.PHONY: all clean

NPM_DIR := node_modules
NPM_BIN := $(NPM_DIR)/.bin
COFFEE_CC := $(NPM_BIN)/coffee

COFFEE_SRC := $(wildcard *.coffee)
JS_OBJ := $(COFFEE_SRC:%.coffee=%.js)

all: $(JS_OBJ)

clean:
	rm -f $(JS_OBJ)

%.js: %.coffee $(COFFEE_CC)
	$(COFFEE_CC) -bc --no-header $<

$(COFFEE_CC):
	npm install
