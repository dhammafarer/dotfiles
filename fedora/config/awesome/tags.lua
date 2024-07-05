require("globals")

return {
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
                column_count = 1,
                gap_single_client = true,
                key = "s",
                layout = LAYOUT_BOTTOM,
                master_fill_policy = "expand",
                master_width_factor = 0.75,
                selected = true,
            },
            {
                name = "三",
                key = "t",
                layout = LAYOUT_BOTTOM,
                master_width_factor = 0.5,
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
                layout = LAYOUT_FULL,
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
                name = "西",
                key = "r",
                layout = LAYOUT_BOTTOM,
                master_width_factor = 0.5,
                master_count = 1,
                gap = 0,
            },
            {
                name = "中",
                key = "s",
                layout = LAYOUT_BOTTOM,
                master_width_factor = 0.5,
            },
            {
                name = "東",
                column_count = 1,
                gap_single_client = true,
                key = "t",
                layout = LAYOUT_BOTTOM,
                master_fill_policy = "expand",
                master_width_factor = 0.75,
                selected = true,
            },
            {
                name = "北",
                key = "f",
                layout = LAYOUT_TILE,
                master_width_factor = 0.5,
            },
            {
                name = "南",
                key = "c",
                layout = LAYOUT_TILE,
                master_width_factor = 0.5,
            },
        },
        [2] = {
            {
                name = "一",
                key = "w",
                layout = LAYOUT_MAX,
                master_width_factor = 0.5,
            },
            {
                name = "二",
                key = "p",
                layout = LAYOUT_FULL,
                master_width_factor = 0.5,
                gap = 0,
            },
            {
                name = "三",
                key = "b",
                layout = LAYOUT_TILE,
                master_width_factor = 0.5,
            },
            {
                name = "四",
                key = "g",
                layout = LAYOUT_TILE,
                master_width_factor = 0.5,
            },
            {
                name = "五",
                key = "d",
                layout = LAYOUT_BOTTOM,
                master_width_factor = 0.5,
            },
            {
                name = "六",
                key = "x",
                layout = LAYOUT_MAX,
                master_width_factor = 0.5,
            },
            {
                name = "七",
                key = "v",
                layout = LAYOUT_TILE,
                master_width_factor = 0.5,
            },
            {
                name = "八",
                key = "a",
                layout = LAYOUT_TILE,
                master_width_factor = 0.66,
                gap = 0,
                selected = true
            },
        }
    }
}
