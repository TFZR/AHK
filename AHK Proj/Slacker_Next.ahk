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
controlsend, Chrome_RenderWidgetHostHWND1, {Alt Down}{Right}{Alt up}, ahk_class Chrome_WidgetWin_1, www.slacker.com ;Skip (Next)
;send {Alt}
;ClassNN: Chrome_RenderWidgetHostHWND1