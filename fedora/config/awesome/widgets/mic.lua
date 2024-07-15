local awful = require("awful")
local wibox = require("wibox")  -- Provides the widgets
local watch = require("awful.widget.watch")

local HOME = os.getenv("HOME")

local icon_widget = wibox.widget {
    {
        id = "icon",
        widget = wibox.widget.imagebox,
        resize = false,
        image = HOME .. "/.local/share/icons/Arc/devices/symbolic/audio-input-microphone-symbolic.svg",
    },
    valign = 'center',
    layout = wibox.container.place,
}

local mic_widget = wibox.widget {
    layout = wibox.layout.fixed.horizontal,
    icon_widget,
    {
        id = "text",
        widget = wibox.widget.textbox,
        align = "center",
        valign = "center",
        markup = "<span foreground='#cc6666' background='#1d1f21' weight='bold'> MIC MUTE </span>"
    }
}

local function set_markup(widget, stdout)
    if string.match(stdout, "%[off%]") then
        widget.text.visible = true
        icon_widget.visible = false
    else
        widget.text.visible = false
        icon_widget.visible = true
    end
end

local command = "amixer get Capture"

watch(command, 5, function(widget, stdout)
    set_markup(widget, stdout)
  end,
  mic_widget
)

function mic_widget:check()
    awful.spawn.easy_async_with_shell(
        command,
        function(stdout)
            set_markup(self, stdout)
        end)
end

mic_widget.key = awful.key(
    {}, "XF86AudioMicMute",
    function()
        awful.spawn("amixer set Capture toggle")
        mic_widget:check()
    end)

return mic_widget
