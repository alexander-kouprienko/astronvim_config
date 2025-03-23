-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE AstroCommunity: import any community modules here We import this file in `lazy_setup.lua` before the `plugins/` folder. This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  -- colorschemes
  { import = "astrocommunity.colorscheme.tokyonight-nvim" },
  { import = "astrocommunity.colorscheme.vscode-nvim" },
  -- import/override with your plugins folder
  { import = "astrocommunity.split-and-window.neominimap-nvim" },
  { import = "astrocommunity.pack.cs" },
  { import = "astrocommunity.test.neotest" },
  { import = "astrocommunity.editing-support.vim-visual-multi" },
}
