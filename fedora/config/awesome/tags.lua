local awful = require("awful")

local lain = require("lain")

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    lain.layout.centerwork,
    awful.layout.suit.max,
    -- awful.layout.suit.tile,
}
-- }}}

awful.tag.add("dev", {
  index = 1,
  layout = lain.layout.centerwork,
  layouts = {
    lain.layout.centerwork,
    awful.layout.suit.max,
  },
  selected = true,
  screen = s
})

awful.tag.add("run", {
  index = 2,
  layout = awful.layout.suit.tile,
  screen = s
})

awful.tag.add("web", {
  index = 3,
  layout = awful.layout.suit.tile,
  screen = s
})

awful.tag.add("com", {
  index = 4,
  layout = awful.layout.suit.tile,
  layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.max,
  },
  screen = s
})

awful.tag.add("gui", {
  index = 5,
  layout = awful.layout.suit.tile,
  screen = s
})

awful.tag.add("art", {
  index = 6,
  layout = awful.layout.suit.tile,
  screen = s
})

awful.tag.add("vm", {
  index = 7,
  layout = awful.layout.suit.tile,
  screen = s
})

awful.tag.add("med", {
  index = 8,
  layout = awful.layout.suit.max.fullscreen,
  layouts = {awful.layout.suit.tile},
  screen = s
})
