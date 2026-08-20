-- nvim-treesitter on the `main` branch.
-- The old `master` branch is frozen and does NOT support Neovim 0.12,
-- which caused the `attempt to call method 'range' (a nil value)` crashes.
return {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
        local ensure_installed = {
            'lua', 'vue', 'javascript', 'typescript', 'tsx', 'c', 'cpp', 'html',
            'css', 'python', 'json', 'php', 'graphql', 'dockerfile',
            'elixir', 'heex',
        }

        -- Download/compile any parsers that are not installed yet (async).
        require('nvim-treesitter').install(ensure_installed)

        -- On `main`, highlighting/indent are opt-in per buffer. Enable them
        -- for every filetype that actually has a working parser installed.
        vim.api.nvim_create_autocmd('FileType', {
            group = vim.api.nvim_create_augroup('treesitter_start', { clear = true }),
            callback = function(args)
                local buf = args.buf
                local ft = vim.bo[buf].filetype
                local lang = vim.treesitter.language.get_lang(ft) or ft

                -- language.add() returns false (does NOT throw) when no parser
                -- exists for the filetype, e.g. neo-tree/help buffers. Gate on
                -- the return value, and pcall as a belt-and-suspenders guard.
                local ok, added = pcall(vim.treesitter.language.add, lang)
                if ok and added then
                    vim.treesitter.start(buf, lang)
                    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end
            end,
        })
    end,
}
