SASSC=sass
TSC=tsc
#CC=clang
#WASM2WAT=wasm2wat

#CFLAGS=--target=wasm32 \
#	   -O3 \
#	   -flto \
#	   -nostdlib \
#	   -Wl,--no-entry \
#	   -Wl,--export-all \
#	   -Wl,--lto-O3
TSCFLAGS=--target esnext --removeComments --preserveConstEnums --sourceMap --module esnext

SCRIPT_DIR=scripts
STYLES_DIR=styles
#WASM_DIR=wasm
SERVER_DIR=server
export SERVER_DIR

SCRIPT_OUT_DIR=$(SCRIPT_DIR)/out
STYLES_OUT_DIR=$(STYLES_DIR)/out
#WASM_OUT_DIR=$(WASM_DIR)/out
SERVER_OUT_DIR=$(SERVER_DIR)/out
#export SERVER_OUT_DIR

SCRIPT_SRCS=$(shell find $(SCRIPT_DIR) -type f -name "*.ts")
STYLES_SRCS=style.scss
#WASM_SRCS=$(shell find $(WASM_DIR) -type f -name "*.cpp")
#GO_SRCS=$(shell find $(SERVER_DIR) -type f -name "*.go" -printf "%P\n")
#export GO_SRCS

#SCRIPT_OUTPUT=$(patsubst $(SCRIPT_DIR)/%.ts, $(SCRIPT_OUT_DIR)/%.js, $(SCRIPT_SRCS))
SCRIPT_OUTPUT=index.js
STYLES_OUTPUT=$(STYLES_SRCS:%.scss=%.css)
#WASM_OUTPUT=out.wasm
#HUMAN_READABLE_WASM_OUTPUT=$(WASM_OUTPUT:%.wasm=%.wasm_text)
SERVER_OUTPUT=server
#export SERVER_OUTPUT

all: $(SCRIPT_OUT_DIR)/$(SCRIPT_OUTPUT) $(STYLES_OUT_DIR)/$(STYLES_OUTPUT) $(WASM_OUT_DIR)/$(WASM_OUTPUT) $(SERVER_OUT_DIR)/$(SERVER_OUTPUT)

$(SCRIPT_OUT_DIR)/$(SCRIPT_OUTPUT): $(SCRIPT_SRCS)
	$(TSC) $(TSCFLAGS) $^ --sourceRoot $(SCRIPT_DIR) --rootDir $(SCRIPT_DIR) --outDir $(SCRIPT_OUT_DIR)

$(STYLES_OUT_DIR)/$(STYLES_OUTPUT): $(STYLES_DIR)/$(STYLES_SRCS)
	$(SASSC) $< $@

#$(WASM_OUT_DIR)/$(WASM_OUTPUT): $(WASM_SRCS)
#	mkdir -p $(WASM_OUT_DIR)
#	$(CC) $(CFLAGS) $^ -o $@

#$(SERVER_OUT_DIR)/$(SERVER_OUTPUT): $(SERVER_DIR)/$(GO_SRCS)
#	@$(MAKE) -C $(SERVER_DIR) --no-print-directory

.PHONY: run clean human-readable-wasm

run: all
	$(SERVER_OUT_DIR)/$(SERVER_OUTPUT)
	#./run.py

#human-readable-wasm: $(WASM_OUT_DIR)/$(WASM_OUTPUT)
#	$(WASM2WAT) $< -o $(WASM_OUT_DIR)/$(HUMAN_READABLE_WASM_OUTPUT)

clean:
	rm -rf \
		$(SCRIPT_OUT_DIR) \
		$(STYLES_OUT_DIR) \
#		$(WASM_OUT_DIR) \
#		$(SERVER_OUT_DIR)
