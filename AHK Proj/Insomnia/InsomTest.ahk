CurState := DllCall("SetThreadExecutionState", UInt,0x80000000)
msgbox %CurState% + %ErrorLevel%
return