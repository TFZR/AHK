Menu, Tray, NoIcon
stringleft, todaysdate, A_Now, 8
;todaysdate := 20150614 - todaysdate 
Billy67 := 20150614
EnvSub Billy67, todaysdate, d
Billy67 := floor((Billy67-3)/7)

DayOfWeek = not Friday.
ifEqual, A_WDay, 6
	DayOfWeek = my favorite day!
Text1 = Today is %DayOfWeek%
Text2 = Only %Billy67% more Fridays to go.

msgbox, 0, Favorite Day v0.1, %Text1%`n%Text2%
/*
Gui, Timmay:New
Gui, add, text,, Hey, this is stuff!
Gui, Timmay:Show
*/