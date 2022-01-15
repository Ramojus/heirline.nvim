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

local avail = {}

function M.setup(statusline)
    M.statusline = StatusLine:new(statusline)
    M.load()
end

function M.eval()
    local stl = M.statusline:eval()

    local out = vim.api.nvim_eval_statusline(stl, {winid=0, fillchar=''})
    local winid = vim.api.nvim_win_get_number(0)
    avail[winid] = out.width - require'heirline.utils'.count_chars(out.str:gsub("", ""))

    -- return stl
    return M.statusline:eval()
end

function M.get_available_space(winid)
    winid = winid == 0 and vim.api.nvim_win_get_number(0) or winid
    return avail[winid] or 0
end

return M
