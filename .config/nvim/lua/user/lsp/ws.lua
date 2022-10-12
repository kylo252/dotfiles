local M = {}

local api = vim.api

function M.add_workspace_folder(path, filter)
  for _, client in pairs(vim.lsp.get_active_clients(filter)) do
    if
      not vim.tbl_get(client.server_capabilities, "workspace", "workspaceFolders", "supported")
    then
      vim.notify_once(
        string.format("[LSP] %s doesn't support workspaces", client.name),
        vim.log.levels.WARN
      )
      return
    end
    client.workspace_folders = client.workspace_folders or {}
    local prompt_opts = {
      prompt = "Workspace Folder: ",
      default = vim.fn.expand "%:p:h",
    }
    if not path then
      vim.ui.input(prompt_opts, function(input)
        path = input
        -- TODO: is there another way to dismiss the prompt?
        api.nvim_command "redraw"
      end)
    end
    if vim.fn.isdirectory(path) == 0 then
      vim.notify_once(
        string.format("[LSP] skipping adding invalid directory %s", path),
        vim.log.levels.WARN
      )
      return
    end

    local new_workspace = {
      uri = vim.uri_from_fname(path),
      name = path,
    }
    local params = { event = { added = { new_workspace }, removed = {} } }
    for _, folder in pairs(client.workspace_folders) do
      if folder.name == path then
        vim.notify_once("[LSP] " .. path .. " is already part of this workspace")
        return
      end
    end
    client.notify("workspace/didChangeWorkspaceFolders", params)
    table.insert(client.workspace_folders, new_workspace)
  end
end

function M.list_workspace_folders(filter)
  local workspace_folders = {}
  for _, c in pairs(vim.lsp.get_active_clients(filter)) do
    for _, folder in pairs(c.workspace_folders or {}) do
      table.insert(workspace_folders, folder)
    end
  end
  return workspace_folders
end

return M
