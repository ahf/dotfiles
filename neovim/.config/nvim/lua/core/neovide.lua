--
-- Alexander Hansen Færøy <ahf@0x90.dk>
-- OpenPGP: 1C1B C007 A9F6 07AA 8152
--          C040 BEA7 B180 B149 1921
--
-- Neovim Neovide specific settings.
--

if not vim.g.neovide then
    return
end

-- Set the scale factor of 1.0.
vim.g.neovide_scale_factor = 1.0

-- Hide the mouse while we are typing.
vim.g.neovide_hide_mouse_when_typing = true

-- Disable the cursor animation entirely.
vim.g.neovide_cursor_animation_length = 0

-- Disable the scroll animation entirely.
vim.g.neovide_scroll_animation_length = 0
