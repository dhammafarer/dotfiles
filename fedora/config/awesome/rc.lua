-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")


-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

require("awful.autofocus")

-- Theme handling library
local beautiful = require("beautiful")

-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")

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
    text = awesome.startup_errors
  })
end

-- Handle runtime errors after startup
do
  local in_error = false
  awesome.connect_signal("debug::error", function(err)
    -- Make sure we don't go into an endless error loop
    if in_error then return end
    in_error = true

    naughty.notify({
      preset = naughty.config.presets.critical,
      title = "Oops, an error happened!",
      text = tostring(err)
    })
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
menubar.utils.terminal = TERMINAL -- Set the terminal for applications that require it
-- }}}

local function set_wallpaper(s)
  -- Wallpaper
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == "function" then
      wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)
  else
    gears.wallpaper.set(beautiful.bg_normal)
  end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

require("tags")

local setup_wibar = require("wibar")

awful.screen.connect_for_each_screen(function(s)
  --set_wallpaper(s)
  set_wallpaper(s)

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()

  setup_wibar(s)
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
--  awful.button({ }, 4, awful.tag.viewnext),
--  awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

local globalkeys = require("globalkeys")

root.keys(globalkeys)

require("rules")
require("signals")

awesome.spawn(gears.filesystem.get_configuration_dir() .. "autostart.sh")
