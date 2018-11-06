
IfWinExist, Made2Manage
    Winactivate
else
	return
	
send !{Ins}

WinWaitActive, Copying Item Master, Create New Part Number or Create New Rev,5
; Note, message in Copy Item Master dialog has a typo: "Revsion"
if ErrorLevel = 1
	{
	msgbox Error finding Copy Item Master window. Program will exit.
	return
	}

send {Enter}

WinWaitActive, Made2Manage,,5
if ErrorLevel = 1
	{
	msgbox Error finding M2M window. Program will exit.
	return
	}
	
controlgetpos, Exx, Wyy, Wid, Hig, WindowsForms10.EDIT.app.0.2bf8098_r13_ad16
mousemove, Exx + Wid/2, Wyy + Hig/2, 0
mouseclick
send ^a
;msgbox ok, do it again
send {F7}

WinWaitClose, Made2Manage, [INV]*, 5
if ErrorLevel = 1
	{
	msgbox Nope
	return
	}
sleep 50
send !{Ins}

return