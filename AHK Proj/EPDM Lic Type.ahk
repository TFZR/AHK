; From: https://forum.solidworks.com/message/253326
;
; You could run a script on client PCs to get values from the registry. 
; 
; [HKEY_LOCAL_MACHINE\SOFTWARE\SolidWorks\Applications\PDMWorks Enterprise]
; "PTID"="{Value for license type is here and will change if you change the license type}"
;  
; {05AD35C4-8A9A-4114-B51F-32186222ABA1} - CAD Editor
; {CC72DD26-1A34-4209-B50B-21C7DD5E29F6} -  Viewer
; {E2BE88CF-6E17-43e2-A837-C1051F3E4EDB} - Web contributor

RegRead, EPDMLic, HKEY_LOCAL_MACHINE, SOFTWARE\SolidWorks\Applications\PDMWorks Enterprise, PTID
if EPDMLic = {05AD35C4-8A9A-4114-B51F-32186222ABA1}
	msgbox CAD Editor
	
if EPDMLic = {CC72DD26-1A34-4209-B50B-21C7DD5E29F6}
	msgbox Viewer
	
if EPDMLic = {E2BE88CF-6E17-43e2-A837-C1051F3E4EDB}
	msgbox Web Contributor

