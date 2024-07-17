local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local s = ls.snippet
local t = ls.text_node
local c = ls.choice_node
local extras = require("luasnip.extras")
local r = extras.rep

return {
    s("log", fmt(
        'puts \"#{{\'{}\'.center({}, \'{}\')}}\\n"; Pry::ColorPrinter.pp({}{}); puts \"#{{\'{}\' * {}}}\\n\\n\"; # rubocop:disable Style/Semicolon',
        {
            r(1),
            i(3,"50"),
            i(4,"-"),
            i(1),
            c(2, {t(), t(".to_h"), t(".map(&:to_h)")}),
            r(4),
            r(3)

        }
    ))
}
