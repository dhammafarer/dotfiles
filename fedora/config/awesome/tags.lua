local awful = require("awful")

local lain = require("lain")

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    lain.layout.centerwork,
    awful.layout.suit.max,
    awful.layout.suit.tile.left,
}
-- }}}

awful.tag.add("dev", {
  index = 1,
  layout = lain.layout.centerwork,
  selected = true,
})

awful.tag.add("run", {
  index = 2,
  layout = lain.layout.centerwork,
})

awful.tag.add("web", {
  index = 3,
  layout = lain.layout.centerwork,
})

awful.tag.add("com", {
  index = 4,
  layout = awful.layout.suit.tile.left,
})

awful.tag.add("gui", {
  index = 5,
  layout = lain.layout.centerwork,
})

awful.tag.add("art", {
  index = 6,
  layout = lain.layout.centerwork,
})

awful.tag.add("vm", {
  index = 7,
  layout = lain.layout.centerwork,
})

awful.tag.add("med", {
  index = 8,
  layout = awful.layout.suit.max.fullscreen,
})
