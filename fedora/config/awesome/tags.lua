local awful = require("awful")

require("globals")

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
  LAYOUT_CENTER,
  LAYOUT_MAX,
  LAYOUT_TILE
}
-- }}}

awful.tag.add("dev", {
  index = 1,
  layout = LAYOUT_CENTER,
  selected = true,
})

awful.tag.add("web", {
  index = 2,
  layout = LAYOUT_CENTER,
})

awful.tag.add("map", {
  index = 3,
  layout = LAYOUT_MAX,
})

awful.tag.add("com", {
  index = 4,
  layout = LAYOUT_TILE,
})

awful.tag.add("log", {
  index = 5,
  layout = LAYOUT_CENTER,
})

awful.tag.add("gui", {
  index = 6,
  layout = LAYOUT_CENTER,
})

awful.tag.add("run", {
  index = 7,
  layout = LAYOUT_CENTER,
})

awful.tag.add("med", {
  index = 8,
  layout = awful.layout.suit.max.fullscreen,
})
awful.tag.add("vm", {
  index = 9,
  layout = LAYOUT_CENTER,
})

awful.tag.add("dev2", {
  index = 10,
  layout = LAYOUT_CENTER,
})

awful.tag.add("run2", {
  index = 11,
  layout = LAYOUT_CENTER,
})

awful.tag.add("vm2", {
  index = 12,
  layout = LAYOUT_CENTER,
})
