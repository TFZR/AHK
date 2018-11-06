; Create the ListView with two columns, Name and Size:
Gui, Add, Tab2, w470 h405 vSelTab gTabs, BOM|INV
Gui, Tab, 1
Gui, Add, ListView, r20 w450 gBOMListView checked grid -ReadOnly vBOMlv, P/N|Item #|Qty
; Gather a list of file names from a folder and put them into the ListView:

filereadline, PNcount, c:\filelist.txt, 1
;requires filelist.txt to be populated, first line is the number of parts to be added
;next 4 lines are PN, Description, Group Code, and Source.  Those 4 parameters repeat.
i:=2

loop, %PNcount%
{
	filereadline, partnum, c:\filelist.txt, %i%
	i:= i+1
	filereadline, desc, c:\filelist.txt, %i%
	i := i + 1
	filereadline, gpcode, c:\filelist.txt, %i%
	i := i + 1
;	filereadline, source, c:\filelist.txt, %i%
;	i := i + 1

	LV_Add("",partnum, desc, gpcode) ;, source)
}

LV_ModifyCol(1,"AutoHdr")
LV_ModifyCol(2,"AutoHdr")
LV_ModifyCol(2,"Integer")
LV_ModifyCol(2,"Left")
LV_ModifyCol(3,"AutoHdr")
LV_ModifyCol(3,"Integer")
LV_ModifyCol(3,"Left")

Gui, Tab, 2

Gui, Add, ListView, r20 w450 gINVListView checked grid -ReadOnly vINVlv, P/N|Desc|Group|Source
Gui, Tab
; Display the window and return. The script will be notified whenever the user double clicks a row.
Gui, Add, Button, ys+20 w86 h25, Parent
Gui, Add, Button, w86 h25, Component
Gui, Add, Button, w86 h25, Statistics
Gui, Add, StatusBar,, Prepare to kick M2M's ass!!!

Menu, FileMenu, Add, &Open, MenuFileOpen
Menu, FileMenu, Add, E&xit, GuiClose
Menu, HelpMenu, Add, &About, MenuHandler
Menu, MyMenuBar, Add, &File, :FileMenu  ; Attach the two sub-menus that were created above.
Menu, MyMenuBar, Add, &Help, :HelpMenu
Gui, Menu, MyMenuBar

Gui, Show
return

Tabs:
Gui, Submit, NoHide
if SelTab = BOM
{
Gui, ListView, BOMlv
;msgbox BOMs
}
if SelTab = INV
{
Gui, ListView, INVlv
;msgbox INVs
}
return

MenuFileOpen:
Return

MenuHandler:
return

INVListView:
return

BOMListView:
if A_GuiEvent = DoubleClick
{
    LV_GetText(RowText, A_EventInfo)  ; Get the text from the row's first field.
	LV_GetText(partnum, A_EventInfo)
	LV_GetText(desc, A_EventInfo, 2)
	LV_GetText(gpcode, A_EventInfo, 3)
	LV_GetText(source, A_EventInfo, 4)
	;ToolTip You double-clicked row number %A_EventInfo%. Text: "%RowText%"
	msgbox, %partnum% - %desc% - %gpcode% - %source%
}
return

GuiClose:  ; Indicate that the script should exit automatically when the window is closed.
ExitApp

ButtonParent:
;activate Paladin Desktop
IfWinExist, Paladin
    Winactivate
	
CoordMode, mouse, screen
;Get Starting Position
mousegetpos, xst, yst	

CoordMode, mouse, relative
CoordMode, pixel, relative
SetTitleMatchMode 1


;Find PDM Icon
ImageSearch, FoundX, FoundY, 1, 1, A_ScreenWidth, A_ScreenHeight, *TransFuchsia PCratio.bmp
if ErrorLevel = 2
	{
	;blockinput, off
    MsgBox Could not conduct the search.
	exit
	}
else if ErrorLevel = 1
	{
    MsgBox Icon could not be found on the screen.
	exit
	}
else
	{
	foundx += 4
	foundy += 4
	mousemove foundx, foundy
	click
	}
CoordMode, mouse, screen
mousemove xst, yst
return

ButtonComponent:
;activate Paladin Desktop
IfWinExist, Paladin
    Winactivate

CoordMode, mouse, screen
;Get Starting Position
mousegetpos, xst, yst	
	
CoordMode, mouse, relative
CoordMode, pixel, relative
SetTitleMatchMode 1

;Find PDM Icon
ImageSearch, FoundX, FoundY, 1, 1, A_ScreenWidth, A_ScreenHeight, *TransFuchsia PCratio.bmp
if ErrorLevel = 2
	{
	;blockinput, off
    MsgBox Could not conduct the search.
	exit
	}
else if ErrorLevel = 1
	{
    MsgBox Icon could not be found on the screen.
	exit
	}
else
	{
	foundx += 4
	foundy += 16
	mousemove foundx, foundy
	click
	}
CoordMode, mouse, screen
mousemove xst, yst
return

ButtonStatistics:
LV_Modify(5, "Check")
refnum := LV_GetNext(1, "checked")
LV_GetText(mynum, refnum, 1)
msgbox %mynum%
Return























