-- Global Variables
TERMINAL = "xfce4-terminal"

EDITOR = os.getenv("EDITOR") or "editor"

MODKEY = "Mod4"

DEFAULT_INACTIVE_OPACITY = 0.85

BACKDROP_OPACITY = 0.00

Inactive_opacity = DEFAULT_INACTIVE_OPACITY

MARGINS = { left=0, bottom=0, right=0, top=0 }

FLOATING_SIZES = {
  [1] = function (c)
      c.width = 640
      c.height = 360
    end,
  [2] = function (c)
      c.width = 854
      c.height = 480
    end,
  [3] = function (c)
      c.width = 1280
      c.height = 720
    end,
  [4] = function (c)
      c.width = 474
      c.height = 266
    end,
}

Urgent_Clients = {}
