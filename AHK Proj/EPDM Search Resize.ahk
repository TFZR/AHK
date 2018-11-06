;# - Win
;^ - Control
;! - Alt
;+ - Shift
;#installkeybdhook
#SingleInstance Force

Run, "C:\Program Files\SolidWorks Enterprise PDM\Search.exe" "/V:Jewell_Engineering" "/S:Part Search"
coordmode, mouse, screen
MouseGetPos, PosX, PosY
winwaitactive, SolidWorks Enterprise PDM Search, , 5
coordmode, mouse, relative
mouseclickdrag, Left, 125, 284, 125, 700
coordmode, mouse, screen
mousemove, PosX, PosY

exitapp
