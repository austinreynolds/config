local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local keymap = vim.api.nvim_set_keymap

-- NERDTree
vim.cmd "let NERDTreeShowHidden=1"
keymap("n", "<leader>nn", ":NERDTreeToggle<cr>", opts)
keymap("n", "<leader>nf", ":NERDTreeFind<cr>", opts)

-- Commentary
keymap("n", "<leader>/", ":Commentary<cr>", opts)
keymap("v", "<leader>/", ":Commentary<cr>", opts)


-- fzf/ripgrep
keymap("n", "<leader>ff", ":Files!<cr>", opts)
keymap("n", "<leader>fg", ":GFiles<cr>", opts)
keymap("n", "<leader>b", ":Buffers<cr>", opts)
keymap("n", "<leader>ft", ":Rg<cr>", opts)
-- https://www.erickpatrick.net/blog/adding-syntax-highlighting-to-fzf.vim-preview-window
vim.cmd [[let $FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --layout reverse --margin=1,4 --preview 'bat --color=always --style=header,grid --line-range :300 {}'"]]
