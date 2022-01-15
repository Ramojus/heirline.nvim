local M = {}
local StatusLine = require'heirline.statusline'

M.statusline = {}

function M.reset_highlights()
    return require'heirline.highlights'.reset_highlights()
end

function M.load()
    vim.g.qf_disable_statusline = true
    vim.cmd("set statusline=%{%v:lua.require'heirline'.eval()%}")
end

M.avail = 0

function M.setup(statusline)
    M.statusline = StatusLine:new(statusline)
    M.load()
end

function M.eval()
    local stl = M.statusline:eval()
    local out = vim.api.nvim_eval_statusline(stl, {winid=0, fillchar=''})
    M.avail = out.width - #out.str:gsub("", "")
    return stl
end

return M
