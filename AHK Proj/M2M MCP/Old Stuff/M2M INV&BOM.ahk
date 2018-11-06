IfWinExist, Made2Manage
    Winactivate
else
	return
setkeydelay, 1
;focus and send Memo
controlfocus, WindowsForms10.EDIT.app.0.2bf8098_r13_ad120
controlsend, WindowsForms10.EDIT.app.0.2bf8098_r13_ad120, testing 1-2-3
;focus and send Comment
controlfocus, WindowsForms10.EDIT.app.0.2bf8098_r13_ad121
controlsend, WindowsForms10.EDIT.app.0.2bf8098_r13_ad121, testing 4-5-6

;check values
controlgettext, mytext1, WindowsForms10.EDIT.app.0.2bf8098_r13_ad120
controlgettext, mytext2, WindowsForms10.EDIT.app.0.2bf8098_r13_ad121

;report
msgbox, %mytext1% & %mytext2%

