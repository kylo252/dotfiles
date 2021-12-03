CONFIG_PATH = vim.fn.stdpath "config"
DATA_PATH = vim.fn.stdpath "data"
CACHE_PATH = vim.fn.stdpath "cache"
TERMINAL = vim.fn.expand "$TERMINAL"

---  VIM ONLY COMMANDS  ---
vim.cmd "filetype plugin on"
vim.cmd('let &titleold="' .. TERMINAL .. '"')
vim.cmd "set inccommand=split"
vim.cmd "set iskeyword+=-"
vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd "set syntax=off"

---  SETTINGS  ---
vim.opt.backup = false -- creates a backup file
vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.opt.cmdheight = 2 -- more space in the neovim command line for displaying messages
vim.opt.colorcolumn = "99999" -- fix indentline for now
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.conceallevel = 0 -- so that `` is visible in markdown files
vim.opt.cursorline = true -- highlight the current line
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.fileencoding = "utf-8" -- the encoding written to a file
vim.opt.guifont = "monospace:h17" -- the font used in graphical neovim applications
vim.opt.hidden = true -- required to keep multiple buffers and open multiple buffers
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.mouse = "a" -- allow the mouse to be used in neovim
vim.opt.number = true -- set numbered lines
vim.opt.pumheight = 10 -- pop up menu height
vim.opt.relativenumber = true -- set relative numbered lines
vim.opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
vim.opt.shortmess:append "c" -- don't show the dumb matching stuff
vim.opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
vim.opt.showtabline = 2 -- always show tabs
vim.opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
vim.opt.smartcase = true -- smart case
vim.opt.smartindent = false -- make indenting smarter again
vim.opt.splitbelow = true -- force all horizontal splits to go below current window
vim.opt.splitright = true -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false -- creates a swapfile
vim.opt.tabstop = 2 -- insert 4 spaces for a tab
vim.opt.termguicolors = true -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 300 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.title = true -- set the title of window to the value of the titlestring
vim.opt.undodir = vim.fn.stdpath "cache" .. "/undo" -- set an undo directory
vim.opt.undofile = true -- enable persisten undo
vim.opt.updatetime = 300 -- faster completion
vim.opt.wrap = false -- display lines as one long line
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.scrolloff = 8 -- minimal number of screen lines to keep above and below the cursor.

if vim.fn.has "wsl" == 1 then
  vim.g.clipboard = {
    copy = {
      ["+"] = "win32yank.exe -i --crlf",
      ["*"] = "win32yank.exe -i --crlf",
    },
    paste = {
      ["+"] = "win32yank.exe -o --lf",
      ["*"] = "win32yank.exe -o --lf",
    },
  }
end
