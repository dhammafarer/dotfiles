local awful = require("awful")
local wibox = require("wibox")  -- Provides the widgets
local watch = require("awful.widget.watch")
local gears = require("gears")

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
        valign = "center"
    }
}

local function set_markup(widget, stdout)
    if string.match(stdout, "%[off%]") then
        widget.text.markup = "<span foreground='#1d1f21' background='#333' weight='bold'>  MIC OFF  </span>"
        widget.text.visible = true
        icon_widget.visible = false
    else
        widget.text.markup = "<span foreground='#1d1f21' background='#cc6666' weight='bold'>  MIC REC  </span>"
        widget.text.visible = true
        icon_widget.visible = false
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

mic_widget.keys = gears.table.join(
    awful.key( {}, "XF86AudioMicMute",
        function()
            awful.spawn("amixer set Capture toggle")
            mic_widget:check()
        end
    ),
    awful.key( {}, "XF86AudioPrev",
        function()
            awful.spawn("amixer set Capture nocap")
            awful.spawn("notify-send Mic MUTE")
            mic_widget:check()
        end
    ),
    awful.key( {}, "XF86AudioNext",
        function()
            awful.spawn("amixer set Capture cap")
            awful.spawn("notify-send Mic ON")
            mic_widget:check()
        end
    )
)

return mic_widget
