local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local f = ls.function_node
local c = ls.choice_node
local sn = ls.snippet_node

-- variables
local repos = { t("spabreaks"), t("sales"), t("sb-voucher-redemptions") }
local base_card_url = "https://palatinategroup.atlassian.net/browse/"
--

-- patterns
local patterns = {
    card = "%[[%a-%d]+%]",
    phrase = "^%s*(.-)%s*$",
    pr = "#[%d-]+"
}

-- functions

local cur_file = function()
    return vim.fn.expand('%:t:r')
end

local clipboard = function()
    return vim.fn.getreg("+") .. "";
end

local match_pr_id = function()
    local match = string.match(clipboard(), patterns.pr)
    if match then
        return string.sub(match, 2)
    else
        return cur_file
    end
end

local match_cards = function()
    local cards = {}
    for w in string.gmatch(clipboard(), patterns.card) do
        table.insert(cards, string.sub(w, 2, -2))
    end
    return cards
end

local card_urls = function()
    local res = {}
    for _, v in ipairs(match_cards()) do
        table.insert(res, base_card_url .. v)
    end

    return table.concat(res, " ")
end

local cards = function()
    return table.concat(match_cards(), "-")
end

local match_title = function()
    return string.match(
        string.gsub(string.gsub(clipboard(), patterns.card, ""), patterns.pr, ""),
        patterns.phrase
    )
end

local branch_name = function()
    local res = {}
    for w in string.gmatch(clipboard(), patterns.card) do
        table.insert(res, string.sub(w, 2, -2))
    end

    local t = string.gsub(string.lower(match_title()), "%s", "-")

    return table.concat(res, "-") .. "-" .. t
end

local repo_choice = sn(1, { c(1, repos) })

return {
    s("_template:pr", fmt(
        [[
        ---
        id: {}
        title: {}
        url: https://github.com/ygt/{}/pull/{}
        card: {}
        branch: {}
        ---
        ]],
        {
            f(match_pr_id),
            f(match_title),
            repo_choice,
            f(match_pr_id),
            f(card_urls),
            f(branch_name)
        })
    ),
    s("new_pr", fmt(
        [[
        [{} {}](./{}.md)
        ]],
        { f(cards), f(match_title), f(match_pr_id) }
    ))
}
