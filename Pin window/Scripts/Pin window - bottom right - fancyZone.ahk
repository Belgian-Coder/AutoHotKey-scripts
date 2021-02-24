; This script was made specificaly for a custom layout made with FancyZones from Microsoft PowerToys
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
global SLEEP_BETWEEN_COMMANDS := 100

; On win + alt + space toggle window always on top
#!Space up::

    Winset, AlwaysOnTop, Toggle, A

return

#!Left up::

    ; retrieve screen workarea, subtracted task- and toolbars
    SysGet, MonitorWorkArea, MonitorWorkArea

    ; Set loop to higher max due to different system speeds
    Loop % NUMBER_OF_TRIES {
        ; Get position of active window
        WinGetPos, WinX, WinY, WinW, WinH, A

        if (WindowAgainstLeftSide(MonitorWorkAreaLeft, WinX, WinW) and WindowAgainstTopSide(MonitorWorkAreaTop, WinY, WinH) and WindowAgainstBottomSide(MonitorWorkAreaBottom, WinY, WinH) and !WindowAgainstRightSide(MonitorWorkAreaRight, WinX, WinW)) {
            break
        }

        SendInput #{Left}
        Sleep % SLEEP_BETWEEN_COMMANDS
    }

return

; On left keypress send to zone 2
#!Right up::

    ; retrieve screen workarea, subtracted task- and toolbars
    SysGet, MonitorWorkArea, MonitorWorkArea

    ; Set loop to higher max due to different system speeds
    Loop % NUMBER_OF_TRIES {
        ; Get position of active window
        WinGetPos, WinX, WinY, WinW, WinH, A

        if (!WindowAgainstLeftSide(MonitorWorkAreaLeft, WinX, WinW) and WindowAgainstTopSide(MonitorWorkAreaTop, WinY, WinH) and !WindowAgainstBottomSide(MonitorWorkAreaBottom, WinY, WinH) and WindowAgainstRightSide(MonitorWorkAreaRight, WinX, WinW)) {
            break
        }

        if (WindowAgainstLeftSide(MonitorWorkAreaLeft, WinX, WinW)) {
            SendInput #{Right}
            Sleep % SLEEP_BETWEEN_COMMANDS
        } else if (!WindowAgainstRightSide(MonitorWorkAreaRight, WinX, WinW)) {
            SendInput #{Left}
            Sleep % SLEEP_BETWEEN_COMMANDS
        } else if (WindowAgainstBottomSide(MonitorWorkAreaBottom, WinY, WinH)) {
            SendInput #{Up}
            Sleep % SLEEP_BETWEEN_COMMANDS
        } else if (!WindowAgainstTopSide(MonitorWorkAreaTop, WinY, WinH)) {
            SendInput #{Up}
            Sleep % SLEEP_BETWEEN_COMMANDS
        }
    }

return

; On left keypress send to zone 3
#!Down up::

    ; retrieve screen workarea, subtracted task- and toolbars
    SysGet, MonitorWorkArea, MonitorWorkArea

    ; Set loop to higher max due to different system speeds
    Loop % NUMBER_OF_TRIES {
        ; Get position of active window
        WinGetPos, WinX, WinY, WinW, WinH, A

        if (!WindowAgainstLeftSide(MonitorWorkAreaLeft, WinX, WinW) and !WindowAgainstTopSide(MonitorWorkAreaTop, WinY, WinH) and WindowAgainstBottomSide(MonitorWorkAreaBottom, WinY, WinH) and WindowAgainstRightSide(MonitorWorkAreaRight, WinX, WinW)) {
            break
        }

        if (WindowAgainstLeftSide(MonitorWorkAreaLeft, WinX, WinW)) {
            SendInput #{Right}
            Sleep % SLEEP_BETWEEN_COMMANDS
        } else if (!WindowAgainstRightSide(MonitorWorkAreaRight, WinX, WinW)) {
            SendInput #{Left}
            Sleep % SLEEP_BETWEEN_COMMANDS
        } else if (WindowAgainstTopSide(MonitorWorkAreaTop, WinY, WinH)) {
            SendInput #{Down}
            Sleep % SLEEP_BETWEEN_COMMANDS
        } else if (!WindowAgainstBottomSide(MonitorWorkAreaBottom, WinY, WinH)) {
            SendInput #{Down}
            Sleep % SLEEP_BETWEEN_COMMANDS
        }
    }

return

#!Up up::

    WinMaximize, A

return

WindowAgainstLeftSide(monitorLeft, winX, winWidth) {
    if ((winX - WIDTH_MARGIN - monitorLeft) <= 0 and (winX + winWidth) >= monitorLeft and (winX) > (monitorLeft - WIDTH_MARGIN)) {
        return true
    }
return false
}

WindowAgainstTopSide(monitorUp, winY, winHeight) {
    if ((winY - HEIGHT_MARGIN - monitorUp) <= 0 and (winY + winHeight) >= monitorUp  and (winY) > (monitorBottom - HEIGHT_MARGIN)){
        return true
    }
return false
}

WindowAgainstBottomSide(monitorBottom, winY, winHeight) {
    if ((winY + HEIGHT_MARGIN) < monitorBottom and (winY + winHeight + HEIGHT_MARGIN) > monitorBottom and (winY + winHeight) < (monitorBottom + HEIGHT_MARGIN)) {
        return true
    }
return false
}

WindowAgainstRightSide(monitorRight, winX, winWidth) {
    if (winX < monitorRight and (winX + winWidth + WIDTH_MARGIN) >= monitorRight and (winX + winWidth) < (monitorRight + WIDTH_MARGIN)) {
        return true
    }
return false
}