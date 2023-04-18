local awful = require("awful")

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
  layout = awful.layout.suit.tile,
  screen = s
})
