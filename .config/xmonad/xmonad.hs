--------------------------------------------------------------------------------------
-- IMPORTS
--------------------------------------------------------------------------------------

-- Base
import XMonad

-- Data
import Data.Monoid

-- Utilities
import XMonad.Util.EZConfig

-- System
import System.IO
import System.Exit

-- Qualified
import qualified XMonad.StackSet as W
import qualified Data.Map        as M

--------------------------------------------------------------------------------------
-- VARIABLES
--------------------------------------------------------------------------------------

myTerminal      = "alacritty"

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

myClickJustFocuses :: Bool
myClickJustFocuses = False

myBorderWidth   = 1

myModMask       = mod4Mask

myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]

myNormalBorderColor  = "#dddddd"
myFocusedBorderColor = "#ff0000"

myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $
    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))
    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))
    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))
    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

myLayout = tiled ||| Mirror tiled ||| Full
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio
     -- The default number of windows in the master pane
     nmaster = 1
     -- Default proportion of screen occupied by master pane
     ratio   = 1/2
     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

myManageHook = composeAll
    [ className =? "Picture-in-Picture" --> doFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore ]

myEventHook = mempty
myLogHook = return ()
myStartupHook = return ()

main :: IO ()
main = xmonad $ def
    {
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,
      -- key bindings
        mouseBindings      = myMouseBindings,
      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    }
  `additionalKeysP`
    [ ("M-<Return>", spawn "alacritty"),
      ("M-d", spawn "dmenu_run"),
      ("M-S-q", kill),
      ("M-S-<Down>", spawn "brightnessctl set 355-"),
      ("M-S-<Up>", spawn "brightnessctl set 355+"),
      ("M-<Space>", sendMessage NextLayout),
      -- ("M-S-<Space>", setLayout $ XMonad.layoutHook conf),
      ("M-n", refresh),
      ("M-<Tab>", windows W.focusDown),
      ("M-j", windows W.focusDown),
      ("M-k", windows W.focusUp),
      ("M-m", windows W.focusMaster),
      ("M-S-o", io (exitWith ExitSuccess))
      
    ]
