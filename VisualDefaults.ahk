
WinActivate, Part Maintenance
WinGetTitle, VisDBase, A
StringRight, VisDBase, VisDBase, 3



ifequal, VisDBase, LTD
{
;msgbox, %VisDBase%
WarehsID := "LTD"
PriLocID := "FG"
AutLocID := "FG"
InsLocID := "INSPECT"
}
else
{
WarehsID := "Portland"
PriLocID := "Main Stock"
AutLocID := "WIP"
InsLocID := "inc insp"
}
ControlSend, Edit57, ^a%WarehsID%{tab}, Part Maintenance - Infor
WinWaitActive, ahk_class #32770, , .2
Send {enter}
WinWaitClose, ahk_class #32770
ControlSend, Edit58, ^a%PriLocID%{tab}, Part Maintenance - Infor
WinWaitActive, ahk_class #32770, , .2
Send {enter}
WinWaitClose, ahk_class #32770
ControlSend, Edit59, ^a%WarehsID%{tab}, Part Maintenance - Infor
WinWaitActive, ahk_class #32770, , .2
Send {enter}
WinWaitClose, ahk_class #32770
ControlSend, Edit60, ^a%AutLocID%{tab}, Part Maintenance - Infor
WinWaitActive, ahk_class #32770, , .2
Send {enter}
WinWaitClose, ahk_class #32770
ControlSend, Edit61, ^a%WarehsID%{tab}, Part Maintenance - Infor
WinWaitActive, ahk_class #32770, , .2
Send {enter}
WinWaitClose, ahk_class #32770
ControlSend, Edit62, ^a%InsLocID%{tab}, Part Maintenance - Infor
WinWaitActive, ahk_class #32770, , .2
Send {enter}
sleep 300
WinWaitActive, ahk_class #32770, , .2
Send {enter}
WinWaitActive, Part Maintenance - Infor
controlsend, Auto Issue, {NumpadAdd}, Part Maintenance - Infor
ControlGetText, PartNum, Edit1, Part Maintenance - Infor
ControlGetText, DrwNum, Edit110, Part Maintenance - Infor
if DrwNum
	Exit
else
	ControlSetText, Edit110, %PartNum%, Part Maintenance - Infor
Exit