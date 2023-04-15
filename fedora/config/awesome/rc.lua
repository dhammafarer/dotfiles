-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

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

-- Global Variables
terminal = "xfce4-terminal"
editor = os.getenv("EDITOR") or "editor"
editor_cmd = terminal .. " -e " .. editor
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.max,
    -- awful.layout.suit.tile,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.floating,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.layout.margin(wibox.widget.textclock("%b %d  <span foreground='#ddd' weight='bold'>%H:%M</span>"),4,4,0,0)

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

awful.screen.connect_for_each_screen(function(s)
  --set_wallpaper(s)
  gears.wallpaper.maximized(beautiful.wallpaper, s, true)

  -- Workspaces
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
    gap = 20,
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
globalkeys = gears.table.join(
  -- Restore last tag
  awful.key({ modkey }, "z", awful.tag.history.restore, {description = "go back", group = "tag"}),
  -- Focus
  awful.key({ modkey }, "Tab",
    function () awful.client.focus.byidx( 1) end, {description = "focus next by index", group = "client"}
  ),
  awful.key({ modkey, "Shift" }, "Tab",
    function () awful.client.focus.byidx(-1) end, {description = "focus previous by index", group = "client"}
  ),

  -- Swap with next
  awful.key({ modkey, "Control" }, "Tab",
    function () awful.client.swap.byidx(1) end, {description = "swap with next client by index", group = "client"}
  ),

  -- Swap with previous
  awful.key({ modkey, "Control", "Shift" }, "Tab",
    function () awful.client.swap.byidx(-1) end, {description = "swap with previous client by index", group = "client"}
  ),

  -- Standard program
  awful.key({ modkey }, "Return", function () awful.spawn(terminal) end, {description = "open a terminal", group = "launcher"}),

  -- Reload/Quit
  awful.key({ modkey, "Control" }, "q", awesome.restart, {description = "reload awesome", group = "awesome"}),
  awful.key({ modkey, "Shift" }, "q", awesome.quit, {description = "quit awesome", group = "awesome"}),

  -- Master size
  awful.key({ modkey, "Shift" }, "o", function () awful.tag.incmwfact( 0.05) end, {description = "increase master width factor", group = "layout"}),
  awful.key({ modkey, "Shift" }, "n", function () awful.tag.incmwfact(-0.05) end, {description = "decrease master width factor", group = "layout"}),

  -- Next Layout
  awful.key({ modkey }, "s", function () awful.layout.inc(1) end, {description = "select next", group = "layout"})
)

clientkeys = gears.table.join(
  -- Next Layout
  awful.key({ modkey, "Control" }, "s",
    function (c) c.fullscreen = not c.fullscreen; c:raise() end,
    {description = "toggle fullscreen", group = "client"}
  ),

  -- Close Client
  awful.key({ modkey }, "q", function (c) c:kill() end, {description = "close", group = "client"}),

  -- Toggle floating
  awful.key({ modkey, "Control" }, "z",  awful.client.floating.toggle , {description = "toggle floating", group = "client"})
)

-- Workspace bindings
local tag_keys = { "w", "r", "f", "a", "x", "b", "c", "p" }

for i,v in ipairs(tag_keys) do
  globalkeys = gears.table.join(globalkeys,
    -- View tag only.
    awful.key({ modkey }, v,
      function ()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
           tag:view_only()
        end
      end,
      {description = "view tag #"..i, group = "tag"}
    ),

    -- Move client to tag.
    awful.key({ modkey, "Shift" }, v,
      function ()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:move_to_tag(tag)
          end
       end
      end,
      {description = "move focused client to tag #"..i, group = "tag"}
    )
  )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
         size_hints_honor = false,
         border_color = beautiful.border_normal,
         focus = awful.client.focus.filter,
         raise = true,
         keys = clientkeys,
         buttons = clientbuttons,
         screen = awful.screen.preferred,
         placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = false }
    },

    -- Set Firefox to always map on the tag named "2" on screen 1.
   { rule = { class = "Signal" },
     properties = { screen = 1, tag = "com" } },
}
-- }}}

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
    local max = s.selected_tag.layout.name == "max"
    local only_one = #s.tiled_clients == 1 -- use tiled_clients so that other floating windows don't affect the count
    -- but iterate over clients instead of tiled_clients as tiled_clients doesn't include maximized windows
    for _, c in pairs(s.clients) do
        if (max or only_one) and not c.floating or c.maximized then
            c.border_width = 0
        else
            c.border_width = beautiful.border_width
        end
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- Autostart applications
-- awful.spawn.with_shell("picom -b --config $HOME/.config/picom/picom.conf")
-- awful.spawn.with_shell("sxhkd")
-- awful.spawn.with_shell("flatpak run org.signal.Signal")
awesome.spawn(gears.filesystem.get_configuration_dir() .. "autostart.sh")
