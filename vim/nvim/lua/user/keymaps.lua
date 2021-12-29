-- https://github.com/LunarVim/Neovim-from-scratch/blob/02-keymaps/lua/user/keymaps.lua

local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Custom motions
keymap("n", "<leader>o", "mpo<esc>`p", opts)
keymap("n", "<leader>O", "mpO<esc>`p", opts)
-- keymap("n", "<leader>l", "0v$", opts)   -- use V command instead
keymap("n", "<leader>sc", ":source %<cr>", opts)
keymap("n", "gg", "goto 1", opts)
keymap("n", "g", "<c-end><c-end>", opts)
keymap("n", "<leader>w", ":w<cr>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<C-i>", ":bnext<CR>", opts)
keymap("n", "<C-o>", ":bprevious<CR>", opts)


-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
-- keymap("v", "<A-j>", ":m .+1<CR>==", opts)  -- Can't get to work on Mac
-- keymap("v", "<A-k>", ":m .-2<CR>==", opts)  -- Can't get to work on Mac
keymap("v", "p", '"_dP', opts)  -- When pasting over, don't yank the thing replaced


