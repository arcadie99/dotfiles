vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
-- vim.cmd("set number")
vim.cmd("set relativenumber number")
vim.g.mapleader = " "

vim.opt.termguicolors = true

-- 2 spaces for JS/TS/JSON (Node.js/NestJS convention)
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact", "json", "jsonc" },
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.shiftwidth = 2
    end,
})

-- Setup diagnostic signs
local icons = require("icons")

local signs = {
    { name = "DiagnosticSignError", text = icons.diagnostics.error },
    { name = "DiagnosticSignWarn", text = icons.diagnostics.warn },
    { name = "DiagnosticSignHint", text = icons.diagnostics.hint },
    { name = "DiagnosticSignInfo", text = icons.diagnostics.info },
}

for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

