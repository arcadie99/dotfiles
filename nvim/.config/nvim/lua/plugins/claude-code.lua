-- MCP/WebSocket bridge to the Claude Code CLI: gives Claude live access
-- to open buffers, selection and diagnostics from inside Neovim.
return {
	"coder/claudecode.nvim",
	dependencies = { "folke/snacks.nvim" },
	opts = {},
	keys = {
		{ "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
		{ "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
		{ "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send selection to Claude" },
	},
}
