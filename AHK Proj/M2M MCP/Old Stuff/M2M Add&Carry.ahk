;make sure you have M2M open in Paladin Desktop and the Item Master Window active with a similar part showing

; added key delay and rest after each line to make script more reliable, not noticeably slower.
SetKeyDelay, 25
SetBatchLines 1
Start := A_Now

;3/12/12 - Still Missing input boxes, skipping characters, garbeling data.  Need to slow down or check values
;3/13/12 - changed all i := i+1 to ++i
;3/13/12 - added boolEnterDate so date doesn't have to be entered for every part

;activate Paladin Desktop
IfWinExist, Paladin
    Winactivate
else
	return
sleep 500
FormatTime, TimeString, , MMddyyyy ;get date string
filereadline, PNcount, c:\filelist.txt, 1
;requires filelist.txt to be populated, first line is the number of parts to be added
;next 4 lines are PN, Description, Group Code, and Source.  Those 4 parameters repeat.
i:=2

boolEnterDate := 1

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
	sleep 500
	send ^a
	send %partnum%
	;sleep 250
	send {tab 3}^a
	send %desc%
	;sleep 250
	send {tab 2}^a
	send %gpcode%
	send {tab 6}
	
	;first time only - Enter 'Revision Date'
	if boolEnterDate
	{
		send ^a
		sleep 250
		send %TimeString%
		sleep 250
	}
	boolEnterDate := 0
	;/'Revision Date
	
	;only if source changes (b/m/s/p) 
		send {tab 6}
		send %source%
	;/only if source changes
	send ^z
	;send ^s
	;send ^s
	;sleep 250
}
End := A_Now
EnvSub, End, Start, seconds
msgbox done. %pncount% parts added in %End% seconds

/*
;old version was the following 6 lines manually filled out and repeated
sleep 500
send !{Insert}
send {Enter}
send ^a03-05-7011
send {tab 3}^aplate, stick ear doubler
send ^s^s
*/

/*
ENTER - Toggles check box and advances to next field
SPACE - Toggles check box and remains on that field

*/
RETURN
