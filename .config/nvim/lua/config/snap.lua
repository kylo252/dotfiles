local snap = require "snap"

--[[ local fzf = snap.get 'consumer.fzf'
local limit = snap.get 'consumer.limit'
local producer_file = snap.get 'producer.ripgrep.file'
local producer_vimgrep = snap.get 'producer.ripgrep.vimgrep'
local producer_buffer = snap.get 'producer.vim.buffer'
local producer_oldfile = snap.get 'producer.vim.oldfile'
local select_file = snap.get 'select.file'
local select_vimgrep = snap.get 'select.vimgrep'
local preview_file = snap.get 'preview.file'
local preview_vimgrep = snap.get 'preview.vimgrep' ]]

local layout = snap.get("layout").bottom
local file = snap.config.file:with { consumer = "fzf", layout = layout }
local vimgrep = snap.config.vimgrep:with { layout = layout }

snap.register.command("find_files", file { producer = "ripgrep.file" })
snap.register.command("buffers", file { producer = "vim.buffer" })
snap.register.command("oldfiles", file { producer = "vim.oldfile" })
snap.register.command("live_grep", vimgrep {})

--[[ local s = {}

s.files = function()
  snap.run({
    prompt = 'Files',
    producer = fzf(producer_file),
    select = select_file.select,
    multiselect = select_file.multiselect,
    views = {preview_file}
  })
end

s.grep = function()
  snap.run({
    prompt = 'Grep',
    producer = limit(10000, producer_vimgrep),
    select = select_vimgrep.select,
    multiselect = select_vimgrep.multiselect,
    views = {preview_vimgrep}
  })
end

s.buffers = function()
  snap.run({
    prompt = 'Buffers',
    producer = fzf(producer_buffer),
    select = select_file.select,
    multiselect = select_file.multiselect,
    views = {preview_file}
  })
end

s.oldfiles = function()
  snap.run({
    prompt = 'Oldfiles',
    producer = fzf(producer_oldfile),
    select = select_file.select,
    multiselect = select_file.multiselect,
    views = {preview_file}
  })
end

return s ]]
