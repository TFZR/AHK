#SingleInstance Force

if 0 < 3
	{
		MsgBox Not enough parameters. Use a command line string in the form 'VisualLogin.exe Database UserID UserPW'
		ExitApp
	}
else
	{
		strDB = %1%
		strID = %2%
		strPW = %3%
	}

ifwinexist, Infor ERP VISUAL
	{
		winactivate, Infor ERP VISUAL ahk_exe VM.exe
		send, !fc{enter}
		winactivate, Infor ERP VISUAL ahk_exe VM.exe
		winwaitactive, Infor ERP VISUAL ahk_exe VM.exe
		send, !fl
	}
else
	{
		run, C:\Infor\VISUAL Enterprise\VISUAL Manufacturing\VM.EXE
	}
winwaitactive, Login ahk_exe VM.EXE
controlsettext, Edit1, %strDB%
controlsettext, Edit2, %strID%
controlsettext, Edit3, %strPW%
send, a{BS}
Send {enter}
ExitApp
