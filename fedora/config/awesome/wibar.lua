local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

local volume_widget = require('awesome-wm-widgets.pactl-widget.volume')
local cmus_widget = require('awesome-wm-widgets.cmus-widget.cmus')

local mytextclock = wibox.layout.margin(
wibox.widget.textclock("%b %d  <span foreground='#ddd' weight='bold'>%H:%M</span>"), 4, 4, 0, 0)

local myvolume = wibox.layout.margin(volume_widget { widget_type = "vertical_bar" }, 0, 0, 4, 4)

local mysystray = wibox.layout.margin(wibox.widget.systray(), 3, 3, 3, 3)

require("globals")

local taglist_buttons = gears.table.join(
  awful.button({}, 1, function(t) t:view_only() end),
  awful.button({ MODKEY }, 1, function(t)
    if client.focus then
      client.focus:move_to_tag(t)
    end
  end),
  awful.button({}, 3, awful.tag.viewtoggle),
  awful.button({ MODKEY }, 3, function(t)
    if client.focus then
      client.focus:toggle_tag(t)
    end
  end),
  awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
  awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
  awful.button({}, 1, function(c)
    if c == client.focus then
      c.minimized = true
    else
      c:emit_signal(
        "request::activate",
        "tasklist",
        { raise = true }
      )
    end
  end),
  awful.button({}, 3, function()
    --awful.menu.client_list({ theme = { width = 250 } })
    awful.tag.history.restore()
  end),
  awful.button({}, 4, function()
    awful.client.focus.byidx(1)
  end),
  awful.button({}, 5, function()
    awful.client.focus.byidx(-1)
  end)
)

local function setup_wibar(s)
  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist {
    screen  = s,
    filter  = awful.widget.taglist.filter.noempty,
    buttons = taglist_buttons
  }

  -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist {
    screen  = s,
    layout  = {
      layout = wibox.layout.flex.horizontal
    },
    style   = {
      font = "Fira Code Bold 8",
      align = "center",
    },
    filter  = awful.widget.tasklist.filter.currenttags,
    buttons = tasklist_buttons
  }

  -- Create the wibox
  s.mywibox = awful.wibar({ position = "top", screen = s })

  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    -- expand = "none",
    {   -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      s.mytaglist,
      s.mypromptbox,
    },
    s.mytasklist,   -- Middle widget
    {               -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      cmus_widget {
      },
      myvolume,
      mytextclock,
      mysystray,
    },
  }
end

return setup_wibar
