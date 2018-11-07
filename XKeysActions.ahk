;X-Keys Mappings for added flexibility over MacroWorks
;TNF 2.5.2016

;  F15 | F20 |#F15 |#F20
; ----------------------
;  F16 | F21 |#F16 |#F21
; ----------------------
;  F17 | F22 |#F17 |#F22
; ----------------------
;  F18 | F23 |#F18 |#F23
; ----------------------
;  F19 | F24 |#F19 |#F24

;Virtual Keys (code reference: MacroWorks uses Dec, AHK uses Hex)
;	Key		Hex	Dec
;	F15		7E	126
;	F16		7F	127
;	F17		80	128
;	F18		81	129
;	F19		82	130
;	F20		83	131
;	F21		84	132
;	F22		85	133
;	F23		86	134
;	F24		87	135
;	LWin	5B	91
;	RWin	5C	92

;AHK Modifier Reference
;	# - Win
;	^ - Control
;	! - Alt
;	+ - Shift

#installkeybdhook
#SingleInstance Force

;Windows key modifier is used to distinguish Column 1 from Column 2, any other combination of modifiers (CTRL/ALT/SHIFT) may be used.
;Add modified macros below base macro

;Macros:

;Column 1
;Button 01
;Firefox: Restore/Minimize or Run
VK7E::
IfWinExist, ahk_class MozillaWindowClass
	IfWinActive
		WinMinimize
	else
		WinActivate
else
	Run, C:\Program Files (x86)\Mozilla Firefox\firefox.exe, C:\Program Files (x86)\Mozilla Firefox\
Return

;Button 02
VK7F::
Run, C:\Project\AHK\ares.rdp
WinWaitActive, ares
sleep 300
Send {LWin}u:\visuallogin llc{Enter}
Return

;Button 03
VK80::msgbox, "XKeys Button 03"
;Button 04
VK81::msgbox, "XKeys Button 04"
;Button 05
VK82::send zqx109-7{enter}
;Column 2
;Button 06
;EMU48: Restore/Minimize or Run
VK83::
IfWinExist, ahk_class CEmu48
	IfWinActive
		WinMinimize
	else
		WinActivate
else
	Run, C:\Program Files (x86)\HP-Emulators\Emu48\EMU48.exe, C:\Program Files (x86)\HP-Emulators\Emu48
Return
;Button 07
VK84::msgbox, "XKeys Button 07"
;Button 08
VK85::msgbox, "XKeys Button 08"
;Button 09
VK86::msgbox, "XKeys Button 09"
;Button 10
VK87::msgbox, "XKeys Button 10"

;Column 3
;Button 11
;Notepad++: Restore/Minimize or Run
#VK7E::
IfWinExist, ahk_class Notepad++
	IfWinActive
		WinMinimize
	else
		WinActivate
else
	Run, C:\Program Files (x86)\Notepad++\notepad++.exe, C:\Program Files (x86)\Notepad++\
Return
;Button 12
#VK7F::msgbox, "XKeys Button 12"
;Button 13
#VK80::msgbox, "XKeys Button 13"
;Button 14
#VK81::msgbox, "XKeys Button 14"
;Button 15
#VK82::msgbox, "XKeys Button 15"

;Column 4
;Button 16
#VK83::msgbox, "XKeys Button 16"
;CTRL+ALT+B16: Monitors off +Lock Workstation
^!#VK83::Run, C:\Windows\System32\schtasks.exe /RUN /TN "UAC Whitelist\XKeys Off WhtLst", C:\Windows\System32
;Button 17 - Pandora Stuff
#VK84:: ;Normal Press: If running - Pause/Play, if not - Open Window & Play
IfWinNotExist, ahk_class Chrome_WidgetWin_1
{
	Run, "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" --app=https://www.pandora.com --window-size="170,180"
	WinWaitActive, ahk_class Chrome_WidgetWin_1, ,5
	Winset, AlwaysOnTop, On
}
else
{
	VK84StWin := WinExist("A")
	WinActivate, ahk_class Chrome_WidgetWin_1
	Send {Space}
	WinActivate, ahk_id %VK84StWin%
}
Return
^#VK84:: ;Ctrl Press: Return to Max Volume
	VK84StWin := WinExist("A")
	WinActivate, ahk_class Chrome_WidgetWin_1
	Send ^r
	WinActivate, ahk_id %VK84StWin%
Return

;Pandora Shortcuts List:
; {space} - Play/Pause
; {right} - Skip
; {+} - Thumbs Up
; 'Minus' - Thumbs Down
; {up} - Raise Volume
; {down} - Lower Volume
; +{up} - Max Volume
; +{down} - Mute (toggle)

;Button 18
#VK85::msgbox, "XKeys Button 18"
Return
;Button 19
#VK86::msgbox, "XKeys Button 19"
;Button 20
#VK87::
	loop,50 {
	send {Delete}
	send {Down}
	}
Return

#^5::
/*
  Example: Temporarily remove the active window from the taskbar by using COM.

  Methods in ITaskbarList's VTable:
    IUnknown:
      0 QueryInterface  -- use ComObjQuery instead
      1 AddRef          -- use ObjAddRef instead
      2 Release         -- use ObjRelease instead
    ITaskbarList:
      3 HrInit
      4 AddTab
      5 DeleteTab
      6 ActivateTab
      7 SetActiveAlt
	  
Copied shamelessly from here:  https://autohotkey.com/board/topic/83159-solved-removing-windows-taskbar-icons/
*/
IID_ITaskbarList  := "{56FDF342-FD6D-11d0-958A-006097C9A090}"
CLSID_TaskbarList := "{56FDF344-FD6D-11d0-958A-006097C9A090}"

; Create the TaskbarList object and store its address in tbl.
tbl := ComObjCreate(CLSID_TaskbarList, IID_ITaskbarList)

activeHwnd := WinExist("A")

DllCall(vtable(tbl,3), "ptr", tbl)                     ; tbl.HrInit()
DllCall(vtable(tbl,5), "ptr", tbl, "ptr", activeHwnd)  ; tbl.DeleteTab(activeHwnd)
;Sleep 3000
;DllCall(vtable(tbl,4), "ptr", tbl, "ptr", activeHwnd)  ; tbl.AddTab(activeHwnd)

; Non-dispatch objects must always be manually freed.
ObjRelease(tbl)

vtable(ptr, n) {
    ; NumGet(ptr+0) returns the address of the object's virtual function
    ; table (vtable for short). The remainder of the expression retrieves
    ; the address of the nth function's address from the vtable.
    return NumGet(NumGet(ptr+0), n*A_PtrSize)
}
Return
