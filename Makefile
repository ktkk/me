SASSC=sass
TSC=tsc
CC=clang

CFLAGS=--target=wasm32 -emit-llvm -S -O3 -flto -nostdlib -Wl,--no-entry -Wl,--export-all -Wl,-lto-all

SCRIPT_DIR=scripts
STYLES_DIR=styles
WASM_DIR=wasm

SCRIPT_OUT_DIR=$(SCRIPT_DIR)/out
STYLES_OUT_DIR=$(STYLES_DIR)/out
WASM_OUT_DIR=$(WASM_DIR)/out

SCRIPT_SRCS=index.ts
STYLES_SRCS=style.scss
WASM_SRCS=add.cpp

SCRIPT_OUTPUT=$(SCRIPT_SRCS:%.ts=%.js)
STYLES_OUTPUT=$(STYLES_SRCS:%.scss=%.css)
WASM_OUTPUT=$(WASM_SRCS:%.cpp=%.wasm)

all: $(SCRIPT_OUT_DIR)/$(SCRIPT_OUTPUT) $(STYLES_OUT_DIR)/$(STYLES_OUTPUT) $(WASM_OUT_DIR)/$(WASM_OUTPUT)

$(SCRIPT_OUT_DIR)/$(SCRIPT_OUTPUT): $(SCRIPT_DIR)/$(SCRIPT_SRCS)
	$(TSC) $< --out $@

$(STYLES_OUT_DIR)/$(STYLES_OUTPUT): $(STYLES_DIR)/$(STYLES_SRCS)
	$(SASSC) $< $@

$(WASM_OUT_DIR)/$(WASM_OUTPUT): $(WASM_DIR)/$(WASM_SRCS)
	mkdir -p $(WASM_OUT_DIR)
	$(CC) $(CFLAGS) $< -o $@

.PHONY: run clean

run: all
	./run.py

human-readable-wasm: $(WASM_OUT_DIR)/$(WASM_OUTPUT)
	$(WASM2WAT) $< -o $(WASM_OUT_DIR)/$(HUMAN_READABLE_WASM_OUTPUT)

clean:
	rm -rf $(SCRIPT_OUT_DIR) $(STYLES_OUT_DIR) $(WASM_OUT_DIR)
