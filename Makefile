SASSC=sass
TSC=tsc
CC=clang
WASM2WAT=wasm2wat

CFLAGS=--target=wasm32 \
	   -O3 \
	   -flto \
	   -nostdlib \
	   -Wl,--no-entry \
	   -Wl,--export-all \
	   -Wl,--lto-O3
TSCFLAGS=--target esnext

SCRIPT_DIR=scripts
STYLES_DIR=styles
WASM_DIR=wasm
SERVER_DIR=server
export SERVER_DIR

SCRIPT_OUT_DIR=$(SCRIPT_DIR)/out
STYLES_OUT_DIR=$(STYLES_DIR)/out
WASM_OUT_DIR=$(WASM_DIR)/out
SERVER_OUT_DIR=$(SERVER_DIR)/out
export SERVER_OUT_DIR

SCRIPT_SRCS=index.ts
STYLES_SRCS=style.scss
WASM_SRCS=add.cpp
GO_SRCS=$(shell find $(SERVER_DIR) -type f -name "*.go" -printf "%P\n")
export GO_SRCS

SCRIPT_OUTPUT=$(SCRIPT_SRCS:%.ts=%.js)
STYLES_OUTPUT=$(STYLES_SRCS:%.scss=%.css)
WASM_OUTPUT=$(WASM_SRCS:%.cpp=%.wasm)
HUMAN_READABLE_WASM_OUTPUT=$(WASM_OUTPUT:%.wasm=%.wasm_text)
SERVER_OUTPUT=server
export SERVER_OUTPUT

all: $(SCRIPT_OUT_DIR)/$(SCRIPT_OUTPUT) $(STYLES_OUT_DIR)/$(STYLES_OUTPUT) $(WASM_OUT_DIR)/$(WASM_OUTPUT) server

$(SCRIPT_OUT_DIR)/$(SCRIPT_OUTPUT): $(SCRIPT_DIR)/$(SCRIPT_SRCS)
	$(TSC) $(TSCFLAGS) $< --out $@

$(STYLES_OUT_DIR)/$(STYLES_OUTPUT): $(STYLES_DIR)/$(STYLES_SRCS)
	$(SASSC) $< $@

$(WASM_OUT_DIR)/$(WASM_OUTPUT): $(WASM_DIR)/$(WASM_SRCS)
	mkdir -p $(WASM_OUT_DIR)
	$(CC) $(CFLAGS) $< -o $@

server: $(SERVER_DIR)/$(GO_SRCS)
	@# TODO: Find out why this doesn't track
	$(MAKE) -C $(SERVER_DIR)

.PHONY: run clean human-readable-wasm

run: all
	@# TODO: Make this use variables
	$(SERVER_DIR)/out/server
	#./run.py

human-readable-wasm: $(WASM_OUT_DIR)/$(WASM_OUTPUT)
	$(WASM2WAT) $< -o $(WASM_OUT_DIR)/$(HUMAN_READABLE_WASM_OUTPUT)

clean:
	rm -rf $(SCRIPT_OUT_DIR) $(STYLES_OUT_DIR) $(WASM_OUT_DIR)
