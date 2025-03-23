---@module "neominimap.config.meta"
return {
  "Isrothy/neominimap.nvim",
  version = "v3.*.*",
  enabled = true,
  lazy = false, -- NOTE: NO NEED to Lazy load
  -- Optional
  keys = {
    -- Global Minimap Controls
    { "<leader>Mm", "<cmd>Neominimap toggle<cr>", desc = "Toggle global minimap" },
    { "<leader>Mo", "<cmd>Neominimap on<cr>", desc = "Enable global minimap" },
    { "<leader>Mc", "<cmd>Neominimap off<cr>", desc = "Disable global minimap" },
    { "<leader>Mr", "<cmd>Neominimap refresh<cr>", desc = "Refresh global minimap" },

    -- Window-Specific Minimap Controls
    { "<leader>Mwt", "<cmd>Neominimap winToggle<cr>", desc = "Toggle minimap for current window" },
    { "<leader>Mwr", "<cmd>Neominimap winRefresh<cr>", desc = "Refresh minimap for current window" },
    { "<leader>Mwo", "<cmd>Neominimap winOn<cr>", desc = "Enable minimap for current window" },
    { "<leader>Mwc", "<cmd>Neominimap winOff<cr>", desc = "Disable minimap for current window" },

    -- Tab-Specific Minimap Controls
    { "<leader>Mtt", "<cmd>Neominimap tabToggle<cr>", desc = "Toggle minimap for current tab" },
    { "<leader>Mtr", "<cmd>Neominimap tabRefresh<cr>", desc = "Refresh minimap for current tab" },
    { "<leader>Mto", "<cmd>Neominimap tabOn<cr>", desc = "Enable minimap for current tab" },
    { "<leader>Mtc", "<cmd>Neominimap tabOff<cr>", desc = "Disable minimap for current tab" },

    -- Buffer-Specific Minimap Controls
    { "<leader>Mbt", "<cmd>Neominimap bufToggle<cr>", desc = "Toggle minimap for current buffer" },
    { "<leader>Mbr", "<cmd>Neominimap bufRefresh<cr>", desc = "Refresh minimap for current buffer" },
    { "<leader>Mbo", "<cmd>Neominimap bufOn<cr>", desc = "Enable minimap for current buffer" },
    { "<leader>Mbc", "<cmd>Neominimap bufOff<cr>", desc = "Disable minimap for current buffer" },

    ---Focus Controls
    { "<leader>Mf", "<cmd>Neominimap focus<cr>", desc = "Focus on minimap" },
    { "<leader>Mu", "<cmd>Neominimap unfocus<cr>", desc = "Unfocus minimap" },
    { "<leader>Ms", "<cmd>Neominimap toggleFocus<cr>", desc = "Switch focus on minimap" },
  },
  init = function()
    -- The following options are recommended when layout == "float"
    vim.opt.wrap = false
    vim.opt.sidescrolloff = 36 -- Set a large value

    --- Put your configuration here
    ---@type Neominimap.UserConfig
    vim.g.neominimap = {
      auto_enable = true,
      layout = "float",
      float = { minimap_width = 10 },
      split = {
        minimap_width = 10,
      },
    }
  end,
}
