
IfWinExist, Made2Manage
    Winactivate
else
	return

send {F2}

;Location
controlgetpos, Exx, Wyy, Wid, Hig, WindowsForms10.EDIT.app.0.2bf8098_r13_ad135
mousemove, Exx + Wid/2, Wyy + Hig/2, 0
mouseclick,,,,2
WhatNeedFoc = WindowsForms10.EDIT.app.0.2bf8098_r13_ad135
FocCount = 1
loop, 150
	{
	controlgetfocus, WhatHasFoc
	If WhatHasFoc = %WhatNeedFoc%
		Break
	sleep 10
	++FocCount
	}
send 01{Tab}
msgbox %FocCount%

return