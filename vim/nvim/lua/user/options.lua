-- :help options
-- https://neovim.io/doc/user/options.html

local options = {
    -- Window stuff
    equalalways = true,

    -- Themes and colors
    colorcolumn = {80},

    -- Text editing and motions
    tabstop = 4,
    softtabstop = 4,
    shiftwidth = 4,
    expandtab = true, -- turns tabs keypresses into spaces as set above
    autoindent = true,
    smartindent = true,
    wrap = false,
    nu = true,  -- line numbers
    relativenumber = false,
    scrolloff = 8,
    signcolumn = "yes",

    -- Files and backups
    swapfile = false,  -- gonna use undo directory instead of backups/swap,
    backup = false,
    undodir = "/Users/ar/vim/undo",  -- must be created by hand!
    undofile = true,
    hidden = true, -- hides buffer when abandoned, rather than unloading
    clipboard = {"unnamed", "unnamedplus"},

    -- Search
    incsearch = true,
    ignorecase = true,
    smartcase = true,  -- search becomes case-sens once UC letter is incl
    hlsearch = false, -- highlight all matches on previous search pattern

    -- Misc
    compatible = false,
    errorbells = false,
    updatetime = 50,  -- time waiting for command completion (default 4000ms = 4s)
    cmdheight = 2,  -- Give more space for displaying messages

    -- Suggestions from https://github.com/LunarVim/Neovim-from-scratch/blob/01-options/lua/user/options.lua
    -- https://www.youtube.com/watch?v=hY5-Q6NxQgY&list=PLhoH5vyxr6Qq41NFL4GvhFp-WLd5xzIzZ&index=2
    completeopt = { "menuone", "noselect" }, -- mostly just for cmp
    conceallevel = 0,                        -- so that `` is visible in markdown files
    fileencoding = "utf-8",                  -- the encoding written to a file
    mouse = "a",                             -- allow the mouse to be used in neovim
    pumheight = 10,                          -- pop up menu height
    showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
    showtabline = 2,                         -- always show tabs
    splitbelow = true,                       -- force all horizontal splits to go below current window
    splitright = true,                       -- force all vertical splits to go to the right of current window
    -- termguicolors = true,                    -- set term gui colors (most terminals support this)
    timeoutlen = 1000,                       -- time to wait for a mapped sequence to complete (in milliseconds)
    writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
    cursorline = true,                       -- highlight the current line
    numberwidth = 4,                         -- set number column width to 2 {default 4}
    sidescrolloff = 8,
    guifont = "monospace:h17"               -- the font used in graphical neovim applications
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

vim.opt.shortmess:append "c"
vim.cmd "highlight ColorColumn ctermbg=0 guibg=grey"
vim.cmd "highlight cursorline ctermbg=8 guibg=grey"
-- vim.cmd "set whichwrap+=<,>,[,],h,l"
-- vim.cmd [[set iskeyword+=-]]
