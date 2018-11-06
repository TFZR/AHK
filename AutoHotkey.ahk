;# - Win
;^ - Control
;! - Alt
;+ - Shift
#installkeybdhook
#SingleInstance Force

menu, Tray, icon, %A_ScriptDir%\Gear.ico, 1, 1
menu, Tray, Tip, AHK Essentials

SetBatchLines, -1

#Include WinHookStuff.ahk


;One Liners--------------------------------------------------------------------------------
#r::Reload			;Reloads this script
:?*:...::{ASC 0133}	;replaces an ellipsis... with an ellipsis… (saves 2chr in a tweet)
^4::Send {ASC 0162} ;Dollars & Cents - Shift+4::$ & Ctrl+4::¢
::mmm::{ASC 269}{ASC 270}	;musical notes (unicode, only works some places)
::deg::{BS}{ASC 0176}	;° in place of {space}deg (type 123{space}deg to get 123°)
:C:crt::{ASC 0169}{ASC 0174}{ASC 0153} ;crt::©®™ Copyright, Registerd, Trademark - lower case CRT.
::+-::± ;replace +- with ± 
+NumpadSub:: send _ ;Numpad Subtract works like keyboard Subtract (Shift for underscore)
;Multimedia Keyboard Hotkeys:
Media_Stop:: TrayTip, Konami, Level Up!!!, 10, 1
Media_Play_Pause:: Run, C:\Project\Xkeys\GrooveShark_PP.ahk
Media_Next:: Run, C:\Project\Xkeys\GrooveShark_Next.ahk
Launch_Mail:: msgbox, "Mail" ;Outlook
Launch_App1:: msgbox, "App1" ;??
Launch_App2:: msgbox, "App2" ;Emu48
Launch_Media:: msgbox, "Media" ;Np++
;------------------------------------------------------------------------------------------
#PgUp::Send {Volume_Up 1}
#PgDn::Send {Volume_Down 1}

^#PgUp::Send {Volume_Up 5}
^#PgDn::Send {Volume_Down 5}

;^!w::
;Run, C:\Windows\System32\schtasks.exe /RUN /TN "UAC Whitelist\XKeys Off WhtLst", C:\Windows\System32
;return

^!x::
Run, C:\Windows\System32\schtasks.exe /RUN /TN "UAC Whitelist\XKeys On WhtLst", C:\Windows\System32
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

;MDT Copy W/Base Point and Paste as Block (Ctrl-Shift-C and Ctrl-Shift-V)
settitlematchmode 1
#ifwinactive, Mechanical Desktop
^+c::send _copybase{enter}
^+v::send _pasteblock{enter}
#ifwinactive

/* 
Slacker Radio Desktop Widget for Cheapskates

Open Slacker in Google Chrome>Tools>Create Application Shortcuts…
Pin it to the taskbar, View at 25% or so, size the window accordingly

A_AppData\Local\Google\Chrome\Application\chrome.exe  --app=http://www.slacker.com/
ClassNN: Chrome_RenderWidgetHostHWND1
ahk_class Chrome_WidgetWin_1 (sometimes the number changes, script compensates)

Set Hotkeys as desired (Complex Ctrl+Alt+Shift hotkeys designed for use with X-Keys)
*/

;(Needs hotkey)::Slacktions("d") ;Volume Down
;(Needs hotkey)::Slacktions("u") ;Volume Up
;(Needs hotkey)::Slacktions("m") ;Mute Volume

^!k::
	detecthiddentext, on
	SetTitleMatchMode, Slow
	IfWinNotExist,, www.slacker.com
		return
	
	WinGetClass, SlackerClass,, www.slacker.com
	WinGetTitle, SlackerTitle, ahk_class %SlackerClass%
	msgbox, %SlackerTitle%
return

~Up::
~Down::
~Left::
~Right::
~a::
~b::
  CheckKonami( SubStr(A_ThisHotkey,2,1) )
Return
;-----------------------------------
CheckKonami(Char) {
  static Sequence := "" , Konami := "UUDDLRLRBA"
  Sequence := SubStr(  Sequence Char  ,  (StrLen(Konami)-1)*(-1)  )
  If ( Sequence = Konami ) ; single '=' should be case insensitive
    GoSub, LevelUp ; you don't have to edit this function everytime
}
;-----------------------------------
LevelUp:
  ;MsgBox,, KONAMI!!!, Level Up!
	TrayTip, Konami, Level Up!!!, 10, 1
Return

Slacktions(Fcn)
	{
	detecthiddentext, on
	SetTitleMatchMode, Slow
	
	IfWinNotExist,, www.slacker.com
		return
	
	WinGetClass, SlackerClass,, www.slacker.com
	ControlSend, Chrome_RenderWidgetHostHWND1, %Fcn%, ahk_class %SlackerClass%
	}


#Include VA.ahk
#Include XKeysActions.ahk