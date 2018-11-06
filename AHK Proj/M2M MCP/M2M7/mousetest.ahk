IfWinExist, Made2Manage
    Winactivate
else
	return

send {F2}
;Product Class
controlgetpos, Exx, Wyy, Wid, Hig, WindowsForms10.EDIT.app.0.2bf8098_r13_ad18
mousemove, Exx + Wid/2, Wyy + Hig/2, 0
mouseclick,,,,1
send fp
;Drawing Number
controlgetpos, Exx, Wyy, Wid, Hig, WindowsForms10.EDIT.app.0.2bf8098_r13_ad115
mousemove, Exx + Wid/2, Wyy + Hig/2, 0
mouseclick,,,,1
send ^a-
;Revision Date
controlgetpos, Exx, Wyy, Wid, Hig, WindowsForms10.EDIT.app.0.2bf8098_r13_ad117
mousemove, Exx + Wid/2, Wyy + Hig/2, 0
mouseclick,,,,2
;ABC Code
controlgetpos, Exx, Wyy, Wid, Hig, WindowsForms10.EDIT.app.0.2bf8098_r13_ad122
mousemove, Exx + Wid/2, Wyy + Hig/2, 0
mouseclick,,,,1
send c
;Location
controlgetpos, Exx, Wyy, Wid, Hig, WindowsForms10.EDIT.app.0.2bf8098_r13_ad135
mousemove, Exx + Wid/2, Wyy + Hig/2, 0
mouseclick,,,,1
send 01
;send !{Ins}
;send {Enter}
;Part Number
controlgetpos, Exx, Wyy, Wid, Hig, WindowsForms10.EDIT.app.0.2bf8098_r13_ad12
mousemove, Exx + Wid/2, Wyy + Hig/2, 0
mouseclick,,,,1
send ^a
send New P/N
;Description
controlgetpos, Exx, Wyy, Wid, Hig, WindowsForms10.EDIT.app.0.2bf8098_r13_ad16
mousemove, Exx + Wid/2, Wyy + Hig/2, 0
mouseclick,,,,1
send ^a
send New Description
;Source
controlgetpos, Exx, Wyy, Wid, Hig, WindowsForms10.EDIT.app.0.2bf8098_r13_ad17
mousemove, Exx + Wid/2, Wyy + Hig/2, 0
mouseclick,,,,1
send ^a
send p
;Group Code + U/M for Vendor Cost
controlgetpos, Exx, Wyy, Wid, Hig, WindowsForms10.EDIT.app.0.2bf8098_r13_ad19
mousemove, Exx + Wid/2, Wyy + Hig/2, 0
mouseclick,,,,1
send ^a
send plate
send {Tab}e{Tab 2}