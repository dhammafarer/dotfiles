-- Ansible managed: templates/lua/plugins/luasnip.lua.j2 modified on 2024-06-28 12:47:25 by pl on dev.pale.paradise-liberty.ts.net
require("luasnip.loaders.from_snipmate").lazy_load() -- Lazy loading 
require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/snippets"})
