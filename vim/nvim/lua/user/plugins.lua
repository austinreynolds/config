-- https://github.com/LunarVim/Neovim-from-scratch/blob/03-plugins/lua/user/plugins.lua
-- https://www.youtube.com/watch?v=gd_wapDL0V0&list=PLhoH5vyxr6Qq41NFL4GvhFp-WLd5xzIzZ&index=4

local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  vim.notify('Packer not found!')
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Plugin selection
return packer.startup(function(use)
    use "wbthomason/packer.nvim" -- Have packer manage itself
    use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
    use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
    use 'gruvbox-community/gruvbox'
    use 'preservim/nerdtree'
    use 'Xuyuanp/nerdtree-git-plugin'
    use 'tpope/vim-commentary'

    -- git
	use 'tpope/vim-fugitive'
	use 'vim-airline/vim-airline'
	use 'airblade/vim-gitgutter'

    -- fzf 
    -- https://github.com/junegunn/fzf.vim
    -- preview colors: brew install bat
    -- fulltext search: brew install ripgrep
	use 'junegunn/fzf'
	use 'junegunn/fzf.vim'



  -- Auto set up your config after cloning packer.nvim (put after plugins)
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

-- Plugin config
-- vim.cmd "let NERDTreeShowHidden=1"
