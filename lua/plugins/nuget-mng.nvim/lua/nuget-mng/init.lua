local M = {}

local utils = require "nuget-mng.utils"
local path_delimeter = nil
if vim.fn.has "win32" then
  path_delimeter = "\\"
else
  path_delimeter = "/"
end

function find_matches(input_string, pattern)
  local matches = {}

  for match in string.gmatch(input_string, pattern) do
    table.insert(matches, match)
  end

  return matches
end

local root_dir = vim.fn.getcwd()
local current_dir = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h")
local tempfile = vim.fn.tempname()

local state = {
  floats = {},
}

local function create_window_configurations()
  local width = vim.o.columns
  local height = vim.o.lines - 2

  local background_width = width - 2
  local background_height = height - 2

  local package_name_width = math.floor((background_width - 2) / 4 - 1) -- +border
  local package_name_height = 1 + 2 -- 1 +border

  local project_name_width = math.floor((background_width - 2) / 4 - 1) -- +border
  local project_name_height = 1 + 2 -- +border

  local packages_width = math.floor((background_width - 2) / 2)
  local packages_height = background_height - 4 - package_name_height

  local projects_width = packages_width - 1
  local projects_height = packages_height

  return {
    background = {
      relative = "editor",
      style = "minimal",
      border = "rounded",
      width = background_width,
      height = background_height,
      col = 0,
      row = 0,
      zindex = 1,
    },
    package_name = {
      relative = "editor",
      style = "minimal",
      border = "rounded",
      width = package_name_width,
      height = package_name_height,
      col = 1,
      row = 1,
      zindex = 4,
    },
    project_name = {
      relative = "editor",
      style = "minimal",
      border = "rounded",
      width = project_name_width,
      height = project_name_height,
      col = package_name_width + 3,
      row = 1,
      zindex = 5,
    },
    packages = {
      relative = "editor",
      style = "minimal",
      border = "rounded",
      width = packages_width,
      height = packages_height,
      col = 1,
      row = package_name_height + 3,
      zindex = 2,
    },
    projects = {
      relative = "editor",
      style = "minimal",
      border = "rounded",
      width = projects_width,
      height = projects_height,
      col = packages_width + 3,
      row = package_name_height + 3,
      zindex = 3,
    },
  }
end

local foreach_float = function(cb)
  for name, float in pairs(state.floats) do
    cb(name, float)
  end
end

local present_keymap = function(mode, key, buf, callback)
  vim.keymap.set(mode, key, callback, {
    noremap = true,
    silent = true,
    buffer = buf,
  })
end

-- local res = ""
-- for _, e in ipairs(vim.split(result, "\n")) do
--   res = res .. e
-- end
-- print(res)

-- function find_csproj()
--   local root_dir = vim.fn.getcwd()
--   local current_dir = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h")
-- end

local function create_floating_window(config, enter)
  if enter == nil then enter = false end

  --- Create a buffer
  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, enter or false, config)

  return { buf = buf, win = win }
end

local notify = function(text) require "notify"(text) end

local function close_all_windows_and_buffers()
  local floats_to_close = vim.deepcopy(state.floats)

  for _, value in pairs(floats_to_close) do
    if vim.api.nvim_win_is_valid(value.win) then pcall(vim.api.nvim_win_close, value.win, true) end
  end

  for _, value in pairs(floats_to_close) do
    if not value.buf and vim.api.nvim_buf_is_valid(value.buf) then
      pcall(vim.api.nvim_buf_close, value.buf, { force = true })
    end
  end

  state.floats = {}
end

M.start_nuget_manager = function(opts)
  opts = opts or {}
  opts.bufnr = 0

  local windows = create_window_configurations()
  state.floats.background = create_floating_window(windows.background)
  state.floats.package_name = create_floating_window(windows.package_name, true)
  state.floats.project_name = create_floating_window(windows.project_name)
  state.floats.packages = create_floating_window(windows.packages)
  state.floats.projects = create_floating_window(windows.projects)

  foreach_float(function(_, float)
    present_keymap("n", "q", float.buf, function() close_all_windows_and_buffers() end)
  end)

  local restore = {
    cmdheight = {
      original = vim.o.cmdheight,
      present = 0,
    },
  }

  for option, config in pairs(restore) do
    vim.opt[option] = config.present
  end

  vim.api.nvim_create_autocmd("WinClosed", {
    buffer = state.floats.background.buf,
    callback = function()
      for option, config in pairs(restore) do
        vim.opt[option] = config.original
      end

      for _, float in ipairs(state.floats) do
        vim.keymap.del("n", "q", { buffer = float.buf })
      end
    end,
  })
end

-- M.start_nuget_manager()

return M
