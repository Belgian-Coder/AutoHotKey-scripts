#SingleInstance force
#Space::

DetectHiddenWindows, On
DetectHiddenText, On

global VideoWidth
global VideoHeight
global AspectRatio := A_ScreenWidth / A_ScreenHeight ; Calculate the screens aspect ratio

global YouTubeDefaultAspectRatio := 16 / 9
global LetterboxScreenUpperLimit := 1.4 ; Older screens with resolutions like 800x600
global WideScreenUpperLimit := 2.0 ; Wider screens with 16:9 and 16:10 ratios
global UltraWideScreenUpperLimit := 3.0 ; Even wider screens value will not be used, for double widescreen aspectratio add another statement for values above 3.0

global WindowBorderHeight
global WindowBorderWidth
global WindowTitleBarHeight
global WindowResizeMargin
global ScreenMarginBottom
global ScreenDPI := A_ScreenDPI
global DefaultScreenDPI := 96.0
global CalculatedDPI := ScreenDPI / DefaultScreenDPI ; not implemented, everything worked as is
global Windows10DefaultMargin := 10
global CustomHeightCompensation := 11.75

SysGet, WindowBorderWidth, 5 ; SM_CXBORDER retrieve width of window border = 1
SysGet, WindowBorderHeight, 6 ; SM_CYBORDER retrieve height of window border = 1
SysGet, WindowTitleBarHeight, 55 ; SM_CYSIZE retrieve height of title bar
SysGet, WindowResizeMargin , 32 ; SM_CYSIZEFRAME retrieve height of window border = 8
SysGet, MonitorWorkArea, MonitorWorkArea ; retrieve screen workarea, subtracted task- and toolbars
ScreenMarginBottom := A_ScreenHeight - MonitorWorkAreaBottom


if (AspectRatio < LetterboxScreenUpperLimit)
{
	CustomHeightCompensation := 11.75
	VideoWidth := CalculateVideoWidth(0.30)
	VideoHeight := CalculateVideoHeight()
}
else if (AspectRatio < WideScreenUpperLimit)
{
	CustomHeightCompensation := 11.75
	VideoWidth := CalculateVideoWidth(0.4)
	VideoHeight := CalculateVideoHeight()
}
else if (AspectRatio < UltraWideScreenUpperLimit)
{
	CustomHeightCompensation := 11.75
	VideoWidth := CalculateVideoWidth(0.35)
	VideoHeight := CalculateVideoHeight()
}

XPosition := CalculateXPosition()
YPosition := CalculateYPosition()

Winset, AlwaysOnTop, Toggle, A
WinMove, A, , %XPosition%, %YPosition%, %VideoWidth%, %VideoHeight%


CalculateVideoWidth(sizeOnScreen)
{
	return ((A_ScreenWidth * sizeOnScreen) + (WindowResizeMargin * 2))
}

CalculateVideoHeight()
{
	return ((VideoWidth / YouTubeDefaultAspectRatio) + WindowTitleBarHeight + CustomHeightCompensation)
}

CalculateXPosition()
{
	return (A_ScreenWidth - VideoWidth + Windows10DefaultMargin)
}

CalculateYPosition()
{
	return (A_ScreenHeight - VideoHeight - ScreenMarginBottom + Windows10DefaultMargin)
}