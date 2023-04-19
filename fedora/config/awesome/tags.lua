local awful = require("awful")

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.max,
    -- awful.layout.suit.tile,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.floating,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

awful.tag.add("dev", {
  index = 1,
  layout = awful.layout.suit.tile,
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
