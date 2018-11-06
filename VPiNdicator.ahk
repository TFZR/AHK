#SingleInstance Force
;msgbox, %A_IPAddress1%`n%A_IPAddress2%`n%A_IPAddress3%`n%A_IPAddress4%

CustomColor = EEAA99  ; Can be any RGB color (it will be made transparent below).
Gui +E0x20 +LastFound +AlwaysOnTop -Caption +ToolWindow  ; +ToolWindow avoids a taskbar button and an alt-tab menu item.
Gui, Color, %CustomColor%
Gui, Font, s32 cLime w1000 ; Set a large font size (32-point).
Gui, Add, Text, vMyText, VPN:OFF  ; VPN:OFF serve to auto-size the window.
; Make all pixels of this color transparent and make the text itself translucent (150):
WinSet, TransColor, %CustomColor% 150
SetTimer, UpdateOSD, 5000
Gosub, UpdateOSD  ; Make the first update immediate rather than waiting for the timer.
Xposoff := A_ScreenWidth-250
Gui, Show, x200 y-1050 NoActivate  ; NoActivate avoids deactivating the currently active window.
return

UpdateOSD:
if A_IPAddress3 = 0.0.0.0
	{
	GuiControl, +cGreen, MyText
	GuiControl,, MyText, VPN:OFF
	}
else
	{
	GuiControl, +cRed, MyText
	GuiControl,, MyText, VPN:ON
	}
return