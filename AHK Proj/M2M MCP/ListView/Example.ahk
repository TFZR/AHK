; Allow the user to maximize or drag-resize the window:
Gui +Resize
Gui +LastFound
hwnd := WinExist()
; Create some buttons and text:
Gui, Add, Button, Default gButtonNav2Central, Some button
Gui, Add, Button, xs600 y120 gButtonHelp, Help Me!
Gui, Add, Text, xs ys30 w420 h100 , Instructions placed here              ;Gui, Add, Text, x22 y12 w420 h100 , Instructions placed here


; Create the ListView and its columns:
Gui, Add, ListView, Grid  LV0x40 -Multi altsubmit xm y120 r10 w500 vMyListView gMyListView, Name|Date modified|Size

GuiControl, Disable, MyListView
LV_Add("Icon" . 0, "Type some informative text here", "")            ; Listview is disabled until a folder is selected
LV_ModifyCol()

Gui, Show, W700

return

ButtonHelp:
msgbox, Open the help pdf!
Return

ButtonNav2Central:
; place code to execute here   
return

MyListView:
; place code to execute here
return

GuiSize:  ; Resize and move the controls
WinGetPos,x,y,w,h
If w < 300
   w = 300
If h <300
   h = 300
WinMove,ahk_id %hwnd%,,% x,% y,% w,% h
Anchor("MyListView", "wh")
Anchor("Button2","x")
Anchor("Static1","w")
return

#include anchor64.ahk


GuiClose:  ; When the window is closed, exit the script automatically:
ExitApp

