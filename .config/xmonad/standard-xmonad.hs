--------------------------------------------------------------------------------------
-- IMPORTS
--------------------------------------------------------------------------------------

-- Base
import XMonad
import System.Directory
import qualified XMonad.StackSet as W
-- Data
import Data.Monoid
import qualified Data.Map as M

-- Utilities
import XMonad.Util.EZConfig
import XMonad.Util.Run (runProcessWithInput, safeSpawn, spawnPipe)
import XMonad.Util.SpawnOnce
import XMonad.Util.NamedActions
import XMonad.Util.NamedScratchpad
import XMonad.Util.NamedWindows (getName)

-- Hooks
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Hooks.WorkspaceHistory
import XMonad.Hooks.SetWMName

-- # Support for xmobar
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP

-- Layout
import XMonad.Layout.Magnifier
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Spiral

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
myBrowser	= "firefox"

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

myClickJustFocuses :: Bool
myClickJustFocuses = False

myBorderWidth   = 2

myModMask       = mod4Mask


myNormalBorderColor  = "#99918A"
--myFocusedBorderColor = "#ff0000"
myFocusedBorderColor = "#8be9fd"

mySoundPlayer :: String
mySoundPlayer = "ffplay -nodisp -autoexit " -- The program that will play system sounds

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

myLayout = tiled ||| Mirror tiled ||| Full ||| threeCol ||| spiral (6/7)
  where
     threeCol = magnifiercz' 1.3 $ ThreeColMid nmaster delta ratio
     tiled   = Tall nmaster delta ratio
     nmaster = 1
     ratio   = 1/2
     delta   = 3/100

-- Use xprop to get wm name

myManageHook = composeAll
    [ className =? "Picture-in-Picture" --> doFloat
    , className =? "firefox"         --> doShift "1"
    , className =? "Spotify"        --> doShift "6"
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore
  ]<+> namedScratchpadManageHook myScratchPads

myEventHook = mempty

myLogHook = return ()

myStartupHook :: X ()
myStartupHook = do
  spawnOnce (mySoundPlayer ++ startupSound)

soundDir = "/opt/dtos-sounds/" -- The directory that has the sound files

startupSound  = soundDir ++ "startup-01.mp3"
shutdownSound = soundDir ++ "shutdown-01.mp3"
dmenuSound    = soundDir ++ "menu-01.mp3"
menuSound     = soundDir ++ "bubblebeam.mp3"
sagSound      = soundDir ++ "sab.mp3"
emailSound    = soundDir ++ "the-notification-email.mp3"


myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]

myScratchPads :: [NamedScratchpad]
myScratchPads = [ NS "terminal" spawnTerm findTerm manageTerm
                ]
  where
    spawnTerm  = myTerminal ++ " -t scratchpad"
    findTerm   = title =? "scratchpad"
    manageTerm = customFloating $ W.RationalRect l t w h
               where
                 h = 0.9
                 w = 0.9
                 t = 0.9 -h
                 l = 0.9 -w

main :: IO ()
main = xmonad $ xmobarProp $ def
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
      ("M-d" ,sequence_ [spawn "dmenu_run" , spawn (mySoundPlayer ++ dmenuSound)]),
      ("M-S-z", spawn "flameshot gui"),
      ("Print", spawn "flameshot gui"),
      ("M-S-q",sequence_ [kill , spawn (mySoundPlayer ++ sagSound)]),
      ("M-S-<Down>", spawn "brightnessctl set 355-"),
      ("M-S-<Up>", spawn "brightnessctl set 355+"),
      ("M-<Space>", sendMessage NextLayout),
      -- ("M-S-<Space>", setLayout $ XMonad.layoutHook conf),
      ("M-n", refresh),
      ("M-<Tab>", windows W.focusDown),
      ("M-j", windows W.focusDown),
      ("M-k", windows W.focusUp),
      ("M-m", windows W.focusMaster),
      ("M-S-o",sequence_ [spawn (mySoundPlayer ++ shutdownSound), io (exitWith ExitSuccess)]),
      ("M-S-f", spawn "firefox"),
      ("M-S-n", spawn "nemo"),
      ("M-S-b", spawn "obsidian"),
      -- Scrathpads
      ("M-C-<Return>", namedScratchpadAction myScratchPads "terminal")
    ]
