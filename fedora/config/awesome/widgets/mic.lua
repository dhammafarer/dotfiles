local awful = require("awful")
local wibox = require("wibox")  -- Provides the widgets
local watch = require("awful.widget.watch")

local active = ""
local inactive = "<span foreground='#1d1f21' background='#a54242' weight='bold'> MIC MUTE </span>"


local mic_widget = wibox.widget {
    widget = wibox.widget.textbox,
    align = "center",
    valign = "center",
}

watch("amixer get Capture | grep Mono:", 5, function(widget, stdout)
    widget:check()
    if string.match(stdout, "%[on%]") then
        widget.markup = active
    else
        widget.markup = inactive
    end
  end,
  mic_widget
)

function mic_widget:check()
    awful.spawn.easy_async_with_shell(
        "amixer get Capture | grep Mono:",
        function(stdout)
            if string.match(stdout, "%[on%]") then
                self.markup = active
            else
                self.markup = inactive
            end
        end)
end

mic_widget.key = awful.key(
    {}, "XF86AudioMicMute",
    function()
        awful.spawn("amixer set Capture toggle")
        mic_widget:check()
    end)

return mic_widget
