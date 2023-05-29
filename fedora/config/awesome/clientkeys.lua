local gears = require("gears")
local awful = require("awful")

local margins = { left=18, bottom=18, right=18 }

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
      c.sticky = false
      c.ontop = false

      if c.floating then
        c.floating = false
        c.opacity = 1

        -- restore opacity on tiling clients
        for _, c in ipairs(mouse.screen.selected_tag:clients()) do
          if not c.floating then
            c.opacity = 1
          end
        end
        return
      end

      c.floating = true

      c.width = c.screen.geometry.width*0.6
      c.x = c.screen.geometry.x+(c.screen.geometry.width/5)
      c.height = c.screen.geometry.height * 0.7
      c.y = c.screen.geometry.height*0.15

      awful.placement.centered(c, nil)

      c:raise()

    end,
    {description = "toggle floating", group = "client"}
  ),

  -- Toggle floating
  awful.key({ modkey }, "u", function(c)
      c.ontop = true
      c.floating = true
      c.sticky = false

      c.width = c.screen.geometry.width*0.4
      c.height = c.screen.geometry.height * 0.4

      awful.placement.bottom_left(c, {margins=margins})

    end,
    {description = "toggle bottom_left", group = "client"}
  ),

  awful.key({ modkey }, "i", function(c)
      c.floating = true
      c.ontop = false
      c.sticky = false

      awful.placement.centered(c, nil)

      c.width = c.screen.geometry.width*0.6
      c.x = c.screen.geometry.x+(c.screen.geometry.width/5)
      c.height = c.screen.geometry.height * 0.7
      c.y = c.screen.geometry.height*0.15

      c:raise()
    end,
    {description = "toggle floating", group = "client"}
  ),
  

  awful.key({ modkey, "Shift" }, "e", function(c)
      c.ontop = true
      c.floating = true

      c.width = c.screen.geometry.width*0.25
      c.height = c.screen.geometry.height * 0.25

      c.sticky = true
      c.opacity = 0.3

      awful.placement.bottom_left(c,{margins=margins})

    end,
    {description = "set mini corner", group = "client"}
  ),

  awful.key({ modkey, "Control" }, "e", function(c)
      if c.opacity == 1 then
        c.opacity = 0.3
      else
        c.opacity = 1
      end
    end,
    {description = "toggle opacity", group = "client"}
  ),

  -- Toggle floating
  awful.key({ modkey }, "o", function(c)
      awful.placement.bottom_right(c, {margins=margins})
    end,
    {description = "set placement to bottom_right", group = "client"}
  ),

  awful.key({ modkey }, "n", function(c)
      awful.placement.bottom_left(c, {margins=margins})
    end,
    {description = "set placement to bottom_left", group = "client"}
  ),
  awful.key({ modkey }, "m",
    function (c)
      if c.backdrop then
        c.backdrop = false
        c.floating = false
      else
        for _, x in ipairs(c.first_tag:clients()) do
          x.backdrop = false
          x.minimized = false
          x.floating = false
        end

        c.floating = true
        c.backdrop = true

        c.width = c.screen.geometry.width*0.6
        c.x = c.screen.geometry.x+(c.screen.geometry.width/5)
        c.height = c.screen.geometry.height * 0.7
        c.y = c.screen.geometry.height*0.15

        awful.placement.centered(c, nil)


        c:raise()

        -- set layout to tile, because background windows will have opacity lowered
        awful.layout.set(awful.layout.suit.tile)
      end
    end ,
    {description = "toggle modal", group = "client"}),

  awful.key({ modkey }, "e",
    function (c)
      for _, c in ipairs(mouse.screen.selected_tag:clients()) do
        c.opacity = 1
      end
      if c.floating then
        c.minimized = true
      else
        local c = awful.client.restore()
        -- Focus restored client
        if c then
          c:raise()
          client.focus = c

          -- set layout to tiled, so that clients with lowered opacity don't overlap
          awful.layout.set(awful.layout.suit.tile)
        end
      end
    end ,
    {description = "toggle modal visibility", group = "client"})
)

return clientkeys
