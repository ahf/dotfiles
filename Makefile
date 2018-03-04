TARGET   ?= $(HOME)
PACKAGES ?= git

all: init stow

stow: $(PACKAGES)
	stow -t $(TARGET) $(PACKAGES)

init:
	git submodule update --init --recursive

submodule-update:
	git submodule update --remote --rebase

.PHONY: all stow init submodule-update
