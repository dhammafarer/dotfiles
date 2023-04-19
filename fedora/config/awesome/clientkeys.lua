local gears = require("gears")
local awful = require("awful")

clientkeys = gears.table.join(
  -- Next Layout
  awful.key({ modkey, "Control" }, "s",
    function (c) c.fullscreen = not c.fullscreen; c:raise() end,
    {description = "toggle fullscreen", group = "client"}
  ),

  -- Close Client
  awful.key({ modkey }, "q", function (c) c:kill() end, {description = "close", group = "client"}),

  -- Toggle floating
  awful.key({ modkey, "Control" }, "z", function(c)
      awful.client.floating.toggle(c)
      awful.placement.centered(c, nil)

      c.width = c.screen.geometry.width*0.6
      c.x = c.screen.geometry.x+(c.screen.geometry.width/5)
      c.height = c.screen.geometry.height * 0.7
      c.y = c.screen.geometry.height*0.15

      c:raise()
    end,
    {description = "toggle floating", group = "client"}
  )
)

return clientkeys
