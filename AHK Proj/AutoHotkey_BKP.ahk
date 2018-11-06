
menu, Tray, icon, %A_ScriptDir%\Gear.ico, 1, 1
menu, Tray, Tip, AHK Essentials

;One Liners--------------------------------------------------------------------------------
#r::Reload			;Reloads this script
:?*:...::{ASC 0133}	;replaces an ellipsis... with an ellipsis… (saves 2chr in a tweet)
^4::Send {ASC 0162} ;Dollars & Cents - Shift-4::$ & Ctrl-4::¢
::mmm::{ASC 269}{ASC 270}	;musical notes (unicode, only works some places)
::deg::{BS}{ASC 0176}	;° in place of {space}deg (type 123{space}deg to get 123°)
:C:crt::{ASC 0169}{ASC 0174}{ASC 0153} ;crt::©®™ Copyright, Registerd, Trademark - lower case CRT. 
;------------------------------------------------------------------------------------------

^!F9::
click right
send v
sleep 200
send {Enter}
sleep 200
send ^w
return

;PDM New Part Number, needs lots of work.
!^+F12::
;mapped to scroll left
;adjust the tabbed lines to get the correct menu item location
MouseGetPos, xpos, ypos
mph := 2
click ;to reset from previous new part
sleep 200
click right
mousemove, 20, 125, mph, R
click
mousemove, 84, 0, mph, R
mousegetpos, xst, yst
PixelSearch, xtop, ytop, xst, yst, xst, 0, 0xAAA6A7
;msgbox, %xtop%, %ytop%
mousemove, xtop, ytop, mph
mousemove, 30, 57, mph, R
	mousemove, 0, 70, mph, R ;adjust for guarding (06-xx-xxxx)
click
mousemove, 250, 0, mph, R
mousemove, 0, 78, mph, R
	mousemove, 0, 15, mph, R ;adjust for plates (06-05-xxxx)
	;click ;create new p/n wherever the mouse has landed
	;mousemove, xpos, ypos, mph ;return to that which you've come
return

;; Alt + LButton to move windows around without grabing the title bar
;; This script modified from the original: http://www.autohotkey.com/docs/scripts/EasyWindowDrag.htm
;; by The How-To Geek
;; http://www.howtogeek.com 

;;**This hotkey has been disabled due to a conflict with ALT-Select in Notepad++ (selectes a rectangle of text)

;Alt & LButton::
;CoordMode, Mouse  ; Switch to screen/absolute coordinates.
;MouseGetPos, EWD_MouseStartX, EWD_MouseStartY, EWD_MouseWin
;WinGetPos, EWD_OriginalPosX, EWD_OriginalPosY,,, ahk_id %EWD_MouseWin%
;WinGet, EWD_WinState, MinMax, ahk_id %EWD_MouseWin% 
;if EWD_WinState = 0  ; Only if the window isn't maximized 
;    SetTimer, EWD_WatchMouse, 10 ; Track the mouse as the user drags it.
;return
;
;EWD_WatchMouse:
;GetKeyState, EWD_LButtonState, LButton, P
;if EWD_LButtonState = U  ; Button has been released, so drag is complete.
;{
;    SetTimer, EWD_WatchMouse, off
;    return
;}
;GetKeyState, EWD_EscapeState, Escape, P
;if EWD_EscapeState = D  ; Escape has been pressed, so drag is cancelled.
;{
;    SetTimer, EWD_WatchMouse, off
;    WinMove, ahk_id %EWD_MouseWin%,, %EWD_OriginalPosX%, %EWD_OriginalPosY%
;    return
;}
;; Otherwise, reposition the window to match the change in mouse coordinates
;; caused by the user having dragged the mouse:
;CoordMode, Mouse
;MouseGetPos, EWD_MouseX, EWD_MouseY
;WinGetPos, EWD_WinX, EWD_WinY,,, ahk_id %EWD_MouseWin%
;SetWinDelay, -1   ; Makes the below move faster/smoother.
;WinMove, ahk_id %EWD_MouseWin%,, EWD_WinX + EWD_MouseX - EWD_MouseStartX, EWD_WinY + EWD_MouseY - EWD_MouseStartY
;EWD_MouseStartX := EWD_MouseX  ; Update for the next timer-call to this subroutine.
;EWD_MouseStartY := EWD_MouseY
;return

