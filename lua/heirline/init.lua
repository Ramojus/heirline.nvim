local M = {}
local StatusLine = require'heirline.statusline'
local utils = require'heirline.utils'

M.statusline = {}

function M.reset_highlights()
    return require'heirline.highlights'.reset_highlights()
end

function M.load()
    vim.g.qf_disable_statusline = true
    vim.cmd("set statusline=%{%v:lua.require'heirline'.eval()%}")
end

function M.setup(statusline)
    M.statusline = StatusLine:new(statusline)
    M.load()
end

M._avail = {}

function M.eval()
    local winnr = vim.api.nvim_win_get_number(0)
    local winwidth = vim.api.nvim_win_get_width(0)
    M._avail[winnr] = vim.api.nvim_win_get_width(0)

    local stl = M.statusline:eval():gsub("%%=", "")
    stl = vim.api.nvim_eval_statusline(stl, {winid=0}).str

    M._avail[winnr] = winwidth - utils.count_chars(stl)

    return M.statusline:eval()
end

-- test [[
function M.timeit()
    local start = os.clock()
    M.eval()
    return os.clock() - start
end
--]]

return M
