Coordmode, mouse, screen
MouseGetPos, Xpos, Ypos

IfWinExist, Measure - 
	winactivate
else
	return

CoordMode, Mouse, Window

Click 52, 32


WinWaitActive, Measure Units/Precision,, 2

IfWinExist, Measure Units/Precision
    Winactivate
else
	return

; Button10 - Select ("Use Custom Settings")					*OK
Control, Check,, Button10

; ComboBox1 - "Inches" (Primary Length Unit)				*OK
ControlSend, ComboBox1, ai

; Button3 - Decimal (Use Decimal)							*OK
Control, Check,, Button3

; Edit1 - 8 (Primary Precision)								*OK
ControlSetText, Edit1, 8

; Button13 - Checked ("Use Dual Units")						*OK
Control, Check,, Button13

; ComboBox3 - "Millimeters" (Secondary Length Unit)			*OK
ControlSend, ComboBox3, amm

; Edit4 - 5 (Secondary Precision)							*OK
ControlSetText, Edit4, 5

;sleep 500
; Button1 - OK												*Sometimes
;ControlClick, Button1
Send {ENTER}

Coordmode, mouse, Screen
MouseMove, Xpos, Ypos, 0

return