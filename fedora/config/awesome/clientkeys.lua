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
  awful.key({ modkey }, "Up",
    function ()
        local c = awful.client.restore()
        -- Focus restored client
        if c then
          c:raise()
          client.focus = c
        end
    end,
    {description = "restore minimized", group = "client"}),
  awful.key({ modkey }, "m",
    function (c)
      if c.floating then
        c.floating = false
        for _, c in ipairs(mouse.screen.selected_tag:clients()) do
          c.opacity = 1
        end
      else
        c.floating = true

        c.width = c.screen.geometry.width*0.6
        c.x = c.screen.geometry.x+(c.screen.geometry.width/5)
        c.height = c.screen.geometry.height * 0.7
        c.y = c.screen.geometry.height*0.15

        awful.placement.centered(c, nil)

        c:raise()

        for _, c in ipairs(mouse.screen.selected_tag:clients()) do
          if client.focus ~= c then
            c.opacity = 0.3
          end
        end
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
          for _, c in ipairs(mouse.screen.selected_tag:clients()) do
            if client.focus ~= c then
              c.opacity = 0.3
            end
          end
        end
      end
    end ,
    {description = "toggle modal visibility", group = "client"})
)

return clientkeys
