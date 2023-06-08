-- Global Variables
terminal = "xfce4-terminal"

editor = os.getenv("EDITOR") or "editor"

editor_cmd = terminal .. " -e " .. editor

modkey = "Mod4"

backdrop_opacity = 0.2
inactive_opacity = 0.7

margins = { left=0, bottom=0, right=0, top=0 }

floating_sizes = {
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
