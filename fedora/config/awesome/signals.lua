local awful = require("awful")
local beautiful = require("beautiful")

-- Signal function to execute when a new client appears.
client.connect_signal("manage",
  function (c)
    -- Set the windows at the slave,
    if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
  end
)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter",
  function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
  end
)

screen.connect_signal("arrange",
  function (s)
    local name = s.selected_tag.layout.name
    local noborder = name == "max" or name == "fullscreen"
    local only_one = #s.tiled_clients == 1 -- use tiled_clients so that other floating windows don't affect the count

    -- but iterate over clients instead of tiled_clients as tiled_clients doesn't include maximized windows
    for _, c in pairs(s.clients) do
      if (noborder or only_one) and not c.floating or c.maximized then
        c.border_width = 0
      else
        c.border_width = beautiful.border_width
      end
    end
  end
)

client.connect_signal("property::backdrop",
  function(c)
  -- client gets backdrop,
  if c.backdrop then
    for _, x in ipairs(c.first_tag:clients()) do
      if c ~= x then
        x.opacity = backdrop_opacity
      end
    end

    c.floating = true
    c.ontop = true

    c.width = 1280
    c.height = 720

    awful.placement.centered(c, nil)

    c:raise()

  -- client loses backdrop
  else
    c.floating = false
    c.ontop = false
    for _, x in ipairs(c.first_tag:clients()) do
      x.opacity = 1
    end
  end
end)

client.connect_signal("focus",
  function(c)
    c.border_color = beautiful.border_focus

    -- client in focus has backdrop
      for _, x in ipairs(c.first_tag:clients()) do
        if c ~= x then
          if x.ontop then
            x.opacity = x.opacity
          elseif c.backdrop then
            x.opacity = backdrop_opacity
          else
            x.opacity = inactive_opacity
          end
        else
          c.opacity = 1
        end
      end
  end
)

client.connect_signal("unfocus",
  function(c)
    c.border_color = beautiful.border_normal

    -- client has backdrop
    if c.backdrop then
      c.minimized = true
      c.ontop = false
    end
  end
)
