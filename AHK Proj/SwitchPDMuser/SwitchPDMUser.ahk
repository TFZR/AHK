;housekeeping
FileCreateDir, %A_Temp%\PDMuser
FileInstall, PDM.png, %A_Temp%\PDMuser\PDM.png, 1
FileInstall, PDM_LO.png, %A_Temp%\PDMuser\PDM_LO.png, 1
FileInstall, PDM_LI.png, %A_Temp%\PDMuser\PDM_LI.png, 1
FileInstall, PDM_Vlt.png, %A_Temp%\PDMuser\PDM_Vlt.png, 1

blockinput sendandmouse
blockinput mousemove

#SingleInstance force
#notrayicon
CoordMode, mouse, screen
CoordMode, pixel, screen
SetTitleMatchMode 1

;Get Starting Position
mousegetpos, xst, yst

StartX := A_ScreenWidth - 600
StartY := A_ScreenHeight - 30

;Find PDM Icon
ImageSearch, FoundX, FoundY, StartX, StartY, A_ScreenWidth, A_ScreenHeight, *TransFuchsia %A_Temp%\PDMuser\PDM.png
if ErrorLevel = 2
	{
	blockinput default
	blockinput mousemoveoff
    MsgBox Could not conduct the search.
	exitapp
	}
else if ErrorLevel = 1
	{
    MsgBox Icon could not be found on the screen.
	exitapp
	}
else
	{
	foundx += 8
	foundy += 8
	}

sleep 75
	mousemove foundx, foundy
	click
StartY := A_ScreenHeight - 350
;Find Log Off Icon
cyclecount := 0
Loop{
ImageSearch, LogOffX, LogOFfY, StartX, StartY, A_ScreenWidth, A_ScreenHeight, *TransFuchsia %A_Temp%\PDMuser\PDM_LO.png
if ErrorLevel = 2
	{
	blockinput default
	blockinput mousemoveoff
    MsgBox Could not conduct the search.
	exitapp
	}
else if ErrorLevel = 1
	{
    sleep 25
	}
else
	{
	LogOffx += 8
	LogOffy += 8
	MouseMove LogOffx, LogOffy
	Click
	cyclecount := 100
	}
cyclecount := cyclecount + 1
} Until cyclecount > 99

;Find Vault Icon
cyclecount := 0
Loop{
ImageSearch, VaultX, VaultY, StartX, StartY, A_ScreenWidth, A_ScreenHeight, *TransFuchsia %A_Temp%\PDMuser\PDM_Vlt.png
if ErrorLevel = 2
	{
	blockinput default
	blockinput mousemoveoff
    MsgBox Could not conduct the search.
	exitapp
	}
else if ErrorLevel = 1
	{
    sleep 25
	}
else
	{
	Vaultx += 8
	Vaulty += 8
	MouseMove Vaultx, Vaulty
	Click
	cyclecount := 100
	}
cyclecount := cyclecount + 1
} Until cyclecount > 99

MouseMove FoundX, FoundY
Click


;Find Log Off Icon
cyclecount := 0
Loop{
ImageSearch, LogOffX, LogOFfY, StartX, StartY, A_ScreenWidth, A_ScreenHeight, *TransFuchsia %A_Temp%\PDMuser\PDM_LI.png
if ErrorLevel = 2
	{
	blockinput default
	blockinput mousemoveoff
    MsgBox Could not conduct the search.
	exitapp
	}
else if ErrorLevel = 1
	{
    sleep 25
	}
else
	{
	LogOffx += 8
	LogOffy += 8
	MouseMove LogOffx, LogOffy
	Click
	cyclecount := 100
	}
cyclecount := cyclecount + 1
} Until cyclecount > 99

;Find Vault Icon
cyclecount := 0
Loop{
ImageSearch, VaultX, VaultY, StartX, StartY, A_ScreenWidth, A_ScreenHeight, *TransFuchsia %A_Temp%\PDMuser\PDM_Vlt.png
if ErrorLevel = 2
	{
	blockinput default
	blockinput mousemoveoff
    MsgBox Could not conduct the search.
	exitapp
	}
else if ErrorLevel = 1
	{
    sleep 25
	}
else
	{
	Vaultx += 8
	Vaulty += 8
	MouseMove Vaultx, Vaulty
	Click
	cyclecount := 100
	}
cyclecount := cyclecount + 1
} Until cyclecount > 99


WinWaitActive, SolidWorks Enterprise PDM Login,,4
if ErrorLevel
{
	blockinput default
	blockinput mousemoveoff
    MsgBox, WinWait timed out.
    exitapp
}
else
{
WinGetText, mytext, A
user = tfrazier
pass = pw
if instr(mytext,"tfrazier")
{
	user = admin
	pass = pdmwe
}
controlsettext, Edit1, %user%, A
controlsettext, Edit2, %pass%, A
;2012 had button, ahk cannot see that control in 2014
;controlclick, Button1, A
send {enter}
mousemove, xst, yst, 1
}
FileRemoveDir, %A_Temp%\PDMuser, 1
	blockinput default
	blockinput mousemoveoff
exitapp
