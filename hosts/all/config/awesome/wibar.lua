local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

require("globals")

local mysystray = wibox.layout.margin(wibox.widget.systray(), 3, 3, 3, 3)

local taglist_buttons = gears.table.join(
    awful.button({}, 1, function(t) t:view_only() end),
    awful.button({ MODKEY }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({}, 3, awful.tag.viewtoggle),
    awful.button({ MODKEY }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
    awful.button({}, 1, function(c)
        if c == client.focus then
            c.minimized = true
        else
            c:emit_signal(
                "request::activate",
                "tasklist",
                { raise = true }
            )
        end
    end),
    awful.button({}, 3, function()
        --awful.menu.client_list({ theme = { width = 250 } })
        awful.tag.history.restore()
    end),
    awful.button({}, 4, function()
        awful.client.focus.byidx(1)
    end),
    awful.button({}, 5, function()
        awful.client.focus.byidx(-1)
    end)
)

local function setup_right_widgets()
    local battery_widget = require("widgets.battery-widget.battery")
    local volume_widget = require('widgets.pactl-widget.volume')
    local cmus_widget = require('widgets.cmus')
    local capslock = require('widgets.capslock')
    local mic = require('widgets.mic')

    local function timeHome(timezone)
        return wibox.layout.margin(
            wibox.widget.textclock("<span foreground='#ddd' weight='bold'>%b %d  %H:%M</span>", nil, timezone),
            4, 4, 0, 0
        )
    end

    local function timeAbroad(label, timezone)
        return wibox.layout.margin(
            wibox.widget.textclock(
                "<span foreground='#aaa' weight='bold'><span foreground='#666'>" .. label .. "</span> %H:%M</span>",
                nil,
                timezone
            ),
            4, 4, 0, 0
        )
    end

    local myvolume = wibox.layout.margin(
        volume_widget {
            widget_type = "icon_and_text",
            main_color = "#dddddd",
            bg_color = "#666666",
            with_icon = false,
        }, 4, 0, 4, 4
    )

    if awesome.hostname == "pale" then
        return {
            layout = wibox.layout.fixed.horizontal,
            spacing = 4,
            capslock,
            mic,
            myvolume,
            cmus_widget {},
            battery_widget(),
            timeAbroad("ON", "America/Toronto"),
            timeAbroad("UK", "Europe/London"),
            timeAbroad("PL", "Europe/Warsaw"),
            timeAbroad("JP", "Asia/Tokyo"),
            timeHome("Asia/Taipei"),
            mysystray
        }
    else
        return {
            layout = wibox.layout.fixed.horizontal,
            spacing = 4,
            capslock,
            mic,
            myvolume,
            cmus_widget {},
            battery_widget(),
            timeAbroad("PL", "Europe/Warsaw"),
            timeHome("Asia/Taipei"),
            mysystray
        }
    end
end

local function setup_wibox(s)
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
        s.mytasklist,         -- Middle widget
        setup_right_widgets() -- Right widgets
    }
end

local function setup_wibar(s)
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.noempty,
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        layout  = {
            layout = wibox.layout.flex.horizontal
        },
        style   = {
            font = "Fira Code Bold 8",
            align = "center",
        },
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }

    setup_wibox(s)
end

return setup_wibar
