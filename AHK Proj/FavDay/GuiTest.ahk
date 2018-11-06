;menu, tray, Icon, %A_ScriptFullPath%, -159
#notrayicon
#singleinstance force

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
DaysLeft := 6 - Mod(A_WDay, 7)

if A_WDay = 1
	{
	;Sunday
	Text1 = Holy cow dude! It's Sunday!
	Text2 = What the heck are you even doing here?
	}
else if A_WDay = 2
	{
	;Monday
	Text1 = Nice try, but it's only Monday.
	Text2 = At this rate it's going to be a looooooong week.
	}
else if A_WDay = 3
	{
	;Tuesday
	Text1 = No! It's only Tuesday!
	Text2 = Friday is still a long way off.
	}
else if A_WDay = 4
	{
	;Wednesday
	Text1 = Today is hump day, you're half way there.
	Text2 = Friday is almost in sight.
	}
else if A_WDay = 5
	{
	;Thursday
	Text1 = Hey, guess what tomorrow is.
	Text2 = That's right, Friday!
	}
else if A_WDay = 6
	{
	;Friday
	Text1 = It's finally here, Friday!
	Text2 = Friday is my favorite day!
	}
else
	{
	;Saturday
	Text1 = First off you missed it, yesterday was Friday.
	Text2 = Second it's the weekend, why are you working?
	}

Gui, New, -0x10000 -0x20000
Gui, Add, Text, x0 w200 center, %Text1%`n%Text2%
Gui, Add, Text, xm w100 Right Section, Today's Date:
Gui, Add, Text, xp+102 yp, %A_MM%.%A_DD%.%A_YYYY%
Gui, Add, Text, xp-102 yp+18 w100 Right, Day of Week:
Gui, Add, Text, xp+102 yp, %A_DDDD%
Gui, Add, Text, xp-102 yp+18 w100 Right, Days Until Friday:
Gui, Add, Text, xp+102 yp, %DaysLeft%
Gui, Add, Text, xp-102 yp+18 w100 Right, Fridays Remaining:
Gui, Add, Text, xp+102 yp, %Billy67%
Gui, Add, Button, x57 w86 h25, OK
Gui, Show, Center w200, Favorite Day v0.2

Return

GuiClose:
ButtonOK:
ExitApp