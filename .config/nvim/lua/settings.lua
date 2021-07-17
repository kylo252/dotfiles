---  HELPERS  ---
local cmd = vim.cmd
local opt = vim.opt

---  VIM ONLY COMMANDS  ---
cmd "filetype plugin on"
cmd('let &titleold="' .. TERMINAL .. '"')
cmd "set inccommand=split"
cmd "set iskeyword+=-"
cmd "set whichwrap+=<,>,[,],h,l"
cmd "set syntax=off"

---  SETTINGS  ---
opt.backup = false -- creates a backup file
opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
opt.cmdheight = 2 -- more space in the neovim command line for displaying messages
opt.colorcolumn = "99999" -- fix indentline for now
opt.completeopt = { "menuone", "noselect" }
opt.conceallevel = 0 -- so that `` is visible in markdown files
opt.cursorline = true -- highlight the current line
opt.expandtab = true -- convert tabs to spaces
opt.fileencoding = "utf-8" -- the encoding written to a file
opt.guifont = "monospace:h17" -- the font used in graphical neovim applications
opt.hidden = true -- required to keep multiple buffers and open multiple buffers
opt.ignorecase = true -- ignore case in search patterns
opt.mouse = "a" -- allow the mouse to be used in neovim
opt.number = true -- set numbered lines
opt.pumheight = 10 -- pop up menu height
opt.relativenumber = true -- set relative numbered lines
opt.shiftwidth = 4 -- the number of spaces inserted for each indentation
opt.shortmess:append "c"
opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
opt.showtabline = 2 -- always show tabs
opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
opt.smartcase = true -- smart case
opt.smartindent = false -- make indenting smarter again
opt.splitbelow = true -- force all horizontal splits to go below current window
opt.splitright = true -- force all vertical splits to go to the right of current window
opt.swapfile = false -- creates a swapfile
opt.tabstop = 4 -- insert 4 spaces for a tab
opt.termguicolors = true -- set term gui colors (most terminals support this)
opt.timeoutlen = 500 -- time to wait for a mapped sequence to complete (in milliseconds)
opt.title = true -- set the title of window to the value of the titlestring
opt.titlestring = "%<%F%=%l/%L - nvim" -- what the title of the window will be set to
opt.undodir = CACHE_PATH .. "/undo" -- set an undo directory
opt.undofile = false -- enable persisten undo
opt.updatetime = 300 -- faster completion
opt.wrap = false -- display lines as one long line
opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
