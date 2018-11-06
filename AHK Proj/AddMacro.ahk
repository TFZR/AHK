;Housekeeping
detecthiddentext, off
coordmode, mouse, relative
n := 1

;Activate SW, open "Customize" dialog and click on "Commands" tab
ifwinexist, SolidWorks, swMenu ,Enterprise
	winactivate
else
{
	MsgBox Please open SolidWorks and try again.
	return
}
Send, !tz
winwait, Customize, , 5
if ErrorLevel
{
    MsgBox, WinWait timed out.
    return
}
else
    Winactivate
	
controlfocus, SysTabControl321, A
click 90, 50

;Set focus to "Categories", loop through selections to find "Macro"
controlfocus, ListBox1, A
loop
{
	control, choose, %n% , ListBox1, A
	controlget, mytext, choice, , ListBox1, A
	if (mytext = "Macro")
	{
		break
	}
	n+=1
}
until n > 40

;Move to "New Macro Button", click and drag to top of window
mousemove, 510, 115
click down
coordmode, mouse, screen
mousemove, -700, 3, 10
	;This needs to be more robust, activate SW window and drop on title bar
	;maximize window if needed, make note and un-max later
	
click up

;Notes going forward:
;Title: Customize Macro Button
;controlclick, Button2, Customize Macro Button
;	Choose Image Button
;	Title: Icon Path
;	Edit1: "File Name"
;Edit1: Tooltip
;Edit2: Prompt
;Edit3: Macro
;Edit4: Method
;Edit5: Shortcut
;Button5: OK