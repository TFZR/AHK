;# - Win
;^ - Control
;! - Alt
;+ - Shift
#installkeybdhook
#SingleInstance Force


GUI +lastfound
Hwnd := WinExist()
DllCall( "RegisterShellHookWindow", UInt,Hwnd )
MsgNum := DllCall( "RegisterWindowMessage", Str,"SHELLHOOK" )
OnMessage( MsgNum, "ShellMessage" )
Return

/*
AutoMute( wParam,lParam )
	{
	detecthiddentext, on
	SetTitleMatchMode, Slow
	IfWinNotExist,, www.slacker.com
		return
	WinGetClass, SlackerClass,, www.slacker.com
	wingetclass, NewClass, ahk_id %lParam%P
	wingettitle, msgtxt, ahk_class %SlackerClass% 
	ifequal NewClass, %SlackerClass%
		{
		if wParam = 6
			{
			;StringRight, msgtxt, msgtxt, 4
			IfInString, msgtxt, from
				VA_SetMasterMute(false)
			else
				VA_SetMasterMute(true)
			
			;ifequal msgtxt, null
			;	VA_SetMasterMute(true)
			;else
			;	VA_SetMasterMute(false)
			}
		}
	}
*/

ShellMessage(wParam,lParam)
	{
	 SetTitleMatchMode, Slow
	 wingetclass, MyNewWin, ahk_id %lParam%
	 ifequal MyNewWin, Qt5QWindowIcon
		{
		 winwait, Information, , 1
		 if ErrorLevel
			 return
		 else
			controlsend, , y
		}
	}