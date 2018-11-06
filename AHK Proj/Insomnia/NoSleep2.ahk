#Persistent
#installkeybdhook
#installmousehook
#SingleInstance Force
InactiveSS := 0

Menu, Tray, NoStandard
Menu, Tray, Add, Stealth Mode, Stealth
Menu, Tray, Add, Test, MyTest
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

!^+s::
Menu, Tray, Icon
return

Stealth:
Menu, Tray, NoIcon
Gosub, ActiveNoSleep
return

MyTest:
msgbox, Press OK to run a system check.`nPlease don't touch the mouse or keyboard until the results appear.
sleep 5000
Check1 := A_TimeIdle
Result1 := "Not Good"
if Check1 > 4000
	Result1 := "Good"

DllCall("SetThreadExecutionState", UInt,0x00000002)	

Check2 := A_TimeIdle
Result2 := "Not Good"
if Check2 < 1000
	Result2 := "Good"
msgbox, Test #1`n        Time: %Check1%ms`n        Result: %Result1%`n`nTest #2`n        Time: %Check2%ms`n        Result: %Result2%

return

ActiveNoSleep:
;DllCall("SetThreadExecutionState", UInt,0x80000000)
return

AppInfo:
Msgbox, 32, About: Insomniac 2.0, When was the last time your computer fell asleep?`nYou're welcome.
Return

Exit:
ExitApp
