return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "ts_ls", "clangd", "intelephense", "phpactor" }
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            local lspconfig = require("lspconfig")

            lspconfig.lua_ls.setup({
                capabilities = capabilities,
            })

            lspconfig.ts_ls.setup({
                capabilities = capabilities,
            })

            lspconfig.clangd.setup({
                cmd = {
                    "clangd",
                    "--fallback-style=webkit",
                },
                capabilities = capabilities,
            })

            lspconfig.volar.setup({
                capabilities = capabilities,
                filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
            })

            lspconfig.intelephense.setup({
                capabilities = capabilities,
            })

            lspconfig.phpactor.setup({
                capabilities = capabilities,
            })


            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})

            vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
        end,
    },
}
