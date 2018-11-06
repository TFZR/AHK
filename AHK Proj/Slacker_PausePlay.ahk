/* 
Note: Slacker keyboard shortcuts
d -- volume down
u -- volume up
m -- mute
p -- Play/Pause
Alt-Right -- Skip
*/
detecthiddentext, on
SetTitleMatchMode, Slow
controlsend, Chrome_RenderWidgetHostHWND1, p, ahk_class Chrome_WidgetWin_1, www.slacker.com ;p for Pause/Play
;ClassNN: Chrome_RenderWidgetHostHWND1