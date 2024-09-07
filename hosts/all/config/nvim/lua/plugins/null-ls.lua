local null_ls = require("null-ls")

local sources = {
    -- null_ls.builtins.formatting.pint,
    -- null_ls.builtins.formatting.sql_formatter
}

null_ls.register({ sources = sources })
