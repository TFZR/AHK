SetKeyDelay, 5
SetBatchLines 1
Start := A_Now

;blockinput, MouseMove
;blockinput, sendandmouse
IfWinExist, Paladin
    Winactivate
else
	return
sleep 500

filereadline, PNcount, c:\filelist.txt, 1
;requires filelist.txt to be populated, first line is the number of parts to be added
;next 4 lines are PN, Description, Group Code, and Source.  Those 4 parameters repeat.
i:=2
boolEnterDate := 1

WinGetPos, , , WinWidth, WinHeight, A

ImageSearch, INV_X, INV_Y, 1, 1, WinWidth, WinHeight, *TransFuchsia INV.bmp
if ErrorLevel = 2
	{
	blockinput, MouseMoveoff
	blockinput, default
    MsgBox Could not conduct the search.
	exit
	}
else if ErrorLevel = 1
	{
	blockinput, MouseMoveoff
	blockinput, default
    MsgBox Icon could not be found on the screen.
	exit
	}
else
	{
	GoSub subAdd_Carry
	}
blockinput, MouseMoveoff
blockinput, default
End := A_Now
EnvSub, End, Start, seconds
msgbox done. %End% seconds
return

;Start of Subroutines----------------------------------------------------------------------------------------------------------------

subAdd_Carry:

	;GoSub subMatlType

	
loop, %PNcount%
{
	filereadline, partnum, c:\filelist.txt, %i%
	++i
	filereadline, desc, c:\filelist.txt, %i%
	++i
	filereadline, gpcode, c:\filelist.txt, %i%
	++i
	filereadline, source, c:\filelist.txt, %i%
	++i

	send !{Insert}
	send {Enter}
	
	GoSub subPartNum
	GoSub subDesc
	GoSub subGroupCode
	
	;first time only - Enter 'Revision Date'
	if boolEnterDate
	{
		GoSub subRevDate
		GoSub subMatlType
		boolEnterDate := 0
	}
	;/'Revision Date
	
	;only if source changes (b/m/s/p) 
		GoSub subSource
	;/only if source changes
	send ^z
	;send ^s
	;send ^s
}
return

WaitYellow:
	j=0
	MouseGetPos, CurX, CurY
	loop {
		pixelgetcolor, color, curx, cury
		sleep 25
		++j
		ifgreater, j, 400, break
	} until color = 0x00FFFF
return

subPartNum:
	Mousemove INV_X-543, INV_Y+19 ;Part No
	click
	gosub WaitYellow
	send ^a
	send %partnum%
return

subDesc:
	Mousemove INV_X-438, INV_Y+38 ;Description
	click
	gosub WaitYellow
	send ^a
	send %desc%
return

subGroupCode:
	Mousemove INV_X-530, INV_Y+59 ;Group Code
	click
	gosub WaitYellow
	send ^a
	send %gpcode%
return

subMatlType:
	Mousemove INV_X-550, INV_Y+117 ;MatlType
	click
	gosub WaitYellow
	send ^a
	send -
return

subRevDate:
	Mousemove INV_X-520, INV_Y+136 ;Rev Date
	click
	gosub WaitYellow
	click 2
return

subSource:
	Mousemove INV_X-125, INV_Y+45 ;Source
	click
	gosub WaitYellow
	send %source%
	click
return