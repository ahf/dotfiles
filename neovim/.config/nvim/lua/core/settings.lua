--
-- Alexander Hansen Færøy <ahf@0x90.dk>
-- OpenPGP: 1C1B C007 A9F6 07AA 8152
--          C040 BEA7 B180 B149 1921
--
-- Neovim Settings.
--

-- Disable line wrapping.
vim.o.wrap = false

-- Allow backspacing over auto-indent, line breaks, and at the start of an
-- insert.
vim.o.backspace = "indent,eol,start"

-- Use UNIX end-lines (\n).
vim.o.fileformat = "unix"

-- Use expanded tabs (spaces instead of tabs).
vim.o.expandtab = true

-- Use 4 spaces for <Tab>.
vim.o.tabstop=4

-- Use 4 spaces for <Tab> when auto-indenting.
vim.o.shiftwidth = 4
