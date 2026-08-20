local M = {}

-- Check if ASCII mode is enabled via environment variable
local use_ascii = os.getenv("NVIM_USE_ASCII") == "1"

if use_ascii then
    M.ui = {
        folder_closed = "[+]",
        folder_open = "[-]",
        folder_empty = "[ ]",
        file = "-",
        default = "*",
    }

    M.git = {
        added = "+",
        modified = "~",
        deleted = "-",
        renamed = ">",
        untracked = "?",
        ignored = "!",
        unstaged = "U",
        staged = "S",
        conflict = "X",
    }

    M.diagnostics = {
        error = "E",
        warn = "W",
        hint = "H",
        info = "I",
    }

    M.kinds = {
        Text = "T",
        Method = "M",
        Function = "F",
        Constructor = "C",
        Field = "Fd",
        Variable = "V",
        Class = "Cl",
        Interface = "I",
        Module = "Md",
        Property = "P",
        Unit = "U",
        Value = "Val",
        Enum = "E",
        Keyword = "K",
        Snippet = "Snip",
        Color = "Col",
        File = "F",
        Reference = "Ref",
        Folder = "Dir",
        EnumMember = "EM",
        Constant = "Const",
        Struct = "St",
        Event = "Ev",
        Operator = "Op",
        TypeParameter = "TP",
    }

    M.misc = {
        dots = "...",
        arrow_right = ">",
        arrow_left = "<",
        check = "OK",
        close = "X",
        separator = "|",
    }
else
    M.ui = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "",
        file = "",
        default = "",
    }

    M.git = {
        added = "",
        modified = "",
        deleted = "",
        renamed = "➜",
        untracked = "★",
        ignored = "◌",
        unstaged = "✗",
        staged = "✓",
        conflict = "",
    }

    M.diagnostics = {
        error = "",
        warn = "",
        hint = "",
        info = "",
    }

    M.kinds = {
        Text = "",
        Method = "",
        Function = "",
        Constructor = "",
        Field = "",
        Variable = "",
        Class = "ﴯ",
        Interface = "",
        Module = "",
        Property = "襁",
        Unit = "",
        Value = "",
        Enum = "",
        Keyword = "",
        Snippet = "",
        Color = "",
        File = "",
        Reference = "",
        Folder = "",
        EnumMember = "",
        Constant = "",
        Struct = "",
        Event = "",
        Operator = "",
        TypeParameter = "",
    }

    M.misc = {
        dots = "…",
        arrow_right = "",
        arrow_left = "",
        check = "",
        close = "",
        separator = "│",
    }
end

return M
