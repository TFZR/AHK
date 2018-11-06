#Persistent
#installkeybdhook
#installmousehook
#SingleInstance Force
InactiveSS := 0

Menu, Tray, NoStandard
Menu, Tray, Add, Block Screen Saver, ToggleSS
Menu, Tray, Add, Stealth Mode, Stealth
Menu, Tray, Add, System Check, SysCheck
Menu, Tray, Add, About, AppInfo
Menu, Tray, Add, Exit
Menu, Tray, Tip, Insomniac
StringLeft, ScriptType, A_ScriptName, 3
IfEqual, ScriptType, exe
{
	Menu, Tray, Icon, %A_ScriptName%,1,1
}

Gosub, ActiveNoSleep
return

!^+t::
SoundBeep, 100, 1000
SoundBeep, 200, 1000
SoundBeep, 300, 1000
return

Click Right
;Drive, Eject
;Drive, Eject,,1
return

!^+s::
Menu, Tray, Icon
return

Stealth:
Menu, Tray, NoIcon
Gosub, ActiveNoSleep
return

ToggleSS:
if InactiveSS
{
	GoSub, InactiveNoSleep
}
else
{
	GoSub, ActiveNoSleep
}
return

ActiveNoSleep:
SetTimer, CheckIdle, 60000
InactiveSS := 1
Menu, Tray, Check, Block Screen Saver
return

InactiveNoSleep:
SetTimer, CheckIdle, Off
InactiveSS := 0
Menu, Tray, UnCheck, Block Screen Saver
return

CheckIdle:
TimeIdle := A_TimeIdle // 1000
if TimeIdle >= 150
{
	MouseMove, 1, 1,,R
	MouseMove, -1, -1,,R
}
return

SysCheck:
msgbox, Press OK to run a system check.`nPlease don't touch the mouse or keyboard until the results appear.
sleep 5000
Check1 := A_TimeIdle
Result1 := "Not Good"
if Check1 > 4000
	Result1 := "Good"
	
MouseMove, 1, 1,,R
MouseMove, -1, -1,,R
Check2 := A_TimeIdle
Result2 := "Not Good"
if Check1 < 1000
	Result2 := "Good"
msgbox, Test #1`n        Time: %Check1%ms`n        Result: %Result1%`n`nTest #2`n        Time: %Check2%ms`n        Result: %Result2%
return

AppInfo:
Msgbox, 32, About: Insomniac, When was the last time your computer fell asleep?`nYou're welcome.
Return

Exit:
ExitApp
