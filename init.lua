-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.
local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- validate that lazy is available
if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo({ { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end

vim.o.fileformat = "unix"

-- local lspconfig = require "lspconfig"
--
-- -- Настройка lua-ls
-- lspconfig.lua_ls.setup {
--   settings = {
--     Lua = {
--       runtime = {
--         -- Укажите версию Lua, которую вы используете (например, 'LuaJIT' для Neovim)
--         version = "LuaJIT",
--       },
--       diagnostics = {
--         -- Дайте LSP знать о глобальных переменных Neovim
--         globals = { "vim" },
--       },
--       workspace = {
--         -- Сделайте серверу доступными файлы Lua вашего проекта
--         library = vim.api.nvim_get_runtime_file("", true),
--         checkThirdParty = false, -- Отключить соединение с 3rd party для анализа
--       },
--       telemetry = {
--         enable = false, -- Отключить телеметрию
--       },
--     },
--   },
-- }

require "lazy_setup"
require "polish"
