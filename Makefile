DEST := $(HOME)/.local
BIN := $(DEST)/bin
CONFIG := $(HOME)/.config

SCRIPTS := src/panfig
CONFIGS := src/panfig.conf

.PHONY: install uninstall

install:
	mkdir -p $(BIN)
	mkdir -p $(CONFIG)
	cp $(SCRIPTS) $(BIN)
	cp $(CONFIGS) $(CONFIG)

