local gears = require("gears")
local awful = require("awful")
local naughty = require("naughty")

local lain = require("lain")

require("globals")

local globalkeys = gears.table.join(
-- Restore last tag
  awful.key({ MODKEY }, "z",awful.tag.history.restore, { description = "go back", group = "tag" }),

  awful.key({ MODKEY, "Control" }, "y", function()
    naughty.destroy_all_notifications()
    if Urgent_Client then
      Urgent_Client:jump_to()
      Urgent_Client = nil
    end
  end, { description = "Destroy notifications", group = "hotkeys" }),

  -- Focus
  awful.key({ MODKEY }, "i",
    function()
      local master = awful.client.getmaster()
      client.focus = master
      if client.focus then client.focus:raise() end
    end,
    { description = "focus master", group = "client" }
  ),

  awful.key({ MODKEY }, "Tab",
    function()
      local screen = awful.screen.focused()

      if #screen.tiled_clients < 2 then
        local c = awful.client.restore()
        -- Focus restored client
        if c then
          c:raise()
        end
      end
      awful.client.focus.byidx(1)
    end, { description = "focus next by index", group = "client" }
  ),

  awful.key({ MODKEY, "Control" }, "Tab",
    function() awful.client.focus.byidx(-1) end, { description = "focus previous by index", group = "client" }
  ),

  -- navigation with arrows
  awful.key({ MODKEY }, "Down",
    function()
      awful.client.focus.bydirection("down")
      if client.focus then client.focus:raise() end
    end),

  awful.key({ MODKEY, "Shift" }, "Down",
    function()
      awful.client.swap.bydirection("down")
    end),

  awful.key({ MODKEY }, "Down",
    function()
      awful.client.focus.bydirection("down")
      if client.focus then client.focus:raise() end
    end),

  awful.key({ MODKEY }, "Up",
    function()
      awful.client.focus.bydirection("up")
      if client.focus then client.focus:raise() end
    end),

  awful.key({ MODKEY, "Shift" }, "Up",
    function()
      awful.client.swap.bydirection("up")
    end),

  awful.key({ MODKEY }, "Left",
    function()
      awful.client.focus.bydirection("left")
      if client.focus then client.focus:raise() end
    end),

  awful.key({ MODKEY, "Shift" }, "Left",
    function()
      awful.client.swap.bydirection("left")
    end),

  awful.key({ MODKEY }, "Right",
    function()
      awful.client.focus.bydirection("right")
      if client.focus then client.focus:raise() end
    end
  ),

  awful.key({ MODKEY, "Shift" }, "Right",
    function()
      awful.client.swap.bydirection("right")
    end),

  awful.key({ MODKEY }, "u",
    function()
      local ln = awful.layout.getname()

      if ln ~= "tileleft" then
        awful.layout.set(awful.layout.suit.tile.left)
      else
        awful.layout.set(lain.layout.centerwork)
      end
    end, { description = "Toggle centerwork/tile", group = "client" }
  ),

  awful.key({ MODKEY }, ",",
    function()
      awful.tag.incnmaster(1, nil, true)
    end, { description = "increase the number of master clients", group = "layout" }
  ),

  awful.key({ MODKEY }, ".",
    function()
      awful.tag.incnmaster(-1, nil, true)
    end, { description = "increase the number of master clients", group = "layout" }
  ),

  -- Swap with next
  awful.key({ MODKEY, "Shift" }, "Tab",
    function() awful.client.swap.byidx(1) end, { description = "swap with next client by index", group = "client" }
  ),

  -- Swap with previous
  awful.key({ MODKEY, "Shift", "Control" }, "Tab",
    function()
      awful.client.swap.byidx(-1)
    end, { description = "swap with previous client by index", group = "client" }
  ),

  -- Standard program
  awful.key({ MODKEY }, "Return", function() awful.spawn(TERMINAL) end,
    { description = "open a terminal", group = "launcher" }),

  -- Reload/Quit
  awful.key({ MODKEY, "Control" }, "q", awesome.restart, { description = "reload awesome", group = "awesome" }),
  awful.key({ MODKEY, "Shift" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),

  -- Master size
  awful.key({ MODKEY, "Shift" }, "n",
    function()
      awful.tag.incmwfact(0.05)

      if awful.layout.getname() == "tileleft" then
        local fct = mouse.screen.selected_tag.master_width_factor

        if fct > 0.70 then
          awful.layout.set(lain.layout.centerwork)
          awful.tag.incmwfact(-0.25)
        end
      end

      --awful.spawn("notify-send "..mouse.screen.selected_tag.master_width_factor)
    end,
    { description = "increase master width factor", group = "layout" }
  ),

  awful.key({ MODKEY, "Shift" }, "o",
    function()
      awful.tag.incmwfact(-0.05)

      if awful.layout.getname() == "centerwork" then
        local fct = mouse.screen.selected_tag.master_width_factor
        if fct < 0.50 then
          awful.layout.set(awful.layout.suit.tile.left)
          awful.tag.incmwfact(0.25)
        end
      end

      --awful.spawn("notify-send "..mouse.screen.selected_tag.master_width_factor)
    end,
    { description = "decrease master width factor", group = "layout" }
  ),

  -- Next Layout
  awful.key({ MODKEY }, "s", function()
    --awful.layout.inc(1)
    local ln = awful.layout.getname()
    if ln == "max" then
      awful.layout.set(lain.layout.centerwork)
    else
      awful.layout.set(awful.layout.suit.max)
    end
  end, { description = "select next", group = "layout" })
)

-- Workspace bindings
local tag_keys = {
  "w", -- dev
  "r", -- run
  "f", -- web
  "a", -- com
  "x", -- gui
  "p", -- art
  "c", -- vm
  "b"  -- med
}

for i, v in ipairs(tag_keys) do
  globalkeys = gears.table.join(globalkeys,
    -- View tag only.
    awful.key({ MODKEY }, v,
      function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          tag:view_only()
        end
      end,
      { description = "view tag #" .. i, group = "tag" }
    ),

    -- Move client to tag.
    awful.key({ MODKEY, "Shift" }, v,
      function()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:move_to_tag(tag)
          end
        end
      end,
      { description = "move focused client to tag #" .. i, group = "tag" }
    )
  )
end

return globalkeys
