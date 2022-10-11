local M = {}

local api = vim.api
local make_workspace_params = vim.lsp.util.make_workspace_params

function M.add_workspace_folder(workspace_folder, filter)
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
    if not workspace_folder then
      vim.ui.input(prompt_opts, function(input)
        workspace_folder = input
        -- TODO: is there another way to dismiss the prompt?
        api.nvim_command "redraw"
      end)
    end
    if vim.fn.isdirectory(workspace_folder) == 0 then
      vim.notify_once(
        string.format("[LSP] skipping adding invalid directory %s", workspace_folder),
        vim.log.levels.WARN
      )
      return
    end
    local params = make_workspace_params(
      { { uri = vim.uri_from_fname(workspace_folder), name = workspace_folder } },
      { {} }
    )
    for _, folder in pairs(client.workspace_folders) do
      if folder.name == workspace_folder then
        vim.notify_once("[LSP] " .. workspace_folder .. " is already part of this workspace")
        return
      end
    end
    client.notify("workspace/didChangeWorkspaceFolders", params)
    table.insert(client.workspace_folders, params.event.added[1])
  end
end

function M.list_workspace_folders(filter)
  local workspace_folders = {}
  for _, client in pairs(vim.lsp.get_active_clients(filter)) do
    for _, folder in pairs(client.workspace_folders or {}) do
      table.insert(workspace_folders, folder.name)
    end
  end
  return workspace_folders
end

return M
