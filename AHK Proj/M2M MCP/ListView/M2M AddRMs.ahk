;Prerequisite: M2M open w/Standard BOM (BOM) dialog open for viewing (not data entry)

; NOTES: A large delay (4s, end of loop) is needed between items, seems to activate other windows when running quicker. 
;		Perhaps activate Paladin Desktop in each loop.  May also need to have two images, one greyed out and the other with white space.
;		Search for image, if not found sleep 50, repeat 20x, if still not found then exit.

; added key delay and rest after each line to make script more reliable, not noticeably slower.
SetKeyDelay, 20
SetBatchLines 1

;activate Paladin Desktop
IfWinExist, Paladin
    Winactivate
else
	return
sleep 500

WinGetPos, , , WinWidth, WinHeight, A

filereadline, PNcount, c:\filelist.txt, 1
;requires filelist.txt to be populated, first line is the number of parts to be added
;next 3 lines are Parent PN, Child PN, and Qty.  Those 3 parameters repeat.
i:=2

loop, %PNcount%
{
	filereadline, Partnum, c:\filelist.txt, %i%		;Parent PN
	i:= i+1
	filereadline, Childnum, c:\filelist.txt, %i%	;Child PN
	i := i + 1
	filereadline, Qty, c:\filelist.txt, %i%			;qty
	i := i + 1
	
;activate Paladin Desktop
	
ImageSearch, FoundX, FoundY, 1, 1, WinWidth, WinHeight, *TransFuchsia PCratio.bmp
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


;ctrl-n
	send ^n
;enter Parent PN
	send %Partnum%
;tab
	send {tab}
;ctrl-s
	send ^s
;enter: Child PN, Tab-4x, Qty) 
	send %Childnum%
	send {tab 4}^a
	send %Qty%
;ctrl-s (instead of alt-f5)
	send ^s
;	sleep 4000
Ready := 0
Cycles := 0
sleep 1500
while Ready = 0
	{
	sleep 500
	Cycles := Cycles + 1
	ImageSearch, FoundX, FoundY, 1, 1, WinWidth, WinHeight, *TransFuchsia PCratio.bmp
	if ErrorLevel = 2
		{
		}
	else if ErrorLevel = 1
		{
		if Cycles = 20
			{
			MsgBox Man, things are slow today.
			exit
			}
		}
	else
		{
		Ready := 1
		}
	 
	}
}
;repeat as needed from "Click Parent"
