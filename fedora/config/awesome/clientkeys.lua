local gears = require("gears")
local awful = require("awful")
local naughty = require("naughty")

local tags = require("tags")

require("globals")

local function set_align(position, c)
    awful.placement.align(c, { position = position, margins = MARGINS })
    c.align = position
end

local function dim_clients_except(m)
    for _, x in ipairs(mouse.screen.selected_tag:clients()) do
        if x ~= m then
            x.opacity = BACKDROP_OPACITY
        end
    end
end

local clientkeys = gears.table.join(
-- Next Layout
    awful.key({ MODKEY, "Control" }, "f",
        function(c)
            c.fullscreen = not c.fullscreen; c:raise()
        end,
        { description = "toggle fullscreen", group = "client" }
    ),

    -- Close Client
    awful.key({ MODKEY }, "q", function(c)
            if Urgent == c then
                Urgent = nil
                naughty.destroy_all_notifications()
            end
            c:kill()
        end,
        { description = "close", group = "client" }),

    -- Toggle floating
    awful.key({ MODKEY, "Control" }, "z", function(c)
            c.sticky = false
            c.ontop = false

            if c.floating then
                c.floating = false
                c.opacity = 1
                c.maximized = false

                -- restore opacity on tiling clients
                for _, x in ipairs(mouse.screen.selected_tag:clients()) do
                    if not x.floating then
                        x.opacity = 1
                    end
                end
                return
            end

            c.floating = true

            c.width = 1280
            c.height = 720

            awful.placement.centered(c, nil)

            c:raise()
        end,
        { description = "toggle floating", group = "client" }
    ),

    awful.key({ MODKEY }, "/",
        function(c)
            local master = awful.client.getmaster()

            if c == master then
                awful.client.swap.byidx(1)
                c:swap(master)
                awful.client.focus.byidx(-1)
            else
                c:swap(master)
            end
        end,
        { description = "move to master", group = "client" }
    ),

    --    awful.key({ MODKEY, "Control" }, "u",
    --        function(c)
    --            local m = awful.client.getmaster()
    --            if c == m then
    --                awful.client.swap.byidx(1)
    --                c:swap(m)
    --                awful.client.focus.byidx(-1)
    --            else
    --                c:swap(m)
    --            end
    --            awful.layout.set(LAYOUT_CENTER)
    --            m = awful.client.getmaster()
    --            dim_clients_except(m)
    --        end,
    --        { description = "swap with master centered", group = "client" }
    --    ),
    awful.key({ MODKEY, "Control" }, "u",
        function()
            local m = awful.client.getmaster()
            local stacked = not m.floating

            for _, c in ipairs(mouse.screen.selected_tag:clients()) do
                c.floating = stacked

                c.width = ((1920 / 2) - 14)
                c.height = (1080 - 42)

                awful.placement.align(c, {
                    position = "bottom",
                    margins = { left = 0, bottom = 8, right = 0, top = 0 }
                })
                c.align = "bottom"
            end
        end,
        { description = "toggle float centered", group = "client" }
    ),

    -- reset opacity to 1
    awful.key({ MODKEY, "Control", "Shift" }, "i", function(c)
            c.opacity = 1
        end,
        { description = "toggle opacity", group = "client" }
    ),

    -- reset opacity to lowest
    awful.key({ MODKEY, "Control", "Shift" }, "e", function(c)
            c.opacity = BACKDROP_OPACITY
        end,
        { description = "toggle opacity", group = "client" }
    ),

    -- place window in lower left corner
    awful.key({ MODKEY, "Control", "Shift" }, "Left", function(c)
            set_align("bottom_left", c)
        end,
        { description = "set placement to bottom_left", group = "client" }
    ),

    -- place window in lower right corner
    awful.key({ MODKEY, "Control", "Shift" }, "Right", function(c)
            set_align("bottom_right", c)
        end,
        { description = "set placement to bottom_right", group = "client" }
    ),

    awful.key({ MODKEY, "Control", "Shift" }, "Up", function(c)
            set_align("centered", c)

            c.floating = true
            c.ontop = false
            c.sticky = false
        end,
        { description = "toggle floating", group = "client" }
    ),

    awful.key({ MODKEY }, "j",
        function(c)
            c.ontop = not c.ontop
        end,
        { description = "toggle ontop", group = "client" }
    ),

    awful.key({ MODKEY, "Control" }, "m",
        function(c)
            local name = mouse.screen.selected_tag.name;

            if not OPACITY[name] or OPACITY[name] ~= BACKDROP_OPACITY then
                OPACITY[name] = BACKDROP_OPACITY
            else
                OPACITY[name] = DEFAULT_INACTIVE_OPACITY
            end

            for _, x in ipairs(mouse.screen.selected_tag:clients()) do
                if x ~= c then
                    x.opacity = OPACITY[name]
                end
            end
            c.opacity = 1
        end,
        { description = "toggle reading mode", group = "client" }
    ),

    -- toggle backdrop on client
    awful.key({ MODKEY, "Control" }, "h",
        function(c)
            c.backdrop = not c.backdrop
        end,
        { description = "toggle backdrop", group = "client" }
    ),

    -- toggle visibility of backdrop client
    awful.key({ MODKEY }, "h",
        function(c)
            if c.backdrop then
                c.ontop = false
                c.minimized = true
            else
                local cr = awful.client.restore()
                -- Focus restored client
                if cr then
                    cr:raise()
                    cr.ontop = true
                    client.focus = cr
                end
            end
        end,
        { description = "toggle minimize backdrop", group = "client" }),

    -- Next Layout
    awful.key({ MODKEY }, "f",
        function(c)
            c.floating = false
            if awful.layout.getname() == LAYOUT_MAX_NAME then
                awful.layout.set(tags[mouse.screen.selected_tag.index].layout)
                for _, x in ipairs(mouse.screen.selected_tag:clients()) do
                    if not x.floating then
                        x.opacity = 1
                    end
                end
            else
                awful.layout.set(LAYOUT_MAX)
            end
        end, { description = "select next", group = "client" })
)

local function position_floating(idx, c)
    local pos = c.align or "centered"

    c.floating = true

    if FLOATING_SIZES[idx] then
        FLOATING_SIZES[idx](c)
        awful.placement.align(c, { position = pos, margins = MARGINS })
    end
end

for i = 1, 9 do
    clientkeys = gears.table.join(clientkeys,
        awful.key({ MODKEY }, "#" .. i + 9,
            function(c)
                position_floating(i, c)
            end,
            { description = "set floating with position #" .. i, group = "client" }
        )
    )
end

return clientkeys
