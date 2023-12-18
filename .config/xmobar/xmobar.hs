Config
    { font = "xft:DejaVu Sans Mono:size=11:antialias=true"
    , additionalFonts = []
    , borderColor = "#99918A"
    , border = TopB
    , bgColor = "#282C34"
    , fgColor = "#8be9fd"
    , alpha = 255
    , position = Top
    , textOffset = -1
    , iconOffset = -1
    , lowerOnStart = True
    , pickBroadest = False
    , persistent = True
    , hideOnStart = False
    , iconRoot = "."
    , allDesktops = True
    , overrideRedirect = True
    , commands =
        [ Run StdinReader
        , Run Date "%a %b %_d %Y %H:%M:%S" "date" 10
        ]
    , sepChar = "%"
    , alignSep = "}{"
    , template = " %StdinReader% }{ <fc=#FFFFCC>%date%</fc> "
    }

