local awful = require("awful")
local beautiful = require("beautiful")
local clientkeys = require("clientkeys")
local clientbuttons = require("clientbuttons")

awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
         size_hints_honor = false,
         border_color = beautiful.border_normal,
         focus = awful.client.focus.filter,
         raise = true,
         keys = clientkeys,
         buttons = clientbuttons,
         screen = awful.screen.preferred,
         placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "pinentry",
        },
        class = {
          -- "Signal",
        },
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          -- "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = false }
    },

    { rule = { class = "firefox" },
      properties = { maximized = false } },

    { rule = { class = "Gcr-prompter" },
      properties = {
        placement = awful.placement.centered+awful.placement.no_overlap+awful.placement.no_offscreen
      }
    },

    -- Assign clients to tags
    { rule = { class = "Signal" }, properties = { tag = "〇" } },
    { rule = { class = "Slack" }, properties = { tag = "〇" } },
    { rule = { class = "Virt-manager" }, properties = { screen = 1, tag = "3" } },
    { rule = { class = "org-knopflerfish-framework-BundleThread" }, properties = { screen = 1, tag = "七" } },
}
