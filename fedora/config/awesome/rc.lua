-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local naughty = require("naughty")

require("awful.autofocus")

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

local gears = require("gears")
local awful = require("awful")

require("globals")

local beautiful = require("beautiful")
beautiful.init(THEME_PATH)

awful.screen.connect_for_each_screen(function(s)
  local setup_wibar = require("wibar")

  gears.wallpaper.set(beautiful.bg_normal)

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()

  setup_wibar(s)
end)

local globalkeys = require("globalkeys")
root.keys(globalkeys)

require("tags")
require("rules")
require("signals")

awesome.spawn(gears.filesystem.get_configuration_dir() .. "autostart.sh")
