local M = {}
local StatusLine = require("heirline.statusline")

M.statusline = {}

function M.reset_highlights()
    return require("heirline.highlights").reset_highlights()
end

function M.load()
    vim.g.qf_disable_statusline = true
    vim.cmd("set statusline=%{%v:lua.require'heirline'.eval()%}")
end

function M.setup(statusline)
    M.statusline = StatusLine:new(statusline)
    M.load()
end

function M.find(component, name)
    component = component or M.statusline
    if component.name == name then
        return component
    end
    for i, c in ipairs(component) do
        local res = M.find(c, name)
        if res then
            return res
        end
    end
end

function M.insert(parent, child)
    table.insert(parent, parent:new(child))
end

function M.eval()
    return M.statusline:eval()
end

return M
