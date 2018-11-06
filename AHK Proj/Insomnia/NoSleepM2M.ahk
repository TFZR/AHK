#Persistent
#installkeybdhook
#installmousehook
#SingleInstance Force

Menu, Tray, NoStandard
Menu, Tray, Add, Exit
Menu, Tray, Tip, GoGoM2M... No idea why.

SetTimer, CheckIdle, 240000
return

CheckIdle:
	IfWinExist, Paladin
	{
		Winactivate
		Send !f
		Send {Esc}{Esc}
	}
	Else
	{
		SetTimer, CheckIdle, Off
		msgbox, Paladin Desktop closed at %A_Hour% : %A_Min%
	}
	MouseMove, 1, 1,,R
	MouseMove, -1, -1,,R
return

Exit:
ExitApp