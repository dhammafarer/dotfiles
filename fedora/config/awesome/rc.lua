-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local naughty = require("naughty")

require("awful.autofocus")

require('widgets/micky')

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

local globalkeys = require("globalkeys")

local screencount = screen:count()

awful.screen.connect_for_each_screen(function(s)
    local setup_wibar = require("wibar")
    setup_wibar(s)

    gears.wallpaper.set(beautiful.bg_normal)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    local tags = require("tags")

    for i, t in ipairs(tags) do
        -- only one screen, set all screen values of tagt to 1
        if t.screen > screencount then
            t.screen = 1
            t.selected = false
            t.index = i
        end

        -- only create a tag, if screen index matches screen value of tag
        if s.index == t.screen then
            awful.tag.add(t.name, {
                index = t.index,
                layout = t.layout,
                selected = t.selected,
                screen = t.screen,
                master_width_factor = t.master_width_factor,
                master_count = t.master_count,
                column_count = t.column_count,
                gap_single_client = t.gap_single_client,
                gap = t.gap,
            })

            -- set up keymappings for each screen
            local scr = screen[t.screen]

            globalkeys = gears.table.join(globalkeys,
                -- View tag only.
                awful.key({ MODKEY }, t.key,
                    function()
                        awful.screen.focus(scr)
                        local tag = scr.tags[t.index]
                        if tag then
                            tag:view_only()
                        end
                    end,
                    { description = "view tag #" .. i, group = "tag" }
                ),

                -- Move client to tag.
                awful.key({ MODKEY, "Shift" }, t.key,
                    function()
                        if client.focus then
                            client.focus:move_to_screen(scr)
                            local tag = scr.tags[t.index]
                            if tag then
                                client.focus:move_to_tag(tag)
                            end
                        end
                    end,
                    { description = "move focused client to tag #" .. i, group = "tag" }
                ),

                -- Move client and view tag.
                awful.key({ MODKEY, ALTKEY }, t.key,
                    function()
                        if client.focus then
                            client.focus:move_to_screen(scr)
                            local tag = scr.tags[t.index]
                            if tag then
                                client.focus:move_to_tag(tag)
                                tag:view_only()
                            end
                        end
                    end,
                    { description = "move focused client to tag #" .. i, group = "tag" }
                )
            )
        end
    end
end)

root.keys(globalkeys)

require("rules")
require("signals")

awesome.spawn(gears.filesystem.get_configuration_dir() .. "autostart.sh")
