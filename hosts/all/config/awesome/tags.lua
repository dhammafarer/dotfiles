require("globals")

local zh = { "一", "二", "三", "四", "五", "六", "七", "八", "九", "〇", "甲", "乙", "丙" }
local en = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13 }

return {
    names = { [1] = zh, [2] = en },
    [1] = {
        [1] = {
            {
                name = "一",
                key = "r",
                layout = LAYOUT_BOTTOM,
                master_width_factor = 0.5,
                master_count = 1,
                gap = 0,
            },
            {
                name = "二",
                key = "s",
                column_count = 1,
                gap_single_client = true,
                layout = LAYOUT_BOTTOM,
                master_fill_policy = "expand",
                master_width_factor = 0.75,
            },
            {
                name = "三",
                key = "t",
                column_count = 1,
                gap_single_client = true,
                layout = LAYOUT_BOTTOM,
                master_fill_policy = "expand",
                master_width_factor = 0.75,
                selected = true,
            },
            {
                name = "四",
                key = "x",
                layout = LAYOUT_TILE,
                master_width_factor = 0.5,
            },
            {
                name = "五",
                key = "c",
                layout = LAYOUT_TILE,
                master_width_factor = 0.5,
            },
            {
                name = "六",
                key = "d",
                layout = LAYOUT_BOTTOM,
                master_width_factor = 0.5,
            },
            {
                name = "七",
                key = "w",
                layout = LAYOUT_MAX,
                master_width_factor = 0.5,
            },
            {
                name = "八",
                key = "f",
                layout = LAYOUT_TILE,
                master_width_factor = 0.5,
            },
            {
                name = "九",
                key = "p",
                layout = LAYOUT_MAX,
                master_width_factor = 0.5,
                gap = 0,
            },
            {
                name = "〇",
                key = "a",
                layout = LAYOUT_TILE,
                master_width_factor = 0.66,
                gap = 0,
            },
            {
                name = "甲",
                key = "b",
                layout = LAYOUT_TILE,
                master_width_factor = 0.5,
            },
            {
                name = "乙",
                key = "g",
                layout = LAYOUT_TILE,
                master_width_factor = 0.5,
            },
            {
                name = "丙",
                key = "v",
                layout = LAYOUT_TILE,
                master_width_factor = 0.5,
            },
        }
    },
    [2] = {
        [1] = {
            {
                name = "一",
                key = "r",
                layout = LAYOUT_BOTTOM,
                master_width_factor = 0.5,
                master_count = 1,
                gap = 0,
            },
            {
                name = "二",
                key = "s",
                column_count = 1,
                gap_single_client = true,
                layout = LAYOUT_BOTTOM,
                master_fill_policy = "expand",
                master_width_factor = 0.75,
                selected = true,
            },
            {
                name = "三",
                key = "t",
                column_count = 1,
                gap_single_client = true,
                layout = LAYOUT_BOTTOM,
                master_fill_policy = "expand",
                master_width_factor = 0.75,
                selected = true,
            },
            {
                name = "四",
                key = "x",
                layout = LAYOUT_TILE,
                master_width_factor = 0.5,
            },
            {
                name = "五",
                key = "c",
                layout = LAYOUT_TILE,
                master_width_factor = 0.5,
            },
            {
                name = "六",
                key = "d",
                layout = LAYOUT_BOTTOM,
                master_width_factor = 0.5,
            },
            {
                name = "七",
                key = "w",
                layout = LAYOUT_MAX,
                master_width_factor = 0.5,
            },
            {
                name = "八",
                key = "f",
                layout = LAYOUT_TILE,
                master_width_factor = 0.5,
            },
            {
                name = "九",
                key = "p",
                layout = LAYOUT_MAX,
                master_width_factor = 0.5,
                gap = 0,
            },
            {
                name = "〇",
                key = "a",
                layout = LAYOUT_TILE,
                master_width_factor = 0.66,
                gap = 0,
                selected = true
            },
        },
        [2] = {
            {
                name = "甲",
                key = "b",
                layout = LAYOUT_TILE,
                master_width_factor = 0.5,
            },
            {
                name = "乙",
                key = "g",
                layout = LAYOUT_TILE,
                master_width_factor = 0.5,
            },
            {
                name = "丙",
                key = "v",
                layout = LAYOUT_TILE,
                master_width_factor = 0.5,
            },
        }
    }
}
