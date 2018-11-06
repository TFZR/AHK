;Create's a new part in the M2M Item Master
;still finnickey, that transfer window is not well behaved, too bad the shortcut bar is subject to moving around or we could
;just pinpoint some mouse clicks.

;activate Paladin Desktop
IfWinExist, Paladin
    Winactivate
else
	return

;send !t ;Transfer Window
;sleep 4000 ;Wait for transfer window… how long do we have to wait for this to be reliable?
;send inv ;search for item master pnemonic
;sleep 1500 ;give it even more time, good grief
;send {enter} ;ok, finally try to open the item master window
;sleep 3000 ;wait some more, we want to make sure those windows are open
send !mp!d{enter}
sleep 3000
send ^n ;request a new part, commands from here out should stack well, so no waiting
send 06-05-6879 ;enter Part No
send {tab 3}plate, front/back ;tab through Rev, Cnt Rev, enter Description
send {tab}fp ;Enter Product class
send {tab}plate ;Enter Group Code
send {tab}ea ; Enter U/M for Vendor Cost
send {tab 3}^a- ;Tab to MatlType, select all, replace with "-"
send {tab}b	;enter drawing size
FormatTime, TimeString, , MMddyyyy ;get date string
send {tab}%TimeString% ;enter Revision Date
send {tab 6}p ;tab to and enter Source (Phantom)
send {tab 2}c ;tab to and enter ABC Code
send {tab 11}01 ;Tab to and enter Loc
send ^s^s
sleep 500
send !{Insert}
send {Enter}
send ^a06-05-6880
send {tab 3}^aplate, side wrapper

