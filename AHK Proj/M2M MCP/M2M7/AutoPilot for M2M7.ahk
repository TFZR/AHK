;-----------------------------------------------------------------------------------------------------------------------------
;------------------E2M by TNF-----Creating M2M Data from EPDM Data.  It's every bit as exciting as it sounds------------------
;-----------------------------------------------------------------------------------------------------------------------------

/*
Dependencies:
	Anchor64.ahk
	INV.bmp
	PCratio.bmp
	everythingelse.csv
	GroupCode.txt
	INVcodes.csv
*/

;-----------------------------------------------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------------------------------STARTUP SECTION--
;-----------------------------------------------------------------------------------------------------------------------------
Global Everything
Global GroupCodes
Global INVcodes
FileRead, Everything, everythingelse.csv					   ;Load the part number cross reference list as a Global Variable
FileRead, GroupCodes, GroupCode.txt
FileRead, INVcodes, INVcodes.csv
#SingleInstance off
#NoTrayIcon

;----------------------------------------------------------------------------------------------BEGIN GUI DEFINITION-----------
Gui, +Resize +MinSize400x204
;--------------------------------------------------------------------------------------------------TABS & LISTVIEWS-----------
Gui, Add, Tab2, w470 h405 vSelTab gTabs, BOM|INV|RAW

Gui, Tab, BOM					;Future controls belong to BOM tab
Gui, Add, ListView, r20 w450 gBOMListView checked grid vBOMlv, Item #|Qty|Part #|Description

Gui, Tab, INV					;Future controls belong to INV tab
Gui, Add, ListView, r20 w450 gINVListView checked grid vINVlv, Part #|Description|Prod. Class|Group|Source

Gui, Tab, RAW					;Future controls belong to RAW tab
Gui, Add, ListView, r20 w450 gRAWListView checked grid vRAWlv, Part #|Description|Stock Size|Qty.|UoM

Gui, Tab					;Future controls are not part of any tab control.
;-----------------------------------------------------------------------------------------------------------BUTTONS-----------
Gui, Add, Button, gActivator y0 x0 hidden, WTF? ;----------------------------Do not remove, do not show, used for updating LVs
Gui, Add, Button, gSourceData ys+20 w110 h25, Import Data
Gui, Add, Button, gClearData w110 h25, Clear List
Gui, Add, Button, gRemoveSelected w110 h25, Remove Selected
Gui, Add, Button, gAddData w110 h25, Add to M2M
Gui, Add, Text, xp y385, Emergency Exit: `nCTRL + ALT + X
Gui, Add, StatusBar,,Prepare to kick M2M's ass!!!

;--------------------------------------------------------------------------------------------------------MENU ITEMS-----------
Menu, FileMenu, Add, &Import Data, MenuFileOpen
Menu, FileMenu, Add, E&xit, GuiClose
Menu, HelpMenu, Add, &About, MenuHandler
Menu, MyMenuBar, Add, &File, :FileMenu  ; Attach the two sub-menus that were created above.
Menu, MyMenuBar, Add, &Help, :HelpMenu
Gui, Menu, MyMenuBar

Gui, Show,,E2M: EPDM to M2M`, the way data entry should be.
GoSub, Tabs
WinGet, E2Mid, id, E2M
SetTimer, WatchCursor, 100
return

;-----------------------------------------------------------------------------------------------------------------------------
;--------------------------------------------------------------------------------------------------------END STARTUP SECTION--
;-----------------------------------------------------------------------------------------------------------------------------

^!x:: Goto, GuiClose ; Emergency Exit Hotkey, Ctrl + Alt + x


;-----------------------------------------------------------------------------------------------------------------------------
;--------------------------------------------------------------------------------------------------------------TAB SWITCHING--
;-----------------------------------------------------------------------------------------------------------------------------

Tabs:
Gui, Submit, NoHide
If SelTab = BOM
	Gui, ListView, BOMlv
Else If SelTab = INV
	Gui, ListView, INVlv
Else If SelTab = RAW
	Gui, ListView, RAWlv
return

;-----------------------------------------------------------------------------------------------------------------------------
;----------------------------------------------------------------------------------------------------------END TAB SWITCHING--
;-----------------------------------------------------------------------------------------------------------------------------




;-----------------------------------------------------------------------------------------------------------------------------
;----------------------------------------------------------------------------------------------------BUTTON & MENU FUNCTIONS--
;-----------------------------------------------------------------------------------------------------------------------------
AddData:
If LV_GetCount() = 0
{
MsgBox, 8240, No Data!, List is empty, please select source data and try again.
return
}
;This is the part where I link to M2M wickedness.
If SelTab = BOM
	GoSub, AddBOM
Else If SelTab = INV
	GoSub, AddINV
Else If SelTab = RAW
	GoSub, AddRAW
return

SourceData:
Gui, +Disabled
If SelTab = BOM
	GoSub, FillBOMlvSelect
Else If SelTab = INV
	GoSub, FillINVlvSelect
Else If SelTab = RAW
	GoSub, FillRAWlvSelect
Gui, -Disabled
WinActivate, ahk_id %E2Mid%
return

ClearData:
if LV_GetCount() > 0
{
	MsgBox, 8228, Clear List?, Are you sure you want to clear all data from the list?
	IfMsgBox Yes
		lV_Delete()
}
return

MenuFileOpen:
GoSub, SourceData
Return

MenuHandler:
msgbox, 8192, About E2M, E2M is a custom solution to add Items & BOMs to M2M`rCreated by Tim Frazier`rJewell Attachments`r2012
return

RemoveSelected:
If LV_GetNext(0,"Checked") = 0
	return
Else
	{
	MsgBox, 8225, Remove Items?, Are you sure you want to remove the selected items?
	IfMsgBox Cancel
		return
	}
Loop
{
	TargRow := LV_GetNext(0,"Checked")
	LV_Delete(TargRow)
} Until LV_GetNext(0,"Checked") = 0
return
;-----------------------------------------------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------------------END BUTTON & MENU FUNCTIONS--
;-----------------------------------------------------------------------------------------------------------------------------





;-----------------------------------------------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------------------LISTVIEW INTERACT FUNCTIONS--
;-----------------------------------------------------------------------------------------------------------------------------

BOMListView:
if A_GuiEvent = DoubleClick
{
	If LV_GetCount() > 0
	{
		LV_GetText(EditItem, A_EventInfo)
		LV_GetText(Editqty, A_EventInfo, 2)
		LV_GetText(Editpnum, A_EventInfo, 3)
		RowNumSelected := A_EventInfo
		gosub, EditEntry
	}
	Else
		GoSub, SourceData
}
return

INVListView:
if A_GuiEvent = DoubleClick
{
	If LV_GetCount() > 0
	{
		LV_GetText(Editpnum, A_EventInfo)
		LV_GetText(EditDesc, A_EventInfo, 2)
		LV_GetText(EditPC, A_EventInfo, 3)
		LV_GetText(EditGC, A_EventInfo, 4)
		LV_GetText(EditSC, A_EventInfo, 5)
		RowNumSelected := A_EventInfo
		gosub, EditEntry
	}
	Else
		GoSub, SourceData
}
return

RAWListView:
if A_GuiEvent = DoubleClick
{
	If LV_GetCount() > 0
	{
		LV_GetText(Editpnum, A_EventInfo)
		LV_GetText(Descout, A_EventInfo, 2)	
		LV_GetText(EditMatl, A_EventInfo, 3)
		LV_GetText(Editqty, A_EventInfo, 4)
		RowNumSelected := A_EventInfo
		gosub, EditEntry
	}
	Else
		GoSub, SourceData
}
return

EditEntry:
Gui, +Disabled
Gui, EditGui: -SysMenu +Owner

If SelTab = BOM
	{
	Gui, EditGui:Add, Text, w40 section, Item #:
	Gui, EditGui:Add, Edit, w40 r1 vItemout, %EditItem%
	Gui, EditGui:Add, Text, ys w40 section, Qty.:
	Gui, EditGui:Add, Edit, w40 r1 vQtyout, %EditQty%
	Gui, EditGui:Add, Text, ys w150 section, Part #:
	Gui, EditGui:Add, Edit, w150 r1 vPnumout, %EditPnum%
	Wid := 40 + 40 + 150 + 40
	}
Else If SelTab = INV
	{
	Gui, EditGui:Add, Text, w80 section, Part #:
	Gui, EditGui:Add, Edit, w80 r1 vPnumout, %EditPnum%
	Gui, EditGui:Add, Text, ys w150 section, Description:
	Gui, EditGui:Add, Edit, w150 r1 vDescout, %EditDesc%
	Gui, EditGui:Add, Text, ys w110 section, Product Class:
	PCopts = D: Instruction|FG: Turnkey|FP: Fabricated|I: Field Install|M: Misc.|P: Purchased|RM: Raw Material|T: Jigs & Fixtures
	PCsel :=
	Loop, Parse, PCopts,|
		{
		PCteststr := SubStr(A_LoopField,1,InStr(A_LoopField,":")-1)
		if EditPC = %PCteststr%
			PCsel = %A_Index%
		}
	Gui, EditGui:Add, DDL, w110 vPCout Choose%PCsel%, %PCopts%
	Gui, EditGui:Add, Text, ys w180 section, Group Code:
	GCsel :=
	Loop, Parse, GroupCodes,|
		{
		GCteststr := SubStr(A_LoopField,1,InStr(A_LoopField,":")-1)
		if EditGC = %GCteststr%
			GCsel = %A_Index%
		}
	Gui, EditGui:Add, DDL, w180 vGCout Choose%GCsel%, %GroupCodes%
	Gui, EditGui:Add, Text, ys w66 section, Source:
	SCopts = Make|Buy|Stock|Phantom
	SCsel :=
	Loop, Parse, SCopts,|
		{
		if EditSC = %A_LoopField%
			SCsel = %A_Index%
		}
	Gui, EditGui:Add, DDL, w66 vSCout Choose%SCsel%, %SCopts%
	;Gui, EditGui:Add, Edit, w40 r1 vSCout, %EditSC%
	Wid := 80 + 150 + 110 + 180 + 66 + 60
	}
Else If SelTab = RAW
	{
	Gui, EditGui:Add, Text, w80 section, Part #:
	Gui, EditGui:Add, Edit, w80 r1 vPnumout, %EditPnum%
	Gui, EditGui:Add, Text, ys w60 section, Mat'l:
	Gui, EditGui:Add, Edit, w60 r1 vMatlout, %EditMatl%
	Gui, EditGui:Add, Text, ys w60 section, Qty.:
	Gui, EditGui:Add, Edit, w60 r1 vQtyout, %EditQty%
	Wid := 80 + 60 + 60 + 40
	}
Wid := (Wid / 2) - 105
Gui, EditGui:Add, Button, gEditRowOK Default x%Wid% w100 h25 section, OK
Gui, EditGui:Add, Button, gEditRowCancel ys w100 h25, Cancel
Gui, EditGui:Show,, Edit Entry
return


EditRowOK:
Gui, EditGui:Submit
Gui, 1:-Disabled
Gui, EditGui:Destroy
setcontroldelay -1
ControlClick, Button1, ahk_id %E2Mid%
setcontroldelay 20
return

Activator:
if SelTab = BOM
	LV_Modify(RowNumSelected, "", Itemout, Qtyout, Pnumout)
Else If SelTab = INV
	{
	PCout := SubStr(PCout,1,InStr(PCout,":")-1)
	GCout := SubStr(GCout,1,InStr(GCout,":")-1)
	LV_Modify(RowNumSelected, "", Pnumout, Descout, PCout, GCout, SCout)
	}
Else If SelTab = RAW
	LV_Modify(RowNumSelected, "", Pnumout, Descout, Matlout, Qtyout)	
Return

EditGuiGuiEscape:
EditRowCancel:
Gui, 1:-Disabled
Gui, EditGui:Destroy
WinActivate, ahk_id %E2Mid%
return
;-----------------------------------------------------------------------------------------------------------------------------
;--------------------------------------------------------------------------------------------END LISTVIEW INTERACT FUNCTIONS--
;-----------------------------------------------------------------------------------------------------------------------------





;-----------------------------------------------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------------------POPULATE LISTVIEW FUNCTIONS--
;-----------------------------------------------------------------------------------------------------------------------------

;------------------------------------------------------------------------------------------------------BOM LISTVIEW-----------
FillBOMlvSelect:
FileSelectFile, BOMDataSource,3,,Select a Data Source with a Bill of Materials, Text Files(*.txt; *.csv)
if BOMDataSource =
{
return
}

if LV_GetCount() > 0
	{
	MsgBox, 8227, Clear Table?, Would you like to clear the list before adding the new items?
	IfMsgBox Yes
		lV_Delete()
	else IfMsgBox Cancel
		{
		BOMDataSource :=
		return
		}
	}

filereadline, PNcount, %BOMDataSource%, 1
						;--------------------------------------------Check here to see that BOMDataSource is in the proper format
i:=2

filereadline, FullLine, %BOMDataSource%, i
mylength := StrLen(FullLine) > 0
;================================================================================ USE: Loop, Read, %DataSource% => A_LoopReadLine
While, StrLen(FullLine) > 0
{
	StringLeft, ItemNum, FullLine, InStr(FullLine, ",")-1
	StringRight, FullLine, FullLine, StrLen(FullLine)-InStr(FullLine, ",")
	StringLeft, Quantity, FullLine, InStr(FullLine, ",")-1
	StringRight, FullLine, FullLine, StrLen(FullLine)-InStr(FullLine, ",")
	StringLeft, PartNum, FullLine, InStr(FullLine, ",")-1
	PartNum := MODPARTNUM(PartNum)
	StringRight, FullLine, FullLine, StrLen(FullLine)-InStr(FullLine, ",")
	StringReplace, Description, FullLine, :, `,
	LV_Add("",ItemNum, Quantity, PartNum, Description)
	i:= i+1
	FullLine := ""
	filereadline, FullLine, %BOMDataSource%, i
}

LV_ModifyCol(1,"AutoHdr")
LV_ModifyCol(2,"AutoHdr")
LV_ModifyCol(3,"AutoHdr")
LV_ModifyCol(4,"AutoHdr")
LV_ModifyCol(1,"Integer")
LV_ModifyCol(2,"Integer")
LV_ModifyCol(1,"Left")
LV_ModifyCol(2,"Left")
LV_ModifyCol(3,"Left")

return


;-------------------------------------------------------------------------------------------------------INV LISTVIEW----------
FillINVlvSelect:
FileSelectFile, INVDataSource,3,,Select a Data Source New Items for the Item Master, Text Files(*.txt; *.csv)
if INVDataSource =
{
return
}

if LV_GetCount() > 0
	{
	MsgBox, 8227, Clear Table?, Would you like to clear the list before adding the new items?
	IfMsgBox Yes
		lV_Delete()
	else IfMsgBox Cancel
		{
		BOMDataSource :=
		return
		}
	}
	
sleep 50	;Don't need to sleep, this was just to see that it was doing something

filereadline, PNcount, %INVDataSource%, 1
						;------------------------------------------------Check here to see that INVDataSource is in the proper format
i:=2

filereadline, FullLine, %INVDataSource%, i
mylength := StrLen(FullLine) > 0
;============================================================================= USE: Loop, Read, %DataSource% => A_LoopReadLine
While, StrLen(FullLine) > 0
{
	StringLeft, PartNum, FullLine, InStr(FullLine, ",")-1
	StringReplace, PartNum, PartNum, .SLDDRW, ;needs to simply remove everything after a period
	PartNum := SubStr(PartNum, 1, 2) "`-" SubStr(PartNum, 3, 2) "`-" SubStr(PartNum, 5, 4)
	StringLeft, PartNumSeries, Partnum, 6
	Loop, Parse, INVcodes,|
		{
		PNteststr := SubStr(A_LoopField,1,InStr(A_LoopField,",")-1)
		if PartNumSeries = %PNteststr%
			{
			PNCodes = %A_LoopField%
			}
		}
	Loop, Parse, PNCodes, `,
		{
		if A_Index = 2
			ProdCode = %A_LoopField%
		else if A_Index = 3
			GroupCode = %A_LoopField%
		else if A_Index = 4
			SourceCode = %A_LoopField%
		}
	StringRight, FullLine, FullLine, StrLen(FullLine)-InStr(FullLine, ",")
	StringLeft, Description, FullLine, InStr(FullLine, ",")-1
	StringReplace, Description, Description, :, `,
	StringLeft, Description, Description, 30
	;=======================================================================================Determine GroupCode and Source from P/N
	LV_Add("",PartNum, Description, ProdCode, GroupCode, SourceCode)
	i:= i+1
	FullLine := ""
	filereadline, FullLine, %INVDataSource%, i
}

LV_ModifyCol(1,"AutoHdr")
LV_ModifyCol(2,"AutoHdr")
LV_ModifyCol(4,"AutoHdr")

return 

;-------------------------------------------------------------------------------------------------------RAW LISTVIEW----------
FillRAWlvSelect:
FileSelectFile, RAWDataSource,3,,Select a Data Source with RM's to Add, Text Files(*.txt; *.csv)
if RAWDataSource =
{
return
}

if LV_GetCount() > 0
	{
	MsgBox, 8227, Clear Table?, Would you like to clear the list before adding the new items?
	IfMsgBox Yes
		lV_Delete()
	else IfMsgBox Cancel
		{
		BOMDataSource :=
		return
		}
	}

filereadline, PNcount, %RAWDataSource%, 1
						;-------------------------------------------------Check here to see that RAWDataSource is in the proper format
;Format is: "Qty,File Name,Description,State,StockSize,Material,M2M_UnitQty,M2M_UnitOfMeasure,TrueArea,Revision"

i:=1
Loop, Read, %RAWDataSource%
{
	if i = 1
		{
		i++ ;increment i
		;check format, exit loop if necessary
		} 
	else
	{
		StringTrimLeft, FullLine, A_LoopReadLine, InStr(A_LoopReadLine, ",")					;Strip Qty
		StringLeft, PartNum, FullLine, InStr(FullLine, ",")-1
		StringLeft, PartNum, FullLine, InStr(FullLine, ".")-1
		PartNum := Trim(PartNum)
		PartNum := MODPARTNUM(PartNum)															;Get File Name : PartNum
		StringTrimLeft, FullLine, FullLine, InStr(FullLine, ",")								
		StringLeft, Description, FullLine, InStr(FullLine, ",")-1
		StringReplace, Description, Description, :, `,
		StringTrimLeft, FullLine, FullLine, InStr(FullLine, ",")								;Get Description : Description
		StringTrimLeft, FullLine, FullLine, InStr(FullLine, ",")								;Strip State
		StringLeft, StockSize, FullLine, InStr(FullLine, ",")-1
		StringTrimLeft, FullLine, FullLine, InStr(FullLine, ",")								;Get StockSize
		StringLeft, Material, FullLine, InStr(FullLine, ",")-1
		StringTrimLeft, FullLine, FullLine, InStr(FullLine, ",")								;Get Material
		StringLeft, UnitQty, FullLine, InStr(FullLine, ",")-1
		StringTrimLeft, FullLine, FullLine, InStr(FullLine, ",")								;Get Unit Quantity
		StringLeft, UnitMeas, FullLine, InStr(FullLine, ",")-1
		StringTrimLeft, FullLine, FullLine, InStr(FullLine, ",")								;Get UoM
		If UnitMeas = IN^2
			{
			gosub, ConvSS
			StockSize := StockSize . " " . Material
			}
		LV_Add("",PartNum, Description, StockSize, UnitQty, UnitMeas)					;Discard Remainder & Add Line to ListView
	}

}

LV_ModifyCol(1,"AutoHdr")
LV_ModifyCol(2,"AutoHdr")
LV_ModifyCol(3,"AutoHdr")
LV_ModifyCol(4,"AutoHdr")
LV_ModifyCol(1,"Integer")
LV_ModifyCol(2,"Integer")
LV_ModifyCol(1,"Left")
LV_ModifyCol(2,"Left")
LV_ModifyCol(3,"Left")

return

ConvSS:
OnesPlace := 0
if StockSize > 1
	{
	OnesPlace := Floor(StockSize)
	StockSize := Stocksize - OnesPlace
	}

StockSize := Round(StockSize*16)
If Floor(StockSize/2) = Stocksize/2
	{
	Stocksize := Round(Stocksize/2)
	If Floor(StockSize/2) = Stocksize/2
		{
		Stocksize := Round(Stocksize/2)
		If Floor(StockSize/2) = Stocksize/2
			{
			Stocksize := Round(Stocksize/2)
			If Floor(StockSize/2) = Stocksize/2
				{
				Stocksize := Round(Stocksize/2)
				}
			else
				Stocksize := Stocksize . "/2"
			}
		else
			Stocksize := Stocksize . "/4"
		}
	else
		Stocksize := Stocksize . "/8"
	}
else
	Stocksize := Stocksize . "/16"
If OnesPlace > 0
	Stocksize := OnesPlace . " " . StockSize
if StockSize = 0
	StockSize := ""
return
;-----------------------------------------------------------------------------------------------------------------------------
;--------------------------------------------------------------------------------------------END POPULATE LISTVIEW FUNCTIONS--
;-----------------------------------------------------------------------------------------------------------------------------





;-----------------------------------------------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------------------------------------FUNCTIONS--
;-----------------------------------------------------------------------------------------------------------------------------
MODPARTNUM(InputPartNumber)
{
	StringReplace, InputPartNumber, InputPartNumber, _,,All
	StringReplace, InputPartNumber, InputPartNumber, -,,All
	StringReplace, InputPartNumber, InputPartNumber, /,,All
	StringReplace, InputPartNumber, InputPartNumber, `,,,All
	StringReplace, InputPartNumber, InputPartNumber, `.,,All
	StringReplace, InputPartNumber, InputPartNumber, %A_SPACE%,,All
			
	Test = %InputPartNumber%
	Test := "`n" Test "," ;IMPORTANT: add linefeed (`n) to the beginning and comma (,) to the end of the search term, this guarantees an exact match.
	TestLen := StrLen(Test)
	OutTxt := "Not Found"
	if StrLen(InputPartNumber) = 8
	{
		OutTxt := SubStr(InputPartNumber, 1, 2) "`-" SubStr(InputPartNumber, 3, 2) "`-" SubStr(InputPartNumber, 5, 4)
	}

	StringGetPos, Start, Everything, %Test%
	if Start > 0
	{
		Start := Start + TestLen
		StringTrimLeft, OutTxt, Everything, Start
		EndPos := InStr(OutTxt, "`,", 0,1,1)
		StringLeft, OutTxt, OutTxt, EndPos - 1
	}
	return OutTxt
}

WaitYellow:
	j := 0
	color := 0
	MouseGetPos, CurX, CurY
	loop {
		pixelgetcolor, color, curx, cury
		sleep 25
		++j
		ifgreater, j, 400, break
	} until color = 0x00FFFF
return

WatchCursor:
MouseGetPos, , , id, control
if id = %E2Mid%
	{
	if control = Button2
		SB_SetText("Select a file containing data to input in M2M")
	else if control = Button3
		SB_SetText("Clear all data from list")
	else if control = Button4
		SB_SetText("Remove checked items from list")
	else if control = Button5
		SB_SetText("Input data to Made 2 Manage")
	else
		SB_SetText("Ready")
	}
return

GuiClose:  ; Indicate that the script should exit automatically when the window is closed.
ExitApp

;-----------------------------------------------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------------------------------------ADD BOM----
;-----------------------------------------------------------------------------------------------------------------------------

AddBOM:

;make sure you have M2M open in Paladin Desktop and ready to type a PN into your new BOM
/*
P/N
Tab 3
item number
Tab 2
BOM Qty
control-shift-N until done, then F6 to save the work
*/

SetKeyDelay, 20
SetBatchLines 1

msgbox, 8193, Are you ready?, Be sure M2M is running`, the BOM window is open`, and the correct BOM is ready to accept items. Press OK when ready.
IfMsgBox Cancel
	return

;activate Paladin Desktop
IfWinExist, Made2Manage
    Winactivate
else
	return
sleep 500

i := 1

loop, % LV_GetCount()
{
	;filereadline, partnum, c:\filelist.txt, %i%		;PN
	LV_GetText(BOMpartnum, i,3)
	LV_GetText(BOMitem, i)
	LV_GetText(BOMqty, i, 2)

	send %BOMpartnum%
	send {tab 3}^a
	send %BOMitem%
	send {tab}^a
	send %BOMqty%
	send !{F5}
	sleep 500
	++i
}

return


;-----------------------------------------------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------------------------------------ADD INV----
;-----------------------------------------------------------------------------------------------------------------------------

AddINV:
SetKeyDelay, 1

msgbox, 8193, Are you ready?, Be sure M2M is running`, the INV window is open`, and a suitable copy-from is open. Press OK when ready.
IfMsgBox Cancel
	return

;blockinput, MouseMove
;blockinput, sendandmouse
IfWinExist, Made2Manage
    Winactivate
else
	return

i:=1

send {F2}
sleep 2000
loop, % LV_GetCount()
	{
	LV_GetText(INVpartnum, i)
	LV_GetText(INVdesc, i, 2)
	LV_GetText(INVgpcode, i, 4)
	LV_GetText(INVsource, i, 5)
	msgbox %INVpartnum%+%INVdesc%+%INVgpcode%+%INVsource%
	

	
	if i = 1
		{
		;Product Class
		controlgetpos, Exx, Wyy, Wid, Hig, WindowsForms10.EDIT.app.0.2bf8098_r13_ad18
		mousemove, Exx + Wid/2, Wyy + Hig/2, 0
		mouseclick,,,,1
		WhatNeedFoc = WindowsForms10.EDIT.app.0.2bf8098_r13_ad18
		loop, 150
			{
			controlgetfocus, WhatHasFoc
			If WhatHasFoc = %WhatNeedFoc%
				Break
			sleep 10
			}
		send fp{Tab}
		;Drawing Number
		controlgetpos, Exx, Wyy, Wid, Hig, WindowsForms10.EDIT.app.0.2bf8098_r13_ad115
		mousemove, Exx + Wid/2, Wyy + Hig/2, 0
		mouseclick,,,,2
		WhatNeedFoc = WindowsForms10.EDIT.app.0.2bf8098_r13_ad115
		loop, 150
			{
			controlgetfocus, WhatHasFoc
			If WhatHasFoc = %WhatNeedFoc%
				Break
			sleep 10
			}
		send ^a-{Tab}
		;Revision Date
		controlgetpos, Exx, Wyy, Wid, Hig, WindowsForms10.EDIT.app.0.2bf8098_r13_ad117
		mousemove, Exx + Wid/2, Wyy + Hig/2, 0
		mouseclick,,,,2
		;ABC Code
		controlgetpos, Exx, Wyy, Wid, Hig, WindowsForms10.EDIT.app.0.2bf8098_r13_ad122
		mousemove, Exx + Wid/2, Wyy + Hig/2, 0
		mouseclick,,,,1
		WhatNeedFoc = WindowsForms10.EDIT.app.0.2bf8098_r13_ad122
		loop, 150
			{
			controlgetfocus, WhatHasFoc
			If WhatHasFoc = %WhatNeedFoc%
				Break
			sleep 10
			}
		send c{Tab}
		;U/M for Vendor Cost
		controlgetpos, Exx, Wyy, Wid, Hig, WindowsForms10.EDIT.app.0.2bf8098_r13_ad110
		mousemove, Exx + Wid/2, Wyy + Hig/2, 0
		mouseclick,,,,2
		WhatNeedFoc = WindowsForms10.EDIT.app.0.2bf8098_r13_ad110
		loop, 150
			{
			controlgetfocus, WhatHasFoc
			If WhatHasFoc = %WhatNeedFoc%
				Break
			sleep 10
			}
		send e{Tab 2}
		;Location
		controlgetpos, Exx, Wyy, Wid, Hig, WindowsForms10.EDIT.app.0.2bf8098_r13_ad135
		mousemove, Exx + Wid/2, Wyy + Hig/2, 0
		mouseclick,,,,2
		WhatNeedFoc = WindowsForms10.EDIT.app.0.2bf8098_r13_ad135
		loop, 150
			{
			controlgetfocus, WhatHasFoc
			If WhatHasFoc = %WhatNeedFoc%
				Break
			sleep 10
			}
		send 01{Tab}
		}
	else
		{
		; If save is taking a long time this needs to be a much longer wait.
		loop, 50
			{
			send !{Ins}
			IfWinExist, Copying Item Master, Create New Part Number or Create New Rev
				Break
			sleep 25
			}
		send {Enter}

		WinWaitActive, Made2Manage,,5
		if ErrorLevel = 1
			{
			msgbox Error finding M2M window. Program will exit.
			return
			}
		}
	;Group Code
	controlgetpos, Exx, Wyy, Wid, Hig, WindowsForms10.EDIT.app.0.2bf8098_r13_ad19
	mousemove, Exx + Wid/2, Wyy + Hig/2, 0
	mouseclick,,,,2
	WhatNeedFoc = WindowsForms10.EDIT.app.0.2bf8098_r13_ad19
	loop, 150
		{
		controlgetfocus, WhatHasFoc
		If WhatHasFoc = %WhatNeedFoc%
			Break
		sleep 10
		}
	send ^a
	send %INVgpcode%
	send {Tab}
	;Part Number
	controlgetpos, Exx, Wyy, Wid, Hig, WindowsForms10.EDIT.app.0.2bf8098_r13_ad12
	mousemove, Exx + Wid/2, Wyy + Hig/2, 0
	mouseclick,,,,2
	WhatNeedFoc = WindowsForms10.EDIT.app.0.2bf8098_r13_ad12
	loop, 150
		{
		controlgetfocus, WhatHasFoc
		If WhatHasFoc = %WhatNeedFoc%
			Break
		sleep 10
		}
	send ^a
	send %INVpartnum%
	send {Tab}
	;Description
	controlgetpos, Exx, Wyy, Wid, Hig, WindowsForms10.EDIT.app.0.2bf8098_r13_ad16
	mousemove, Exx + Wid/2, Wyy + Hig/2, 0
	mouseclick,,,,2
	WhatNeedFoc = WindowsForms10.EDIT.app.0.2bf8098_r13_ad16
	loop, 150
		{
		controlgetfocus, WhatHasFoc
		If WhatHasFoc = %WhatNeedFoc%
			Break
		sleep 10
		}
	send ^a
	send %INVdesc%
	send {Tab}
	;Source
	controlgetpos, Exx, Wyy, Wid, Hig, WindowsForms10.EDIT.app.0.2bf8098_r13_ad17
	mousemove, Exx + Wid/2, Wyy + Hig/2, 0
	mouseclick,,,,2
	WhatNeedFoc = WindowsForms10.EDIT.app.0.2bf8098_r13_ad17
	loop, 150
		{
		controlgetfocus, WhatHasFoc
		If WhatHasFoc = %WhatNeedFoc%
			Break
		sleep 10
		}
	send ^a
	send %INVsource%
	send {Tab}
	
	send {F6}
	
	++i
	}

return



;-----------------------------------------------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------------------------------------ADD RAW----
;-----------------------------------------------------------------------------------------------------------------------------
/*
Control-N
send p/n
Tab
wait
control-s (F6)
RM P/N
Tab x5
unit qty
ctrl-s
wait
*/
AddRAW:
SetKeyDelay, 20
SetBatchLines 1

;activate Paladin Desktop
IfWinExist, Made2Manage
    Winactivate
else
	{
	MsgBox, 8192, Oops!, Please open M2M.
	return
	}
sleep 500

WinGetPos, , , WinWidth, WinHeight, A

i:=1

loop, % LV_GetCount()
	{
	LV_GetText(RAWpartnum, i) ;Parent PN
	LV_GetText(RAWchildnum, i, 3) ;Child PN
	LV_GetText(RAWqty, i, 4) ;Qty

	Cycles := 0
	MaxCycles := 20
	sleep 1500
	Loop
		{
		sleep 500
		++Cycles
		ImageSearch, FoundX, FoundY, 1, 1, WinWidth, WinHeight, *TransFuchsia PCratio.bmp
		if ErrorLevel = 2
			{
			MsgBox, 8192, Oops!, An internal error has occurred, could not conduct search. ;`nChecked items have been added.
			Return
			}
		else if ErrorLevel = 1
			{
			if Cycles = %MaxCycles%
				{
				MsgBox, 8192, Oops!, Something went wrong in M2M, please try again. ;`nChecked items have been added.
				Return
				}
			}
		else if ErrorLevel = 0
			{
			FoundX += 4
			FoundY += 4
			mousemove foundx, foundy
			click
			;If i > 1 ;If you made it to here then the previous item was successful, check that box
			;	{
			;	LV_Modify(i-1, "check")
			;	}
			send ^n						;ctrl-n
			send %RAWpartnum%			;enter Parent PN
			send {tab}					;tab
			send ^s						;ctrl-s
			send %RAWchildnum%			;enter: Child PN, Tab-4x, Qty) 
			send {tab 4}^a
			send %RAWqty%
			send ^s						;ctrl-s
			break
			}
		}
	++i
	}
return


;-----------------------------------------------------------------------------------------------------------------------------
;----------------------------------------------------------------------------------------------------------------RESIZE-------
;-----------------------------------------------------------------------------------------------------------------------------


GuiSize:
Anchor("Button2", "x", true)
Anchor("Button3", "x", true)
Anchor("Button4", "x", true)
Anchor("Button5", "x", true)
Anchor("Static1", "xy", true)
;Anchor("Button7", "x", true)
;Anchor("Button8", "x", true)
Anchor("SysListView321", "wh", true)
Anchor("SysListView322", "wh", true)
Anchor("SysListView323", "wh", true)
Anchor("SysTabControl321", "wh", true)
return

#include Anchor64.ahk

Pause::Pause