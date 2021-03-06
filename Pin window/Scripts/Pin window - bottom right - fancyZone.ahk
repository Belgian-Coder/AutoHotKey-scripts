﻿; This script was made specificaly for a custom layout made with FancyZones from Microsoft PowerToys
; FancyZone has accepted the following feature: Send a window to a specific zone by pressing a designated key combination
; Until this features is release, this script will act like a simple version for my specific use case
;
; Current custom Layout scheme:
;  _________________________
; |              |          |
; |              |  zone 2  |
; |    zone 1    |----------|
; |              |  zone 3  |
; |______________|__________|
;
; NOTE: Zones may differ in size depending on configuration and screen size, this will not affect this script
; NOTE: script works only on main monitor when using multiple displays, you can change the main monitor in your windows display settings

#SingleInstance force

global HEIGHT_MARGIN := 30
global WIDTH_MARGIN := 20
global NUMBER_OF_TRIES := 8
global SLEEP_BETWEEN_COMMANDS := 50
global SLEEP_BETWEEN_KEY_PRESS := 10
global ALWAYS_ON_TOP_LABEL := " (always on top)"

; On win + alt + space toggle active window always on top
#!Space up::

    Winset, AlwaysOnTop, Toggle, A
    ToggleWindowTitleAlwaysOnTop(0)

return

; On win + alt + arrowLeft move and resize active window to zone 1 on the left
#!Left up::

    MoveActiveWindowToZoneLeft()

return

; On win + alt + arrowRight move and resize active window to zone 2 on the top right
#!Right up::

    MoveActiveWindowToZoneTopRight()

return

; On win + alt + arrowDown move and resize active window to zone 3 on the bottom right
#!Down up::

    MoveActiveWindowToZoneBottomRight()

return

; On win + alt + arrowUp maximize active window 
#!Up up::

    WinMaximize, A

return

; On win + alt + y set active window to always on top and move and resize to zone 3 on the bottom right
#!y up::

    MoveActiveWindowToZoneBottomRight()
    Winset, AlwaysOnTop, On, A
    ToggleWindowTitleAlwaysOnTop(1)

return

MoveActiveWindowToZoneLeft() {

    ; retrieve screen workarea, subtracted task- and toolbars
    SysGet, MonitorWorkArea, MonitorWorkArea

    ; Set loop to higher max due to different system speeds
    Loop % NUMBER_OF_TRIES {
        ; Get position of active window
        WinGetPos, WinX, WinY, WinW, WinH, A

        if (IsWindowAgainstLeftSide(MonitorWorkAreaLeft, WinX, WinW) and IsWindowAgainstTopSide(MonitorWorkAreaTop, WinY, WinH) and IsWindowAgainstBottomSide(MonitorWorkAreaBottom, WinY, WinH) and !IsWindowAgainstRightSide(MonitorWorkAreaRight, WinX, WinW)) {
            break
        }

        if (IsWindowAgainstRightSide(MonitorWorkAreaRight, WinX, WinW)) {
            SendEvent #{Left}{LWin Up}
            Sleep % SLEEP_BETWEEN_COMMANDS
        } else if (!IsWindowAgainstBottomSide(MonitorWorkAreaBottom, WinY, WinH)) {
            SendEvent #{Left}{LWin Up}
            Sleep % SLEEP_BETWEEN_COMMANDS
        } else if (!IsWindowAgainstTopSide(MonitorWozxrkAreaTop, WinY, WinH)) {
            SendEvent #{Left}{LWin Up}
            Sleep % SLEEP_BETWEEN_COMMANDS
        }
    }

return
}

MoveActiveWindowToZoneTopRight() {

    ; retrieve screen workarea, subtracted task- and toolbars
    SysGet, MonitorWorkArea, MonitorWorkArea

    ; Set loop to higher max due to different system speeds
    Loop % NUMBER_OF_TRIES {
        ; Get position of active window
        WinGetPos, WinX, WinY, WinW, WinH, A

        if (!IsWindowAgainstLeftSide(MonitorWorkAreaLeft, WinX, WinW) and IsWindowAgainstTopSide(MonitorWorkAreaTop, WinY, WinH) and !IsWindowAgainstBottomSide(MonitorWorkAreaBottom, WinY, WinH) and IsWindowAgainstRightSide(MonitorWorkAreaRight, WinX, WinW)) {
            break
        }

        if (IsWindowAgainstLeftSide(MonitorWorkAreaLeft, WinX, WinW)) {
            SendEvent #{Right}{LWin Up}
            Sleep % SLEEP_BETWEEN_COMMANDS
        } else if (!IsWindowAgainstRightSide(MonitorWorkAreaRight, WinX, WinW)) {
            SendEvent #{Left}{LWin Up}
            Sleep % SLEEP_BETWEEN_COMMANDS
        } else if (IsWindowAgainstBottomSide(MonitorWorkAreaBottom, WinY, WinH)) {
            SendEvent #{Up}{LWin Up}
            Sleep % SLEEP_BETWEEN_COMMANDS
        } else if (!IsWindowAgainstTopSide(MonitorWorkAreaTop, WinY, WinH)) {
            SendEvent #{Up}{LWin Up}
            Sleep % SLEEP_BETWEEN_COMMANDS
        }
    }

return
}

MoveActiveWindowToZoneBottomRight() {

    ; retrieve screen workarea, subtracted task- and toolbars
    SysGet, MonitorWorkArea, MonitorWorkArea

    ; Set loop to higher max due to different system speeds
    Loop % NUMBER_OF_TRIES {
        ; Get position of active window
        WinGetPos, WinX, WinY, WinW, WinH, A

        if (!IsWindowAgainstLeftSide(MonitorWorkAreaLeft, WinX, WinW) and !IsWindowAgainstTopSide(MonitorWorkAreaTop, WinY, WinH) and IsWindowAgainstBottomSide(MonitorWorkAreaBottom, WinY, WinH) and IsWindowAgainstRightSide(MonitorWorkAreaRight, WinX, WinW)) {
            break
        }

        if (IsWindowAgainstLeftSide(MonitorWorkAreaLeft, WinX, WinW)) {
            SendEvent #{Right}{LWin Up}
            Sleep % SLEEP_BETWEEN_COMMANDS
        } else if (!IsWindowAgainstRightSide(MonitorWorkAreaRight, WinX, WinW)) {
            SendEvent #{Left}{LWin Up}
            Sleep % SLEEP_BETWEEN_COMMANDS
        } else if (IsWindowAgainstTopSide(MonitorWorkAreaTop, WinY, WinH)) {
            SendEvent #{Down}{LWin Up}
            Sleep % SLEEP_BETWEEN_COMMANDS
        } else if (!IsWindowAgainstBottomSide(MonitorWorkAreaBottom, WinY, WinH)) {
            SendEvent #{Down}{LWin Up}
            Sleep % SLEEP_BETWEEN_COMMANDS
        }
    }

return
}

IsWindowAgainstLeftSide(monitorLeft, winX, winWidth) {
    if ((winX - WIDTH_MARGIN - monitorLeft) <= 0 and (winX + winWidth) >= monitorLeft and (winX) > (monitorLeft - WIDTH_MARGIN)) {
        return true
    }
return false
}

IsWindowAgainstTopSide(monitorUp, winY, winHeight) {
    if ((winY - HEIGHT_MARGIN - monitorUp) <= 0 and (winY + winHeight) >= monitorUp and (winY) > (monitorBottom - HEIGHT_MARGIN)){
        return true
    }
return false
}

IsWindowAgainstBottomSide(monitorBottom, winY, winHeight) {
    if ((winY + HEIGHT_MARGIN) < monitorBottom and (winY + winHeight + HEIGHT_MARGIN) > monitorBottom and (winY + winHeight) < (monitorBottom + HEIGHT_MARGIN)) {
        return true
    }
return false
}

IsWindowAgainstRightSide(monitorRight, winX, winWidth) {
    if (winX < monitorRight and (winX + winWidth + WIDTH_MARGIN) >= monitorRight and (winX + winWidth) < (monitorRight + WIDTH_MARGIN)) {
        return true
    }
return false
}

ToggleWindowTitleAlwaysOnTop(forceOn) {

    WinGetActiveTitle, WinTitle
    StringLen, labelLength, ALWAYS_ON_TOP_LABEL
    StringRight, TextAtEnd, WinTitle, labelLength

    if (TextAtEnd == ALWAYS_ON_TOP_LABEL and forceOn == 0) {
        newTitle = % SubStr(WinTitle,1,StrLen(WinTitle)-labelLength)
        WinSetTitle, A,, %newTitle%
        return
    }

    newTitle = %WinTitle%%ALWAYS_ON_TOP_LABEL%
    WinSetTitle, A,, %newTitle%
return
}