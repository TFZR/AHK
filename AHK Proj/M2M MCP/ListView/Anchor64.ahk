;Anchor by Titan
;http://www.autohotkey.com/forum/viewtopic.php?t=4348
Anchor(i, a = "", r = false) {
   static c, cs = 12, cx = 255, cl = 0, g, gs = 8, gl = 0, gpi, gw, gh, z = 0, k = 0xffff, ptr
   If z = 0
      VarSetCapacity(g, gs * 99, 0), VarSetCapacity(c, cs * cx, 0), ptr := A_PtrSize ? "Ptr" : "UInt", z := true
   If (!WinExist("ahk_id" . i)) {
      GuiControlGet, t, Hwnd, %i%
      If ErrorLevel = 0
         i := t
      Else ControlGet, i, Hwnd, , %i%
   }
   VarSetCapacity(gi, 68, 0), DllCall("GetWindowInfo", "UInt", gp := DllCall("GetParent", "UInt", i), ptr, &gi)
      , giw := NumGet(gi, 28, "Int") - NumGet(gi, 20, "Int"), gih := NumGet(gi, 32, "Int") - NumGet(gi, 24, "Int")
   If (gp != gpi) {
      gpi := gp
      Loop, %gl%
         If (NumGet(g, cb := gs * (A_Index - 1)) == gp, "UInt") {
            gw := NumGet(g, cb + 4, "Short"), gh := NumGet(g, cb + 6, "Short"), gf := 1
            Break
         }
      If (!gf)
         NumPut(gp, g, gl, "UInt"), NumPut(gw := giw, g, gl + 4, "Short"), NumPut(gh := gih, g, gl + 6, "Short"), gl += gs
   }
   ControlGetPos, dx, dy, dw, dh, , ahk_id %i%
   Loop, %cl%
      If (NumGet(c, cb := cs * (A_Index - 1), "UInt") == i) {
         If a =
         {
            cf = 1
            Break
         }
         giw -= gw, gih -= gh, as := 1, dx := NumGet(c, cb + 4, "Short"), dy := NumGet(c, cb + 6, "Short")
            , cw := dw, dw := NumGet(c, cb + 8, "Short"), ch := dh, dh := NumGet(c, cb + 10, "Short")
         Loop, Parse, a, xywh
            If A_Index > 1
               av := SubStr(a, as, 1), as += 1 + StrLen(A_LoopField)
                  , d%av% += (InStr("yh", av) ? gih : giw) * (A_LoopField + 0 ? A_LoopField : 1)
         DllCall("SetWindowPos", "UInt", i, "UInt", 0, "Int", dx, "Int", dy
            , "Int", InStr(a, "w") ? dw : cw, "Int", InStr(a, "h") ? dh : ch, "Int", 4)
         If r != 0
            DllCall("RedrawWindow", "UInt", i, "UInt", 0, "UInt", 0, "UInt", 0x0101) ; RDW_UPDATENOW | RDW_INVALIDATE
         Return
      }
   If cf != 1
      cb := cl, cl += cs
   bx := NumGet(gi, 48, "UInt"), by := NumGet(gi, 16, "Int") - NumGet(gi, 8, "Int") - gih - NumGet(gi, 52, "UInt")
   If cf = 1
      dw -= giw - gw, dh -= gih - gh
   NumPut(i, c, cb, "UInt"), NumPut(dx - bx, c, cb + 4, "Short"), NumPut(dy - by, c, cb + 6, "Short")
      , NumPut(dw, c, cb + 8, "Short"), NumPut(dh, c, cb + 10, "Short")
   Return, true
}

