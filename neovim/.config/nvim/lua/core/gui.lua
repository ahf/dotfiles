--
-- Alexander Hansen Færøy <ahf@0x90.dk>
-- OpenPGP: 1C1B C007 A9F6 07AA 8152
--          C040 BEA7 B180 B149 1921
--
-- Neovim GUI settings.
--

if not vim.fn.has("gui_running") then
    return
end

-- Use Inconsolata (the nerd variant) as font.
vim.o.guifont = "Inconsolata Nerd Font Mono:h18"
