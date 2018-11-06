;make sure you have M2M open in Paladin Desktop and ready to type a PN into your new BOM

; added key delay and rest after each line to make script more reliable, not noticeably slower.
SetKeyDelay, 20
SetBatchLines 1

;activate Paladin Desktop
IfWinExist, Paladin
    Winactivate
else
	return
sleep 500
;FormatTime, TimeString, , MMddyyyy ;get date string
filereadline, PNcount, c:\filelist.txt, 1
;requires filelist.txt to be populated, first line is the number of parts to be added
;next 4 lines are PN, Description, Group Code, and Source.  Those 4 parameters repeat.
i:=2

loop, %PNcount%
{
	filereadline, partnum, c:\filelist.txt, %i%		;PN
	i:= i+1
	filereadline, desc, c:\filelist.txt, %i%		;item#
	i := i + 1
	filereadline, gpcode, c:\filelist.txt, %i%		;qty
	i := i + 1
;	filereadline, source, c:\filelist.txt, %i%
;	i := i + 1

;	send !{Insert}
;	send {Enter}
;	send ^a
	send %partnum%
	send {tab 3}^a
	send %desc%
	send {tab}^a
	send %gpcode%
;	send {tab 6}^a
;	sleep 250
;	send %TimeString%
;	send {tab 6}
;	send %source%
	send !{F5}
	sleep 500
}

RETURN
