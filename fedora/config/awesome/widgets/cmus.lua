local awful = require("awful")
local wibox = require("wibox")
local watch = require("awful.widget.watch")
local spawn = require("awful.spawn")
local beautiful = require('beautiful')

local function ellipsize(text, length)
    -- utf8 only available in Lua 5.3+
    if utf8 == nil then
        return text:sub(0, length)
    end
    return (utf8.len(text) > length and length > 0)
        and text:sub(0, utf8.offset(text, length - 2) - 1) .. '...'
        or text
end

local cmus_widget = {}

local function worker(user_args)
    local args = user_args or {}
    local font = args.font or beautiful.font

    local timeout = args.timeout or 10
    local max_length = args.max_length or 30
    local space = args.space or 5

    cmus_widget.widget = wibox.widget {
        {
            id = "text",
            font = font,
            widget = wibox.widget.textbox
        },
        {
            id = "volume",
            font = font,
            widget = wibox.widget.textbox
        },
        spacing = space,
        layout = wibox.layout.fixed.horizontal,
        set_title = function(self, title)
            self:get_children_by_id("text")[1]:set_text(title)
        end,
        update_volume = function(self, volume)
            local fmt = "(" .. volume .. "%)"
            self:get_children_by_id("volume")[1]:set_text(fmt)
        end
    }

    local function update_widget(widget, stdout, _, _, code)
        if code == 0 then
            local cmus_info = {}

            for s in stdout:gmatch("[^\r\n]+") do
                local stream = string.match(s, "^stream (.+)$")
                local status = string.match(s, "^status (.+)$")
                local volume = string.match(s, "^set vol_left (.+)$")

                if stream then
                    cmus_info["stream"] = stream
                end

                if status then
                    cmus_info["status"] = status
                end

                if volume then
                    cmus_info["volume"] = volume
                end
            end

            local title = cmus_info.stream
            local volume = cmus_info.volume

            if title then
                if cmus_info["status"] == "playing" then
                    widget:set_title(ellipsize(title, max_length))
                    widget:update_volume(volume)
                    widget.visible = true
                else
                    widget.visible = false
                end
            end
        else
            widget.visible = false
        end
    end

    function cmus_widget:update()
        spawn.easy_async("cmus-remote -Q",
            function(stdout, _, _, code)
                update_widget(cmus_widget.widget, stdout, _, _, code)
            end)
    end

    function cmus_widget:play_pause()
        spawn("cmus-remote -u")
        cmus_widget.update(nil)
    end

    function cmus_widget:vol_up()
        spawn("cmus-remote -v +5")
        cmus_widget.update(nil)
    end

    function cmus_widget:vol_down()
        spawn("cmus-remote -v -5")
        cmus_widget.update(nil)
    end

    cmus_widget.widget:buttons(
        awful.util.table.join(
            awful.button({}, 1, function() cmus_widget:play_pause() end),
            awful.button({}, 4, function() cmus_widget:vol_up() end),
            awful.button({}, 5, function() cmus_widget:vol_down() end)
        )
    )

    watch("cmus-remote -Q", timeout, update_widget, cmus_widget.widget)

    return cmus_widget.widget
end

return setmetatable(cmus_widget, {
    __call = function(_, ...)
        return worker(...)
    end
})
