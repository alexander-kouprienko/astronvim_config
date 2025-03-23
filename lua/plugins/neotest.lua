return {
  "nvim-neotest/neotest",
  dependencies = {
    "Issafalcon/neotest-dotnet",
  },
  opts = function(_, opts)
    if not opts.adapters then opts.adapters = {} end
    table.insert(opts.adapters, require "neotest-dotnet"(require("astrocore").plugin_opts "neotest-dotnet"))

    require("neotest").setup {
      adapters = {
        require "neotest-dotnet" {
          dap = {
            adapter_name = "coreclr",
          },
        },
      },
    }
  end,
}
