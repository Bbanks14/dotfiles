local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Select all
keymap.set("n", "<Leader>a", "ggVG", opts)

-- Save / quit
keymap.set("n", "<Leader>w", ":update<CR>", opts)
keymap.set("n", "<Leader>q", ":quit<CR>", opts)
keymap.set("n", "<Leader>Q", ":wqa<CR>", opts)

-- Tabs
keymap.set("n", "<Leader>Te", ":tabedit<CR>", opts)
keymap.set("n", "<Leader>Tn", ":tabnext<CR>", opts)
keymap.set("n", "<Leader>Tp", ":tabprev<CR>", opts)
keymap.set("n", "<Leader>Tw", ":tabclose<CR>", opts)

-- Splits
keymap.set("n", "ss", ":split<CR>", opts)
keymap.set("n", "sv", ":vsplit<CR>", opts)

-- Move/resize window (Alt keys for terminal compatibility)
keymap.set("n", "<A-h>", "<C-w><", opts)
keymap.set("n", "<A-l>", "<C-w>>", opts)
keymap.set("n", "<A-k>", "<C-w>+", opts)
keymap.set("n", "<A-j>", "<C-w>-", opts)

-- Diagnostics
keymap.set("n", "<C-j>", function()
  vim.diagnostic.goto_next({
    severity = vim.diagnostic.severity.ERROR,
    float = { border = "rounded" },
  })
end, opts)
