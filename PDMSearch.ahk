IfWinExist, SolidWorks Enterprise PDM Search
    Winactivate
else
	return

;ControlMove, AfxMDIFrame80u3, ,800
controlmove, SysTreeView323, , 650
controlMove, SysHeader326, , 780
controlmove, SysListView326, , 800
