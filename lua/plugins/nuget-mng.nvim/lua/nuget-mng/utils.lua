local utils = {}

-- Helper function to make HTTP requests
function utils.http_get(url)
  local curl = require "plenary.curl"
  local response = curl.get(url)
  return vim.fn.json_decode(response.body)
end

local function find_closest_file_by_ext(file_ext)
  if not file_ext then return nil end

  local file = vim.fn.expand "%:p"
  local dir = vim.fn.fnamemodify(file, ":h")
  while dir ~= "/" do
    local files = vim.fn.glob(dir .. "/*." .. file_ext, false, true)
    if #files > 0 then return files[1] end
    dir = vim.fn.fnamemodify(dir, ":h")
  end
  return nil
end

-- Find the nearest .csproj file
function utils.find_current_buffer_project() return find_closest_file_by_ext "csproj" end

function utils.find_solution() return find_closest_file_by_ext "sln" end

---@class utils.Project
---@field name string:Name of the project
---@field packages utils.Package[]:Packages of the project

---@class utils.Package
---@field name string:Name of the project
---@field version string:Installed version of the project
function utils.get_solution_projects_packages(solution_path)
  local cmd = "dotnet list " .. solution_path .. " package"
  local cmd_output = vim.fn.system(cmd)
  local splited_output = vim.split(cmd_output, "\n")

  local project_name_pattern = [['([a-zA-Z0-9.]+)']]
  local package_header_pattern = "Top%-level Package"

  local projects = {}
  local package_section = false
  local project = {
    name = nil,
    packages = {},
  }

  for _, str in ipairs(splited_output) do
    if string.find(str, package_header_pattern) then
      package_section = true
    elseif package_section == false and not project.name then
      local start_pos, end_pos = string.find(str, project_name_pattern)
      if start_pos then project.name = string.sub(str, start_pos, end_pos) end
    elseif package_section and str:find ">" then
      local package = {
        name = nil,
        version = nil,
      }
      local trimed = vim.trim(str)
      local package_name, _, version = trimed:match ">%s*(%S+)%s*(%S+)%s*(%S+)"

      package.name = package_name
      package.version = version

      table.insert(project.packages, package)
    elseif package_section and not str:find ">" then
      table.insert(projects, project)
      project = {
        name = nil,
        packages = {},
      }
      package_section = false
    end
  end

  return projects
end

return utils
