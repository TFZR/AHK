;Single shortcut lock computer and turn off monitors
;TimTim - 8/2011
;Based on PushMonitOff.ahk v1.0 by Skrommel - 1 Hour Software, www.1HourSoftware.com
;This no longer works, what's up Win7?

#SingleInstance,Force
#NoEnv
#NoTrayIcon
;Log off with dll call
;DllCall("LockWorkStation")
;The elusive monitors-off command thanks to Skrommel
sleep 500
SendMessage, 0x112, 0xF140, 0,, Program Manager ;start screen saver
;SendMessage,0x112,0xF170,2,,Program Manager ;monitors off
return