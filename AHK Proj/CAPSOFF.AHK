;Menu, Tray, NoIcon

Menu,Tray,NoStandard
Menu,Tray,DeleteAll
Menu,Tray,Add,&Reload,RELOAD
Menu,Tray,Add,E&xit,EXIT
Menu,Tray,Tip, Caps UNlock
Menu,Tray,Default,%applicationname%

SETCAPSLOCKSTATE, ALWAYSOFF
Return

EXIT:
ExitApp

RELOAD:
Reload

CapsLock::
text1 = Use of Caps Lock is inappropriate, it has been disabled.
text2 = YOU MAY NOT TYPE IN ALL CAPS!!
text3 = CAPS LOCK IS NOT CRUISE CONTROL FOR COOL
MsgBox, 0x30, CAPS LOCK, %text1% ;`n%text2%`n%text3%
Return
