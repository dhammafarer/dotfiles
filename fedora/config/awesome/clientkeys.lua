local gears = require("gears")
local awful = require("awful")

local margins = { left=18, bottom=18, right=18, top=18 }

local function set_align(position, c)
  awful.placement.align(c, {position=position, margins=margins})
  c.align = position
end

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

      c.width = 1280
      c.height = 720

      awful.placement.centered(c, nil)

      c:raise()

    end,
    {description = "toggle floating", group = "client"}
  ),

  -- Resize to 360p, place in the corner
  awful.key({ modkey }, "u", function(c)
      c.ontop = true
      c.floating = true
      c.sticky = false

      c.width = 640
      c.height = 360

      awful.placement.bottom_left(c, {margins=margins})

    end,
    {description = "toggle bottom_left", group = "client"}
  ),

  -- decrement opacity
  awful.key({ modkey, "Control" }, "e", function(c)
      if c.opacity < backdrop_opacity then
        c.opacity = 1
      else
        c.opacity = c.opacity - 0.1
      end
    end,
    {description = "toggle opacity", group = "client"}
  ),

  -- increment opacity
  awful.key({ modkey, "Control" }, "i", function(c)
      if (c.opacity + 0.1) > 1 then
        c.opacity = 1
      else
        c.opacity = c.opacity + 0.1
      end
    end,
    {description = "toggle opacity", group = "client"}
  ),

  -- reset opacity to 1
  awful.key({ modkey, "Control", "Shift" }, "i", function(c)
      c.opacity = 1
    end,
    {description = "toggle opacity", group = "client"}
  ),

  -- reset opacity to lowest
  awful.key({ modkey, "Control", "Shift" }, "e", function(c)
      c.opacity = backdrop_opacity
    end,
    {description = "toggle opacity", group = "client"}
  ),

  -- place window in lower left corner
  awful.key({ modkey, "Shift" }, "Left", function(c)
      set_align("bottom_left", c)
    end,
    {description = "set placement to bottom_left", group = "client"}
  ),

  -- place window in lower right corner
  awful.key({ modkey, "Shift" }, "Right", function(c)
      set_align("bottom_right", c)
    end,
    {description = "set placement to bottom_right", group = "client"}
  ),

  awful.key({ modkey, "Shift" }, "Up", function(c)
      set_align("centered", c)

      c.floating = true
      c.ontop = false
      c.sticky = false
    end,
    {description = "toggle floating", group = "client"}
  ),
  

  -- toggle backdrop on client
  awful.key({ modkey }, "m",
    function (c)
      c.backdrop = not c.backdrop
    end ,
    {description = "toggle backdrop", group = "client"}),

  awful.key({ modkey }, "y",
    function (c)
      c.ontop = not c.ontop
    end ,
    {description = "toggle ontop", group = "client"}),

  -- toggle visibility of backdrop client
  awful.key({ modkey }, "e",
    function (c)
      if c.backdrop then
        c.minimized = true
      else
        local c = awful.client.restore()
        -- Focus restored client
        if c then
          c:raise()
          client.focus = c
        end
      end
    end ,
    {description = "toggle minimize backdrop", group = "client"})
)

local function position_floating(idx, c)
  local margins = { left=18, bottom=18, right=18, top=18 }
  local pos = c.align or "centered"
  
  c.floating = true

  local variants = {
    [1] = function (c)
        c.width = 640
        c.height = 360
        awful.placement.align(c, {position=pos, margins=margins})
      end,
    [2] = function (c)
        c.width = 854
        c.height = 480
        awful.placement.align(c, {position=pos, margins=margins})
      end,
    [3] = function (c)
        c.width = 1280
        c.height = 720
        awful.placement.align(c, {position=pos, margins=margins})
      end,
    [4] = function (c)
        c.width = 474
        c.height = 266
        awful.placement.align(c, {position=pos, margins=margins})
      end,
  }

  if variants[idx] then
    variants[idx](c)
  end
end

for i = 1, 9 do
  clientkeys = gears.table.join(clientkeys,
    awful.key({ modkey }, "#" .. i + 9,
      function (c)
        position_floating(i, c)
      end,
      {description = "set floating with position #"..i, group = "client"}
    )
  )
end

return clientkeys
