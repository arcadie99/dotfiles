-- Formatting only. Replaces none-ls's formatting.* builtins (none-ls/null-ls
-- upstream is unmaintained). Linting lives separately in nvim-lint.
return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>gf",
			function()
				require("conform").format({ bufnr = 0 })
			end,
			desc = "Format buffer",
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			elixir = { "mix" },
			javascript = { "prettier" },
			javascriptreact = { "prettier" },
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
			vue = { "prettier" },
			json = { "prettier" },
			jsonc = { "prettier" },
			css = { "prettier" },
			html = { "prettier" },
			graphql = { "prettier" },
		},
		format_on_save = {
			timeout_ms = 1000,
			lsp_format = "fallback",
		},
	},
}
