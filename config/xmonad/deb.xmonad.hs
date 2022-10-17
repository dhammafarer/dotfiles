import           Data.Default
import qualified Data.Map                        as M
import           Graphics.X11.ExtraTypes.XF86
import           System.Exit
import           System.IO
import           XMonad                          hiding ((|||))
import           XMonad.Actions.CycleWS
import           XMonad.Actions.FloatKeys
import           XMonad.Actions.PhysicalScreens
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.EwmhDesktops
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.ManageHelpers
import           XMonad.Hooks.SetWMName
import           XMonad.Layout.Fullscreen
import           XMonad.Layout.Gaps
import           XMonad.Layout.LayoutCombinators
import           XMonad.Layout.NoBorders
import           XMonad.Layout.PerWorkspace
import           XMonad.Layout.Spacing
import           XMonad.Layout.Spiral
import           XMonad.Layout.Tabbed
import           XMonad.Layout.ThreeColumns
import           XMonad.Layout.TwoPane
import qualified XMonad.StackSet                 as W
import           XMonad.Util.EZConfig            (additionalKeys)
import           XMonad.Util.Run                 (spawnPipe)


------------------------------------------------------------------------
-- Colors and borders
--
blue = "#5294e2"
midblue = "#383C4A"
darkblue = "#506d9c"
fgcolor = "#666666"
bgcolor = "#2f343f"
yellow = "#ffbd7a"
white = "#D3D7CF"
pink = "#e96a9d"
green1 = "#5de489"
green2 = "#83e6a3"
tabActive = bgcolor
tabInactive = bgcolor

myNormalBorderColor  = bgcolor
myFocusedBorderColor = blue
xmobarTitleColor = white
xmobarCurrentWorkspaceColor = white
myBorderWidth = 1

-- Colors for text and backgrounds of each tab when in "Tabbed" layout.
tabConfig = def {
    fontName = "xft:Ubuntu:style=Bold:pixelsize=11:antialias=true:hinting=true",
    activeTextColor = white,
    inactiveTextColor = fgcolor,
    activeColor = tabActive,
    activeBorderColor = tabActive,
    inactiveColor = tabInactive,
    inactiveBorderColor = tabInactive
}

------------------------------------------------------------------------
-- Terminal and Launcher
myTerminal = "xfce4-terminal -T 'DEBIAN TERMINAL'"
myLauncher = "dmenu_run -i -nb '" ++ bgcolor ++ "' -sb '" ++ green2 ++ "' -sf '" ++ bgcolor ++ "' -fn 'Ubuntu 11'"

-- location of mobar config
myXmobarrc = "~/.xmonad/xmobar.hs"

-- Spacing between windows
mySpacing = spacingRaw True (Border 0 10 10 10) True (Border 10 10 10 10) True

------------------------------------------------------------------------
-- Workspaces
code     = "\xf120"
web      = "\xf268"
comm     = "\xf4ad"
design   = "\xf1b2"
media    = "\xf1fc"
win      = "\xf17a"
tablet   = "\xf26c"

myWorkspaces = [code,tablet,web,comm,media,design,win]


------------------------------------------------------------------------
-- Window rules
--
-- xprop | grep WM_CLASS
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ resource  =? "desktop_window"      --> doIgnore
    , className =? "thunderbird-default" --> doShift comm
    , className =? "discord"             --> doShift comm
    , className =? "Signal"              --> doShift comm
    , className =? "Gimp"                --> doShift media
    , className =? "Blender"             --> doShift design
    , className =? "superProductivity"   --> doShift win
    , className =? "libreoffice-writer"  --> doShift design
    , resource  =? "gpicview"            --> doFloat
    , className =? "MPlayer"             --> doFloat
    , className =? "VirtualBox Manager"  --> doShift win
    , className =? "Qemu-system-x86_64"  --> doShift win
    , className =? "krita"               --> doShift tablet
    , className =? "Steam"               --> doShift tablet
    , className =? "tutanota-desktop"    --> doShift tablet
    , className =? "stalonetray"         --> doIgnore
    , isFullscreen --> (doF W.focusDown <+> doFullFloat)]


------------------------------------------------------------------------
-- #Layouts
-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
l0 = avoidStruts (
      ThreeColMid 1 (3/100) (1/2)
      ||| tabbed shrinkText tabConfig
      ||| Full
      ||| TwoPane (3/100) (1/2)
      ||| Mirror (TwoPane (3/100) (1/2))
      ||| Tall 1 (3/100) (1/2)
      ||| Mirror (Tall 1 (3/100) (1/2))
      ||| spiral (6/7)
    )
    ||| noBorders (fullscreenFull Full)

gaps_tab_tall = avoidStruts (
      gaps [(U,160),(R,530),(L,530),(D,160)] $
      tabbedBottomAlways shrinkText tabConfig
      ||| Tall 1 (3/100) (1/2)
    )

ft = avoidStruts (
      Full
      ||| Tall 1 (3/100) (1/2)
    )

gt2t = avoidStruts (
      gaps [(U,160),(R,530),(L,530),(D,160)] $
      Tall 2 (3/100) (1/2)
      ||| tabbedBottomAlways shrinkText tabConfig
    )

--fsf= noBorders (fullscreenFull Full) ||| tabbedBottom shrinkText tabConfig
fsf= noBorders (tabbedBottom shrinkText tabConfig)

myLayout = onWorkspace code gaps_tab_tall
           $ onWorkspace tablet fsf
           $ onWorkspace comm gt2t
           $ onWorkspace media fsf
           $ onWorkspace design ft
           $ onWorkspace win fsf
           $ onWorkspace web gaps_tab_tall
           l0

------------------------------------------------------------------------
-- Key bindings
--
myModMask = mod4Mask

myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
  ----------------------------------------------------------------------
  -- Custom key bindings
  --

  -- Start a terminal.
  [ ((modMask .|. controlMask, xK_Return), spawn $ XMonad.terminal conf)

  -- Start a launcher.
  , ((modMask, xK_v), spawn myLauncher)

  --------------------------------------------------------------------
  -- "Standard" xmonad key bindings
  --

  -- Close focused window.
  , ((modMask, xK_q), kill)

  -- Cycle through the available layout algorithms.
  , ((modMask, xK_s), sendMessage NextLayout)

  -- Jump to TwoPane
  , ((modMask, xK_j), sendMessage $ JumpToLayout "TwoPane")


  --  Reset the layouts on the current workspace to default.
  , ((modMask .|. shiftMask, xK_space), setLayout $ XMonad.layoutHook conf)

  -- Resize viewed windows to the correct size.
  , ((modMask, xK_y), refresh)

  -- Move focus to the next window.
  , ((modMask, xK_t), windows W.focusDown)

  -- Move focus to the previous window.
  , ((modMask, xK_r), windows W.focusUp  )

  -- Move focus to the master window.
  , ((modMask, xK_k), windows W.focusMaster  )

  -- Swap the focused window and the master window.
  , ((modMask .|. shiftMask, xK_v), windows W.swapMaster)

  -- Swap the focused window with the next window.
  , ((modMask .|. controlMask, xK_t), windows W.swapDown  )

  -- Swap the focused window with the previous window.
  , ((modMask .|. controlMask, xK_r), windows W.swapUp    )

  -- Shrink the master area.
  , ((modMask, xK_n), sendMessage Shrink)

  -- Expand the master area.
  , ((modMask, xK_i), sendMessage Expand)

  -- Push window back into tiling.
  , ((modMask .|. controlMask, xK_c), withFocused $ windows . W.sink)

  -- Next Screen.
  --, ((modMask, xK_space), nextScreen)

  -- Gaps bindings
  , ((modMask, xK_z), sendMessage $ ToggleGaps)               -- toggle all gaps
  , ((modMask .|. controlMask, xK_i), sendMessage $ weakModifyGaps halveHor)  -- halve the left and right-hand gaps
  , ((modMask .|. controlMask, xK_n), sendMessage $ weakModifyGaps doubleHor)  -- double the left and right-hand gaps
  , ((modMask .|. controlMask, xK_u), sendMessage $ weakModifyGaps halveVer)  -- halve the up and down gaps
  , ((modMask .|. controlMask, xK_e), sendMessage $ weakModifyGaps doubleVer)  -- double the up and down gaps
  , ((modMask .|. controlMask, xK_h), sendMessage $ setGaps [(U,160),(R,434),(L,434),(D,160)]) -- reset the GapSpec


  -- Move and resize floating window.
  --, ((modMask .|. controlMask, xK_x), withFocused (keysResizeWindow (-1440,-810) (0,1)))

  -- Increment the number of windows in the master area.
  , ((modMask, xK_comma), sendMessage (IncMasterN 1))

  -- Decrement the number of windows in the master area.
  , ((modMask, xK_period), sendMessage (IncMasterN (-1)))

  -- Quit xmonad.
  , ((modMask .|. shiftMask, xK_m), io (exitWith ExitSuccess))

  -- Restart xmonad.
  , ((modMask .|. shiftMask, xK_x), restart "xmonad" True)
  ]
  -- view screen
  ++

  [((modMask .|. mask, key), f sc)
    | (key, sc) <- zip [xK_u, xK_e] [0..]
    , (f, mask) <- [(viewScreen def, 0), (sendToScreen def, shiftMask)]]

  ++

  -- mod-[1..9], Switch to workspace N
  -- mod-shift-[1..9], Move client to workspace N
  [((m .|. modMask, k), windows $ f i)
    | (i, k) <- zip ((XMonad.workspaces conf) ++ (XMonad.workspaces conf)) ([xK_w, xK_x, xK_f, xK_a, xK_d, xK_p, xK_c] ++ [xK_1, xK_2, xK_3, xK_4, xK_5, xK_6, xK_7])
      , (f, m) <- [(W.view, 0), (W.shift, controlMask)]]

    where halveHor d i  | d `elem` [L,R] = i - 32
                        | otherwise       = i
          doubleHor d i | d `elem` [L,R] = i + 32
                        | otherwise       = i
          halveVer d i  | d `elem` [U,D] = i - 16
                        | otherwise       = i
          doubleVer d i | d `elem` [U,D] = i + 16
                        | otherwise       = i

------------------------------------------------------------------------
-- Mouse bindings
--
-- Focus rules
-- True if your focus should follow your mouse cursor.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $
  [
    -- mod-button1, Set the window to floating mode and move by dragging
    ((modMask .|. controlMask, button1), (\w -> focus w >> mouseMoveWindow w))

    -- mod-button2, Raise the window to the top of the stack
     , ((modMask, button2), (\w -> focus w >> windows W.swapMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
     , ((modMask .|. controlMask, button3), (\w -> focus w >> mouseResizeWindow w))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
  ]

------------------------------------------------------------------------
-- Status bars and logging
-- Perform an arbitrary action on each internal state change or X event.
-- See the 'DynamicLog' extension for examples.
--
-- To emulate dwm's status bar
--
-- > logHook = dynamicLogDzen
--


------------------------------------------------------------------------
-- Startup hook
-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
-- myStartupHook = return ()
myStartupHook = do
    spawn "$HOME/.xmonad/autostart.sh"
    setWMName "LG3D"

------------------------------------------------------------------------
-- Run xmonad with all the defaults we set up.
--
main = do
  xmproc <- spawnPipe ("xmobar " ++ myXmobarrc)
  xmonad $ ewmh . docks $ defaults {
      logHook = dynamicLogWithPP $ xmobarPP {
            ppOutput = hPutStrLn xmproc
          , ppTitle = const ""
          --, ppTitle = xmobarColor xmobarTitleColor "" . shorten 100
          , ppCurrent = xmobarColor xmobarCurrentWorkspaceColor ""
          , ppSep = "   "
      }
      , manageHook = manageDocks <+> myManageHook
      --, handleEventHook = docksEventHook
  }


------------------------------------------------------------------------
-- Combine it all together
-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--

--defaults = defaultConfig {
defaults = def {
    -- simple stuff
    terminal           = myTerminal,
    focusFollowsMouse  = myFocusFollowsMouse,
    borderWidth        = myBorderWidth,
    modMask            = myModMask,
    workspaces         = myWorkspaces,
    normalBorderColor  = myNormalBorderColor,
    focusedBorderColor = myFocusedBorderColor,

    -- key bindings
    keys               = myKeys,
    mouseBindings      = myMouseBindings,

    -- hooks, layouts
    layoutHook         = mySpacing $ smartBorders $ myLayout,
    manageHook         = myManageHook,
    startupHook        = myStartupHook
}
