-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- widgets
local volume_widget = require('awesome-wm-widgets.pactl-widget.volume')
local cmus_widget = require('awesome-wm-widgets.cmus-widget.cmus')

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")

-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
  naughty.notify({
    preset = naughty.config.presets.critical,
    title = "Oops, there were errors during startup!",
    text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
  local in_error = false
  awesome.connect_signal("debug::error", function (err)
    -- Make sure we don't go into an endless error loop
    if in_error then return end
    in_error = true

    naughty.notify({
      preset = naughty.config.presets.critical,
      title = "Oops, an error happened!",
      text = tostring(err) })
    in_error = false
  end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
local theme_path = string.format("%s/.config/awesome/theme.lua", os.getenv("HOME"))
beautiful.init(theme_path)

require("globals")

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.layout.margin(wibox.widget.textclock("%b %d  <span foreground='#ddd' weight='bold'>%H:%M</span>"),4,4,0,0)

myvolume = wibox.layout.margin(volume_widget{ widget_type = "vertical_bar" },0,0,4,4)

mysystray = wibox.layout.margin(wibox.widget.systray(),3,3,3,3)

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
  awful.button({ }, 1, function(t) t:view_only() end),
  awful.button({ modkey }, 1, function(t)
    if client.focus then
        client.focus:move_to_tag(t)
    end
  end),
  awful.button({ }, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, function(t)
    if client.focus then
      client.focus:toggle_tag(t)
    end
  end),
  awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
  awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
  awful.button({ }, 1, function (c)
    if c == client.focus then
      c.minimized = true
    else
      c:emit_signal(
        "request::activate",
        "tasklist",
        {raise = true}
      )
    end
  end),
  awful.button({ }, 3, function()
    awful.menu.client_list({ theme = { width = 250 } })
  end),
  awful.button({ }, 4, function ()
    awful.client.focus.byidx(1)
  end),
  awful.button({ }, 5, function ()
    awful.client.focus.byidx(-1)
  end)
)

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

require("tags")

awful.screen.connect_for_each_screen(function(s)
  --set_wallpaper(s)
  gears.wallpaper.maximized(beautiful.wallpaper, s, true)

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()

  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(gears.table.join(
     awful.button({ }, 1, function () awful.layout.inc( 1) end),
     awful.button({ }, 3, function () awful.layout.inc(-1) end),
     awful.button({ }, 4, function () awful.layout.inc( 1) end),
     awful.button({ }, 5, function () awful.layout.inc(-1) end))
  )

  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist {
      screen  = s,
      filter  = awful.widget.taglist.filter.noempty,
      buttons = taglist_buttons
  }

  -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist {
      screen  = s,
      layout = {
        layout  = wibox.layout.flex.horizontal
      },
      style = {
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
      { -- Left widgets
          layout = wibox.layout.fixed.horizontal,
          s.mytaglist,
          s.mypromptbox,
      },
      s.mytasklist, -- Middle widget
      { -- Right widgets
          layout = wibox.layout.fixed.horizontal,
          cmus_widget{
          },
          myvolume,
          mytextclock,
          mysystray,
      },
  }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
  awful.button({ }, 3, function () mymainmenu:toggle() end),
  awful.button({ }, 4, awful.tag.viewnext),
  awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings

globalkeys = require("globalkeys")
clientkeys = require("clientkeys")
clientbuttons = require("clientbuttons")

root.keys(globalkeys)

local rules = require("rules")

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
  -- Set the windows at the slave,
  if not awesome.startup then awful.client.setslave(c) end

  if awesome.startup
    and not c.size_hints.user_position
    and not c.size_hints.program_position then
      -- Prevent clients from being unreachable after screen count changes.
      awful.placement.no_offscreen(c)
  end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
  c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

screen.connect_signal("arrange", function (s)
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
end)

client.connect_signal("focus", function(c)
  c.border_color = beautiful.border_focus

  -- ensure client comes in focus with full opacity
  c.opacity = 1

  -- if focus returns to a tiling client, restore opacity on all clients
  if not c.floating then
    for _, c in ipairs(mouse.screen.selected_tag:clients()) do
      c.opacity = 1
    end
  end
end)

client.connect_signal("unfocus", function(c)
  c.border_color = beautiful.border_normal
end)
-- }}}

awesome.spawn(gears.filesystem.get_configuration_dir() .. "autostart.sh")
