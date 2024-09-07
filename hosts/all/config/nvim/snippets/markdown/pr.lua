local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local s = ls.snippet
local f = ls.function_node
local t = ls.text_node
local c = ls.choice_node
local sn = ls.snippet_node

-- variables
local repos = { t("spabreaks"), t("sales"), t("sb-voucher-redemptions") }
local repo_codes = { t("sb"), t("wss"), t("vrs") }
local base_card_url = "https://palatinategroup.atlassian.net/browse/"
--

-- patterns
local patterns = {
    card = "%[?(SB%-%d+)%]?",
    phrase = "^%s*(.-)%s*$",
    pr = "#([%d-]+)"
}

-- functions

local clipboard = function()
    return vim.fn.getreg("+") .. "";
end

local match_pr_id = function()
    local match = string.match(clipboard(), patterns.pr)
    if match then
        return match
    else
        return ""
    end
end

local match_cards = function()
    local cards = {}
    for w in string.gmatch(clipboard(), patterns.card) do
        table.insert(cards, w)
    end
    return cards
end

local card_urls = function()
    local res = {}
    table.insert(res, "")
    for _, v in ipairs(match_cards()) do
        table.insert(res, "- " .. base_card_url .. v)
    end

    -- return table.concat(res, " ")
    return res
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
    return (string.gsub(string.lower(match_title()), "%s", "-"))
end

local repo_name = sn(1, { c(1, repos) })
local repo_code = sn(1, { c(1, repo_codes) })

return {
    s("_template:pr", fmt(
        [[
        ---
        id: {}
        title: {}
        url: https://github.com/ygt/{}/pull/{}
        cards: {}
        branch: {}-{}
        ---
        ]],
        {
            f(match_pr_id),
            f(match_title),
            repo_name,
            f(match_pr_id),
            t(card_urls()),
            t(cards()),
            i(2, branch_name())
        })
    ),
    s("new_pr", fmt(
        [[
        [{} {}](pr/{}/{}.md)
        ]],
        { f(cards), f(match_title), repo_code, f(match_pr_id) }
    ))
}
