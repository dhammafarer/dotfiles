local gears = require("gears")
local awful = require("awful")
local lain = require("lain")

require("globals")

local function set_align(position, c)
  awful.placement.align(c, {position=position, margins=MARGINS})
  c.align = position
end

local function dim_clients_except(m)
  for _, x in ipairs(mouse.screen.selected_tag:clients()) do
    if x ~= m then
      x.opacity = BACKDROP_OPACITY
    end
  end
end

local clientkeys = gears.table.join(
  -- Next Layout
  awful.key({ MODKEY, "Control" }, "s",
    function (c) c.fullscreen = not c.fullscreen; c:raise() end,
    {description = "toggle fullscreen", group = "client"}
  ),

  -- Close Client
  awful.key({ MODKEY }, "q", function (c) c:kill() end, {description = "close", group = "client"}),

  -- Toggle floating
  awful.key({ MODKEY, "Control" }, "z", function(c)
      c.sticky = false
      c.ontop = false

      if c.floating then
        c.floating = false
        c.opacity = 1

        -- restore opacity on tiling clients
        for _, x in ipairs(mouse.screen.selected_tag:clients()) do
          if not x.floating then
            x.opacity = 1
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

  awful.key({ MODKEY }, "Insert",
    function (c)
      local master = awful.client.getmaster()

      if c == master then
        awful.client.swap.byidx(1)
        c:swap(master)
        awful.client.focus.byidx(-1)
      else
        c:swap(master)
      end
    end,
  {description = "move to master", group = "client"}
  ),

  awful.key({ MODKEY, "Control" }, "e",
    function (c)
      local m = awful.client.getmaster()
      if c == m then
        awful.client.swap.byidx(1)
        c:swap(m)
        awful.client.focus.byidx(-1)
      else
        c:swap(m)
      end
      awful.layout.set(lain.layout.centerwork)
      m = awful.client.getmaster()
      dim_clients_except(m)
    end,
  {description = "move to master", group = "client"}
  ),

  -- decrement opacity
  --awful.key({ MODKEY, "Control" }, "e", function(c)
  --    if c.opacity < BACKDROP_OPACITY then
  --      c.opacity = 1
  --    else
  --      c.opacity = c.opacity - 0.1
  --    end
  --  end,
  --  {description = "toggle opacity", group = "client"}
  --),

  -- increment opacity
  --awful.key({ MODKEY, "Control" }, "i", function(c)
  --    if (c.opacity + 0.1) > 1 then
  --      c.opacity = 1
  --    else
  --      c.opacity = c.opacity + 0.1
  --    end
  --  end,
  --  {description = "toggle opacity", group = "client"}
  --),

  -- reset opacity to 1
  awful.key({ MODKEY, "Control", "Shift" }, "i", function(c)
      c.opacity = 1
    end,
    {description = "toggle opacity", group = "client"}
  ),

  -- reset opacity to lowest
  awful.key({ MODKEY, "Control", "Shift" }, "e", function(c)
      c.opacity = BACKDROP_OPACITY
    end,
    {description = "toggle opacity", group = "client"}
  ),

  -- place window in lower left corner
  awful.key({ MODKEY, "Control", "Shift" }, "Left", function(c)
      set_align("bottom_left", c)
    end,
    {description = "set placement to bottom_left", group = "client"}
  ),

  -- place window in lower right corner
  awful.key({ MODKEY, "Control", "Shift" }, "Right", function(c)
      set_align("bottom_right", c)
    end,
    {description = "set placement to bottom_right", group = "client"}
  ),

  awful.key({ MODKEY, "Control", "Shift" }, "Up", function(c)
      set_align("centered", c)

      c.floating = true
      c.ontop = false
      c.sticky = false
    end,
    {description = "toggle floating", group = "client"}
  ),

  awful.key({ MODKEY }, "y",
    function (c)
      c.ontop = not c.ontop
    end ,
    {description = "toggle ontop", group = "client"}
  ),

  awful.key({ MODKEY, "Control" }, "m",
    function(c)
      if Inactive_opacity == BACKDROP_OPACITY then
        Inactive_opacity = DEFAULT_INACTIVE_OPACITY
      else
        Inactive_opacity = BACKDROP_OPACITY
      end

      for _, x in ipairs(mouse.screen.selected_tag:clients()) do
        if x ~= c then
          x.opacity = Inactive_opacity
        end
      end
      c.opacity = 1
    end,
    {description = "toggle reading mode", group = "client"}
  ),

  awful.key({ MODKEY }, "e",
    function()
      awful.layout.set(lain.layout.centerwork)

      local master = awful.client.getmaster()
      master:raise()
      client.focus = master
      master.opacity = 1

      dim_clients_except(master)
    end,
    {description = "toggle reading mode on", group = "client"}
  ),

  awful.key({ MODKEY }, "n",
    function(c)
      local master = awful.client.getmaster()

      if c == master then
        awful.client.focus.byidx(1)
      end
      if awful.layout.getname() == "centerwork" then
        awful.layout.set(awful.layout.suit.tile.left)
      end
      master.opacity = 1
    end,
    {description = "toggle reading mode off", group = "client"}
  ),

  -- toggle backdrop on client
  awful.key({ MODKEY, "Control" }, "h",
    function (c)
      c.backdrop = not c.backdrop
    end ,
    {description = "toggle backdrop", group = "client"}
  ),

  -- toggle visibility of backdrop client
  awful.key({ MODKEY }, "h",
    function (c)
      if c.backdrop then
        c.ontop = false
        c.minimized = true
      else
        local cr = awful.client.restore()
        -- Focus restored client
        if cr then
          cr:raise()
          cr.ontop = true
          client.focus = cr
        end
      end
    end ,
    {description = "toggle minimize backdrop", group = "client"})
)

local function position_floating(idx, c)
  local pos = c.align or "centered"

  c.floating = true

  if FLOATING_SIZES[idx] then
    FLOATING_SIZES[idx](c)
    awful.placement.align(c, {position=pos, margins=MARGINS})
  end
end

for i = 1, 9 do
  clientkeys = gears.table.join(clientkeys,
    awful.key({ MODKEY }, "#" .. i + 9,
      function (c)
        position_floating(i, c)
      end,
      {description = "set floating with position #"..i, group = "client"}
    )
  )
end

return clientkeys
