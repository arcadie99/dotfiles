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
                -- phpactor removed: was running duplicate/conflicting diagnostics
                -- alongside intelephense on the same PHP files
                ensure_installed = {
                    "lua_ls", "ts_ls", "clangd", "intelephense", "elixirls", "vue_ls",
                    "pyright", "tailwindcss", "cssls", "html", "jsonls", "dockerls",
                }
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require("blink.cmp").get_lsp_capabilities()

            vim.lsp.config("*", { capabilities = capabilities })

            vim.lsp.config("clangd", {
                cmd = { "clangd", "--fallback-style=webkit" },
            })

            vim.lsp.config("vue_ls", {
                filetypes = { "vue" },
            })

            vim.lsp.config("elixirls", {
                cmd = { vim.fn.expand("~/.local/share/nvim/mason/bin/elixir-ls") },
            })

            vim.lsp.enable({
                "lua_ls",
                "ts_ls",
                "clangd",
                "vue_ls",
                "elixirls",
                "intelephense",
                "pyright",
                "tailwindcss",
                "cssls",
                "html",
                "jsonls",
                "dockerls",
            })

            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})

            vim.keymap.set("n", "<leader>ci", function()
                vim.lsp.buf.code_action({
                    apply = true,
                    context = { only = { "source.organizeImports" }, diagnostics = {} },
                })
            end, { desc = "Organize imports" })
        end,
    },
}
