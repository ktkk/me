SASSC=sass
TSC=tsc
#CC=clang
#WASM2WAT=wasm2wat

#CFLAGS=--target=wasm32 \
#		-O3 \
#		-flto \
#		-nostdlib \
#		-Wl,--no-entry \
#		-Wl,--export-all \
#		-Wl,--lto-O3
TSCFLAGS=--target esnext --removeComments --preserveConstEnums --sourceMap --module esnext

SCRIPT_DIR=scripts
#WASM_DIR=wasm
STYLES_DIR=styles
SITE_DIR=_site

SCRIPT_OUT_DIR=$(SITE_DIR)/$(SCRIPT_DIR)/out
#WASM_OUT_DIR=$(WASM_DIR)/out
STYLES_OUT_DIR=$(SITE_DIR)/$(STYLES_DIR)/out

SCRIPT_SRCS=$(shell find $(SCRIPT_DIR) -type f -name "*.ts")
#WASM_SRCS=$(shell find $(WASM_DIR) -type f -name "*.cpp")
STYLES_SRCS=style.scss

SCRIPT_OUTPUT=index.js
STYLES_OUTPUT=$(STYLES_SRCS:%.scss=%.css)
SERVER_OUTPUT=server

all: $(SCRIPT_OUT_DIR)/$(SCRIPT_OUTPUT) $(STYLES_OUT_DIR)/$(STYLES_OUTPUT) motif static-files #$(WASM_OUT_DIR)/$(WASM_OUTPUT)

$(SCRIPT_OUT_DIR)/$(SCRIPT_OUTPUT): $(SCRIPT_SRCS)
	@mkdir -p $(SITE_DIR)
	$(TSC) $(TSCFLAGS) $^ --sourceRoot $(SCRIPT_DIR) --rootDir $(SCRIPT_DIR) --outDir $(SCRIPT_OUT_DIR)

$(STYLES_OUT_DIR)/$(STYLES_OUTPUT): $(STYLES_DIR)/$(STYLES_SRCS)
	@mkdir -p $(SITE_DIR)
	$(SASSC) $< $@

#$(WASM_OUT_DIR)/$(WASM_OUTPUT): $(WASM_SRCS)
#	mkdir -p $(WASM_OUT_DIR)

motif:
	$(MAKE) -C styles/motif-css

static-files: index.html assets/ motif
	@mkdir -p $(SITE_DIR)
	cp index.html $(SITE_DIR)/index.html
	cp -r assets/ $(SITE_DIR)/assets/
	@mkdir -p $(SITE_DIR)/styles/motif-css
	cp -r styles/motif-css/css/ $(SITE_DIR)/styles/motif-css/css/

.PHONY: run clean #human-readable-wasm

run: all
	./run.py

#human-readable-wasm: $(WASM_OUT_DIR)/$(WASM_OUTPUT)
#	$(WASM2WAT) $< -o $(WASM_OUT_DIR)/$(HUMAN_READABLE_WASM_OUTPUT)

clean:
	rm -rf \
		$(SCRIPT_OUT_DIR) \
		$(STYLES_OUT_DIR) \
		$(SITE_DIR)
#		$(WASM_OUT_DIR)
