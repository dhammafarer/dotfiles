local gears = require("gears")
local awful = require("awful")
local naughty = require("naughty")

local capslock = require('widgets.capslock')
local mic = require('widgets.mic')

require("globals")

local function resize_fake_screen(delta)
   if (screen.count() ~= 2) then
      return
   end
   local geo1 = screen[1].geometry
   local geo2 = screen[2].geometry
   screen[1]:fake_resize(geo1.x - delta, geo1.y, geo1.width + delta, geo1.height)
   screen[2]:fake_resize(geo2.x, geo2.y, geo2.width - delta, geo2.height)
end

local function fullscreen_fake_screen()
     if (screen.count() ~= 2) then
        return
     end
     local focused = awful.screen.focused()
     local full_width = screen[1].geometry.width + screen[2].geometry.width
     local height = screen[1].geometry.height

     for s in screen do
         if s == focused then
             s:fake_resize(0, 0, full_width, height)
         else
             s:fake_resize(0, 0, 0, height)
         end
     end
end

--- local function exit_fake_fullscreen()
---     if (screen.count() ~= 2) then
---        return
---     end
--- end

local function set_clients_opacity(m, opacity)
    for _, x in ipairs(mouse.screen.selected_tag:clients()) do
        if x ~= m then
            x.opacity = opacity
        end
    end
end

--- local function notifyScreenFocus()
---     naughty.notify({
---         title = "Active screen",
---         position = "bottom_middle",
---         timeout = 1,
---         width = 120,
---         height = 32
---     })
--- end

local function undim_clients()
    for _, x in ipairs(mouse.screen.selected_tag:clients()) do
        x.opacity = 1
    end
end

local function toggle_layout()
    if awful.layout.getname() == LAYOUT_TILE_NAME then
        awful.layout.set(LAYOUT_CENTER)
    else
        awful.layout.set(LAYOUT_BOTTOM)
    end
end

local function focus_by_master_offset(x, opacity)
    local master = awful.client.getmaster()

    if master then
        local name = master.first_tag.name
        if awful.client.next(x, master) then
            awful.client.focus.byidx(x, master)
        end
        if opacity then
            SET_OPACITY_FOR(name, opacity)
            set_clients_opacity(master, opacity)
        else
            SET_OPACITY_FOR(name, DEFAULT_INACTIVE_OPACITY)
            undim_clients()
        end
    end
end

local globalkeys = gears.table.join(
    -- Focus screen 1
    -- awful.key({ MODKEY }, "Return",
    --     -- function() awful.screen.focus_relative(1) end,
    --     function() awful.screen.focus(1) end,
    --     { description = "focus primary screen", group = "screen" }),

    -- Focus screen 2
    awful.key({ MODKEY, "Control" }, "Return",
        function() awful.screen.focus(2) end,
        { description = "focus secondary screen", group = "screen" }),

    -- Restore last client within current tag 
    awful.key({ MODKEY }, "u",
        function()
            local list = awful.client.focus.history.list
            local current_tag = client.focus.first_tag or nil

            for i = 2, #list do
              local c = list[i]
              if c.first_tag == current_tag then
                client.focus = c
                c:raise()
                return
              end
            end
        end,
        { description = "last client", group = "tag" }),

    -- Restore client from a different tag
    awful.key({ MODKEY, "Control" }, "u",
        function()
            --- if awful.screen.focused().index ~= 1 then
            ---     awful.screen.focus(1)
            if  Urgent then
                Urgent:jump_to()
                Urgent = nil
                naughty.destroy_all_notifications()
            else
                ---awful.tag.history.restore()
                local c = awful.client.focus.history.list[2]
                client.focus = c
                local t = client.focus and client.focus.first_tag or nil
                if t then
                    t:view_only()
                end
                c:raise()
            end
        end,
        { description = "go back", group = "tag" }),


    -- Focus 2nd Client
    awful.key({ MODKEY }, "n",
        function()
            -- focus_by_master_offset(0, nil)
            awful.screen.focus(2)
            if client.focus then client.focus:raise() end
        end,
        { description = "Focus 2nd Client", group = "client" }
    ),

    awful.key({ MODKEY, "Control" }, "n",
        function()
            focus_by_master_offset(1, nil)
            toggle_layout()
        end,
        { description = "toggle reading mode off", group = "client" }
    ),

    -- Focus Master
    -- awful.key({ MODKEY }, "e",
    --     function()
    --         -- focus_by_master_offset(1, nil)
    --         awful.screen.focus_relative(1)
    --         if client.focus then client.focus:raise() end
    --     end,
    --     { description = "focus master", group = "client" }),

    -- awful.key({ MODKEY, "Control" }, "e",
    --     function()
    --         focus_by_master_offset(1, 0)
    --         -- toggle_layout()
    --         -- awful.layout.set(LAYOUT_CENTER)
    --     end,
    --     { description = "focus master", group = "client" }),

    -- Focus 3rd Client
    awful.key({ MODKEY }, "i",
        function()
            -- focus_by_master_offset(-1)
            awful.screen.focus(1)
            if client.focus then client.focus:raise() end
        end,
        { description = "Focus 3rd client", group = "client" }),

    awful.key({ MODKEY, "Control" }, "i",
        function()
            focus_by_master_offset(-1)
            toggle_layout()
        end,
        { description = "Focus 3rd client", group = "client" }),

    --[[
    awful.key({ MODKEY, "Control" }, "y",
        function()
            if awful.layout.getname() ~= LAYOUT_BOTTOM_NAME then
                awful.layout.set(LAYOUT_BOTTOM)
            else
                awful.layout.set(LAYOUT_MAX)
            end

            for _, x in ipairs(mouse.screen.selected_tag:clients()) do
                if not x.floating then
                    x.opacity = 1
                end
            end
        end,
        { description = "Horizontal split", group = "client" }),
    ---]]

    awful.key({ MODKEY }, "Tab",
        function()
            local screen = awful.screen.focused()

            if #screen.tiled_clients < 2 then
                local c = awful.client.restore()
                -- Focus restored client
                if c then
                    c:raise()
                end
            end
            awful.client.focus.byidx(1)
            for _, x in ipairs(mouse.screen.selected_tag:clients()) do
                if not x.floating then
                    x.opacity = 1
                end
            end
        end, { description = "focus next by index", group = "client" }),

    awful.key({ MODKEY, "Control" }, "Tab",
        function()
            local screen = awful.screen.focused()

            if #screen.tiled_clients < 2 then
                local c = awful.client.restore()
                -- Focus restored client
                if c then
                    c:raise()
                end
            end
            awful.client.focus.byidx(1)
            for _, x in ipairs(mouse.screen.selected_tag:clients()) do
                if not x.floating then
                    x.opacity = 1
                end
            end
        end, { description = "focus next by index", group = "client" }),

    -- navigation with arrows
    -- awful.key({ MODKEY }, "Down",
    --     function()
    --         awful.client.focus.bydirection("down")
    --         if client.focus then client.focus:raise() end
    --     end,
    --     { description = "focus down", group = "client" }),

    -- awful.key({ MODKEY, "Shift" }, "Down",
    --     function()
    --         awful.client.swap.bydirection("down")
    --     end),

    -- awful.key({ MODKEY }, "Down",
    --     function()
    --         awful.client.focus.bydirection("down")
    --         if client.focus then client.focus:raise() end
    --     end),

    -- awful.key({ MODKEY }, "Up",
    --     function()
    --         awful.client.focus.bydirection("up")
    --         if client.focus then client.focus:raise() end
    --     end),

    -- awful.key({ MODKEY, "Shift" }, "Up",
    --     function()
    --         awful.client.swap.bydirection("up")
    --     end),

    -- awful.key({ MODKEY }, "Left",
    --     function()
    --         awful.client.focus.bydirection("left")
    --         if client.focus then client.focus:raise() end
    --     end),

    -- awful.key({ MODKEY, "Shift" }, "Left",
    --     function()
    --         awful.client.swap.bydirection("left")
    --     end),

    -- awful.key({ MODKEY }, "Right",
    --     function()
    --         awful.client.focus.bydirection("right")
    --         if client.focus then client.focus:raise() end
    --     end
    -- ),

    -- awful.key({ MODKEY, "Shift" }, "Right",
    --     function()
    --         awful.client.swap.bydirection("right")
    --     end),

    -- awful.key({ MODKEY }, "u", function()
    --         --awful.layout.set(LAYOUT_CENTER)
    --         --focus_by_master_offset(0, BACKDROP_OPACITY)
    --         if awful.layout.getname() ~= LAYOUT_CENTER_NAME then
    --             awful.layout.set(LAYOUT_CENTER)
    --         else
    --             awful.layout.set(LAYOUT_MAX)
    --         end

    --     end,
    --     { description = "toggle reading mode on", group = "client" }
    -- ),

    -- awful.key({ MODKEY }, "o",
    --     function()
    --         if awful.layout.getname() ~= LAYOUT_TILE_NAME then
    --             awful.layout.set(LAYOUT_TILE)
    --         else
    --             awful.layout.set(LAYOUT_CENTER)
    --         end
    --     end, { description = "Toggle centerwork/tile", group = "client" }
    -- ),

    awful.key({ MODKEY, "Shift" }, "n",
        function()
            resize_fake_screen(380)
        end, { description = "Resize main fake screen up", group = "global" }
    ),

    awful.key({ MODKEY, "Control", "Shift" }, "i",
        function()
            fullscreen_fake_screen()
        end, { description = "Resize main fake screen up", group = "global" }
    ),

    awful.key({ MODKEY, "Shift" }, "o",
        function()
            resize_fake_screen(-380)
        end, { description = "Resize main fake screen down", group = "global" }
    ),

    awful.key({ MODKEY, "Control" }, ",",
        function()
            awful.tag.incnmaster(1, nil, true)
        end, { description = "increase the number of master clients", group = "layout" }
    ),

    awful.key({ MODKEY, "Control" }, ".",
        function() awful.tag.incnmaster(-1, nil, true) end,
        { description = "increase the number of master clients", group = "layout" }
    ),

    -- Swap with next
    awful.key({ MODKEY, "Shift" }, "Tab",
        function() awful.client.swap.byidx(1) end,
        { description = "swap with next client by index", group = "client" }
    ),

    -- Swap with previous
    awful.key({ MODKEY, "Shift", "Control" }, "Tab",
        function() awful.client.swap.byidx(-1) end,
        { description = "swap with previous client by index", group = "client" }
    ),

    -- Spawn programs
    -- awful.key({ MODKEY, "Control" }, "BackSpace",
    --     function() awful.spawn(TERMINAL) end,
    --     { description = "open a terminal", group = "launcher" }),

    awful.key({ ALTKEY }, "XF86AudioRaiseVolume",
        function() awful.spawn("cplay", { tag = "med" }) end,
        { description = "open cmus", group = "launcher" }),

    -- Reload/Quit
    awful.key({ MODKEY, "Control" }, "q", awesome.restart,
        { description = "reload awesome", group = "awesome" }
    ),

    awful.key({ MODKEY, "Shift" }, "q", awesome.quit,
        { description = "quit awesome", group = "awesome" }
    ),

    -- Master size
    awful.key({ MODKEY, "Control", "Shift" }, "o",
        function()
            awful.tag.incmwfact(0.05)

            -- Automatically switch from tiled to centered layout when the master window factor crosses a threshold
            -- if awful.layout.getname() == LAYOUT_TILE_NAME then
            --   local fct = mouse.screen.selected_tag.master_width_factor
            --   if fct > 0.70 then
            --     awful.layout.set(LAYOUT_CENTER)
            --     awful.tag.incmwfact(-0.25)
            --   end
            -- end
        end,
        { description = "increase master width factor", group = "layout" }
    ),

    awful.key({ MODKEY, "Control", "Shift" }, "n",
        function()
            awful.tag.incmwfact(-0.05)

            -- Automatically switch from centered to tiled layout when the master window factor crosses a threshold
            -- local fct = mouse.screen.selected_tag.master_width_factor
            -- if awful.layout.getname() == LAYOUT_CENTER_NAME then
            --     if fct < 0.50 then
            --         awful.layout.set(LAYOUT_TILE)
            --         awful.tag.incmwfact(0.25)
            --     end
            -- end
        end,
        { description = "decrease master width factor", group = "layout" }
    )
)

globalkeys = gears.table.join(globalkeys, capslock.key, mic.keys)

return globalkeys
