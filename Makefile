TARGET   ?= $(HOME)
PACKAGES ?= \
			gdb     \
			git     \
			gnupg   \
			mutt    \
			npm     \
			tmux    \
			vim     \
			xorg    \

all: init stow

stow: $(PACKAGES)
	stow -t $(TARGET) $(PACKAGES)

init:
	git submodule update --init --recursive

submodule-update:
	git submodule update --remote --rebase

.PHONY: all stow init submodule-update
