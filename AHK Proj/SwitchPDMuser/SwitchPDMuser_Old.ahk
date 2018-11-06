;housekeeping
#SingleInstance force
blockinput, on
CoordMode, mouse, screen
#notrayicon
CoordMode, pixel, screen

;Get Starting Position
mousegetpos, xst, yst
mph:=4

;Find PDM Icon
ImageSearch, FoundX, FoundY, 1600, 1000, A_ScreenWidth, A_ScreenHeight, *TransFuchsia PDM.png
if ErrorLevel = 2
	{
	blockinput, off
    MsgBox An unexpected error occurred.
	exit
	}
else if ErrorLevel = 1
	{
	blockinput, off
    MsgBox Could not find PDM in the system tray.
	exit
	}
else
	{
	foundx += 8
	xpos := foundx
	foundy += 8
	ypos := foundy
	}
;/Find PDM Icon

	;Old Icon Finder
	;	;Go to Tray (bottom right corner)
	;	mousemove, 1950, 1100, mph
	;	;click activates start menu
	;	click
	;	;go to first icon
	;	mousemove, -72, -12, mph, R
	;	mousegetpos, xpos, ypos
	;	xend = xpos - 200
	;	;look for PDM Icon Color
	;	pixelsearch locX, locY, xpos, ypos, xend, ypos, 0x997140
	;	if errorlevel <> 0
	;	{	
	;		blockinput, off
	;		MsgBox Could not find PDM Icon
	;		return
	;	}
	;	xpos := locX
	;	;mousemove, locX, locY, mph
	;/Old Icon Finder

;move to PDM Icon and click, 3 times to make sure the context menu came up
mousemove, xpos, ypos, mph
click
click
click
;move up to "Log On/Off" line and click
mousemove, -53, -105, mph, R
click
;move over to the left and select option

;Check to see if it's the correct side, if so click, if not move back/click/check other side, if still no then sleep 500 and repeat (limited # of times)

mousemove, -110, 0, mph, R
mousegetpos, Pixx, Pixy
PixelGetColor, Color, %Pixx%, %Pixy%
ifequal, Color, 0xFF9933
	click
else
	{
	mousemove, 110, 0, mph, R
	click
	mousemove, 150, 0, mph, R
	click
	}

;now move back to the icon and clickety click click
mousemove, xpos, ypos, 1
click
click
click
;wait for it
sleep, 1000
;ok, probably came up now… move up to the "Log On/Off" line
mousemove, -50, -105, mph, R
click

;same loopy check as above to make sure you're over the option

mousemove, -110, 0, mph, R
mousegetpos, Pixx, Pixy
PixelGetColor, Color, %Pixx%, %Pixy%
ifequal, Color, 0xFF9933
	click
else
	{
	mousemove, 110, 0, mph, R
	click
	mousemove, 150, 0, mph, R
	click
	}
	
sleep, 500
WinGetText, mytext, A
user = tfrazier
pass = pw
if instr(mytext,"tfrazier")
{
	user = admin
	pass = pdmwe
}
controlsettext, Edit1, %user%, A
controlsettext, Edit2, %pass%, A
controlclick, Button1, A
mousemove, xst, yst, 1
blockinput, off
return