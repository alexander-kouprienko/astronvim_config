vim.api.nvim_create_user_command("NugetManagerStart", function()
  local nuget_mng = require "nuget-mng"
  nuget_mng.start_nuget_manager()
end, {})
