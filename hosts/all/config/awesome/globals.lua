-- Global Variables
local awful = require("awful")
local lain = require("lain")

THEME_PATH = string.format("%s/.config/awesome/theme.lua", os.getenv("HOME"))

TERMINAL = "kitty"

EDITOR = os.getenv("EDITOR") or "editor"

MODKEY = "Mod4"
ALTKEY = "Mod1"
ISOKEY = "Mod5" -- ISO_Level3_Shift

DEFAULT_INACTIVE_OPACITY = 0.85

BACKDROP_OPACITY = 0.00

Inactive_opacity = DEFAULT_INACTIVE_OPACITY

OPACITY = {}

MARGINS = { left=0, bottom=0, right=0, top=0 }

FLOATING_SIZES = {
  [1] = function (c)
      c.width = 640
      c.height = 360
    end,
  [2] = function (c)
      c.width = 854
      c.height = 480
    end,
  [3] = function (c)
      c.width = 1280
      c.height = 720
    end,
  [4] = function (c)
      c.width = 474
      c.height = 266
    end,
}

TAG_PROPS = {}

Urgent = nil

LAYOUT_CENTER = lain.layout.centerwork
LAYOUT_CENTER_NAME = "centerwork"

LAYOUT_TILE = awful.layout.suit.tile.left
LAYOUT_TILE_NAME = "tileleft"

LAYOUT_BOTTOM = awful.layout.suit.tile.bottom
LAYOUT_BOTTOM_NAME = "tilebottom"

LAYOUT_MAX = awful.layout.suit.max
LAYOUT_MAX_NAME = "max"

LAYOUT_FULL = awful.layout.suit.max.fullscreen
LAYOUT_FULL_NAME = "fullscreen"

awful.layout.layouts = {
  LAYOUT_CENTER,
  LAYOUT_MAX,
  LAYOUT_FULL,
  LAYOUT_TILE,
  LAYOUT_BOTTOM
}

function NOTIFY(msg)
    awful.spawn("notify-send "..msg)
end

function GET_OPACITY_FOR(name)
    if OPACITY[name] then
        return OPACITY[name]
    else
        return DEFAULT_INACTIVE_OPACITY
    end
end

function SET_OPACITY_FOR(name, opacity)
    OPACITY[name] = opacity
end
