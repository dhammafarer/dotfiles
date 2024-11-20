---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local theme = {}

theme.master_width_factor = 0.66

local colors = {}

--colors.bg = "#1d1f21"
colors.bg = "#0F1319"
colors.blue = "#5f819d"
colors.border = "#282a2e"
--colors.grey = "#373b41"
colors.grey = "#555"
--colors.white = "#c5c8c6"
colors.white = "#efe"
colors.dark = "#707880"
colors.light = "#282a2e"

theme.font          = "sans 8"

theme.bg_normal     = colors.bg
theme.bg_focus      = colors.bg
theme.bg_urgent     = theme.bg_normal
theme.bg_minimize   = theme.bg_normal
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = colors.grey
theme.fg_focus      = colors.white
theme.fg_urgent     = colors.white
theme.fg_minimize   = "#ffffff"

theme.useless_gap   = dpi(4)
theme.border_width  = dpi(1)
theme.border_normal = colors.bg
theme.border_focus  = colors.border
theme.border_marked = "#91231c"

theme.gap_single_client  = false

theme.tasklist_disable_icon = true

theme.taglist_fg_focus = colors.fg
theme.taglist_font = "Fira Code Bold 8"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Variables set for theming notifications:
theme.notification_font = "Fira Code 12"
theme.notification_bg = colors.light
theme.notification_fg = colors.white
theme.notification_border_color = colors.border
theme.notification_width = dpi(330)
theme.notification_icon_size = dpi(48)

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
