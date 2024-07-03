local awful = require("awful")
local wibox = require("wibox")

local capslock = wibox.widget {
    widget = wibox.widget.textbox,
    align = "center",
    valign = "center",
    forced_width = 68,
}

local active = "<span foreground='#1d1f21' background='#ffbd7a' weight='bold'> CAPSLOCK </span>"
local inactive = "<span foreground='#1d1f21'></span>"

function capslock:check()
    awful.spawn.easy_async_with_shell(
        "~/.local/bin/xset q",
        function(line)
            local status = line:gsub(".*(Caps Lock:%s+)(%a+).*", "%2")
            if status == "on" then
                self.markup = active
            else
                self.markup = inactive
            end
        end)
end

capslock.key = awful.key(
    {},
    "Caps_Lock",
    function() capslock:check() end)

return capslock
