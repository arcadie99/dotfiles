-- blink.cmp replaces nvim-cmp: same LSP/path/buffer/snippet sources,
-- native fuzzy matcher, no per-keystroke lag.
return {
	{
		"saghen/blink.cmp",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		version = "1.*",
		opts = {
			keymap = { preset = "default" },
			appearance = {
				nerd_font_variant = "mono",
			},
			completion = {
				documentation = { auto_show = true },
			},
			signature = { enabled = true },
			sources = {
				default = { "lsp", "path", "buffer", "snippets" },
			},
		},
		opts_extend = { "sources.default" },
	},
}
