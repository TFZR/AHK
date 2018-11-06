filereadline, PNcount, c:\filelist.txt, 1
i:=2
loop, %PNcount%
{
filereadline, partnum, c:\filelist.txt, %i%
i:= i+1
;msgbox %i%
filereadline, desc, c:\filelist.txt, %i%
i := i + 1
filereadline, gpcode, c:\filelist.txt, %i%
i := i + 1
filereadline, source, c:\filelist.txt, %i%
i := i + 1
;msgbox %partnum% %desc% %gpcode% %source%
;send %partnum% %desc% %gpcode% %source%{enter}
}
return