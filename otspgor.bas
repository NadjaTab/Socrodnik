REM  *****  BASIC  *****

sub myotspgor
rem ----------------------------------------------------------------------
rem define variables
dim document   as object
dim Doc as object
dim dispatcher as object
dim oSheet as object
	Dim nFileHandle, nstr,nstolb As Integer
    Dim sRes As String 
    Dim sFinal, FileName, mypath As String
    

rem ----------------------------------------------------------------------
rem get access to the document
document   = ThisComponent.CurrentController.Frame
dispatcher = createUnoService("com.sun.star.frame.DispatchHelper")
Doc = StarDesktop.CurrentComponent
oSheet = ThisComponent.Sheets.getByIndex(0)

rem ----------------------------------------------------------------------
nFileHandle = FreeFile
    mypath = CurDir
    FileName = Dir("otspgor.txt")
    If FileName = "" Then
        If Dir("C:\Srodnik\otspgor.txt") = "" Then
            MsgBox "Файл не найден!"
            Exit Sub
        Else
            FileName = "C:\Srodnik\otspgor.txt"
        End If
    End If
    Open FileName For Input As #nFileHandle
    nstr = 7
    nstolb = 0
    dim args1(0) as new com.sun.star.beans.PropertyValue
    dim args3(0) as new com.sun.star.beans.PropertyValue
	args3(0).Name = "WrapText"
	dim args4(2) as new com.sun.star.beans.PropertyValue			
   	dim args5(0) as new com.sun.star.beans.PropertyValue
	args5(0).Name = "ToPoint"
	rem ----------------------------------------------------------------------
	dim args6(0) as new com.sun.star.beans.PropertyValue
	args6(0).Name = "StringName"

    Do While Not EOF(nFileHandle)
        Line Input #nFileHandle, sFinal
        'Get #nFileHandle, , sRes
         if Mid(sFinal,1,InStr(sFinal,":")) = "Специалист по социальной работе:" Then
        	args5(0).Value = "$B$2"
			dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
			args6(0).Value = sFinal
			dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
       	end if
       	if Mid(sFinal,1,InStr(sFinal,":")) = "Категория:" Then
       		args5(0).Value = "$B$3"
			dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
			args6(0).Value = sFinal
			dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
       	end if
       	if Mid(sFinal,1,InStr(sFinal,":")) = "Период с:" Then
       		args5(0).Value = "$B$4"
			dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
			args6(0).Value = sFinal
			dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
       	end if
       	if Mid(sFinal,1,InStr(sFinal,":")) = "Отчет сформирован:" Then
        	oSheet.getCellByPosition(10,3).String = sFinal
       	end if
        If sFinal = "%ТАБЛИЦА" Then
        	nstr = nstr + 1
            sFinal = ""
            nstolb = 0
			args5(0).Value = "$AC$"+nstr
			dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
			args6(0).Value = "=SUM(C"+nstr+":AB"+nstr+")"
			dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
        Else
        	sRes = Mid(sFinal,InStr(sFinal,":")+1)
        '	MsgBox sFinal
        	If nstolb > 1 Then
        		if sRes <> " " Then
     				oSheet.getCellByPosition(nstolb,nstr).Value = sRes
     			end if
     		else	
     			oSheet.getCellByPosition(nstolb,nstr).String = sRes

     		end if
     		nstolb = nstolb + 1
        End If
    Loop
Close  #nFileHandle
'dim args1(0) as new com.sun.star.beans.PropertyValue
args1(0).Name = "ToPoint"
args1(0).Value = "A8:AC"+nstr

dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args1())

rem ----------------------------------------------------------------------
dim args2(12) as new com.sun.star.beans.PropertyValue
args2(0).Name = "OuterBorder.LeftBorder"
args2(0).Value = Array(0,0,5,0)
args2(1).Name = "OuterBorder.LeftDistance"
args2(1).Value = 0
args2(2).Name = "OuterBorder.RightBorder"
args2(2).Value = Array(0,0,5,0)
args2(3).Name = "OuterBorder.RightDistance"
args2(3).Value = 0
args2(4).Name = "OuterBorder.TopBorder"
args2(4).Value = Array(0,0,5,0)
args2(5).Name = "OuterBorder.TopDistance"
args2(5).Value = 0
args2(6).Name = "OuterBorder.BottomBorder"
args2(6).Value = Array(0,0,5,0)
args2(7).Name = "OuterBorder.BottomDistance"
args2(7).Value = 0
args2(8).Name = "InnerBorder.Horizontal"
args2(8).Value = Array(0,0,5,0)
args2(9).Name = "InnerBorder.Vertical"
args2(9).Value = Array(0,0,5,0)
args2(10).Name = "InnerBorder.Flags"
args2(10).Value = 0
args2(11).Name = "InnerBorder.ValidFlags"
args2(11).Value = 127
args2(12).Name = "InnerBorder.DefaultDistance"
args2(12).Value = 0

dispatcher.executeDispatch(document, ".uno:SetBorderStyle", "", 0, args2())

args1(0).Name = "ToPoint"
args1(0).Value = "B8:B"+nstr

dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args1())
args3(0).Value = true
dispatcher.executeDispatch(document, ".uno:WrapText", "", 0, args3())
'args1(0).Name = "AlignmentHyphenation"
'args1(0).Value = true
'dispatcher.executeDispatch(document, ".uno:AlignmentHyphenation", "", 0, args1())
args4(0).Name = "FontHeight.Height"
args4(0).Value = 8
args4(1).Name = "FontHeight.Prop"
args4(1).Value = 100
args4(2).Name = "FontHeight.Diff"
args4(2).Value = 0
dispatcher.executeDispatch(document, ".uno:FontHeight", "", 0, args4())

oSheet.getCellByPosition(0,nstr).String = " "
oSheet.getCellByPosition(1,nstr).String = "Итого услуг:"
oSheet.getCellByPosition(1,nstr+1).String = "Итого посетителей:"

'for nstolb = 2 to 28
args5(0).Value = "$C$"+(nstr+1)
dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
args6(0).Value = "=SUM(C8:C"+nstr+")"
dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
args5(0).Value = "$D$"+(nstr+1)
dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
args6(0).Value = "=SUM(D8:D"+nstr+")"
dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
args5(0).Value = "$E$"+(nstr+1)
dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
args6(0).Value = "=SUM(E8:E"+nstr+")"
dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
args5(0).Value = "$F$"+(nstr+1)
dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
args6(0).Value = "=SUM(F8:F"+nstr+")"
dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
args5(0).Value = "$G$"+(nstr+1)
dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
args6(0).Value = "=SUM(G8:G"+nstr+")"
dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
args5(0).Value = "$H$"+(nstr+1)
dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
args6(0).Value = "=SUM(H8:H"+nstr+")"
dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
args5(0).Value = "$I$"+(nstr+1)
dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
args6(0).Value = "=SUM(I8:I"+nstr+")"
dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
args5(0).Value = "$J$"+(nstr+1)
dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
args6(0).Value = "=SUM(J8:J"+nstr+")"
dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
args5(0).Value = "$K$"+(nstr+1)
dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
args6(0).Value = "=SUM(K8:K"+nstr+")"
dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
args5(0).Value = "$L$"+(nstr+1)
dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
args6(0).Value = "=SUM(L8:L"+nstr+")"
dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
args5(0).Value = "$M$"+(nstr+1)
dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
args6(0).Value = "=SUM(M8:M"+nstr+")"
dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
args5(0).Value = "$N$"+(nstr+1)
dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
args6(0).Value = "=SUM(N8:N"+nstr+")"
dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
args5(0).Value = "$O$"+(nstr+1)
dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
args6(0).Value = "=SUM(O8:O"+nstr+")"
dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
args5(0).Value = "$P$"+(nstr+1)
dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
args6(0).Value = "=SUM(P8:P"+nstr+")"
dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
args5(0).Value = "$Q$"+(nstr+1)
dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
args6(0).Value = "=SUM(Q8:Q"+nstr+")"
dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
args5(0).Value = "$R$"+(nstr+1)
dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
args6(0).Value = "=SUM(R8:R"+nstr+")"
dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
args5(0).Value = "$S$"+(nstr+1)
dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
args6(0).Value = "=SUM(S8:S"+nstr+")"
dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
args5(0).Value = "$T$"+(nstr+1)
dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
args6(0).Value = "=SUM(T8:T"+nstr+")"
dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
args5(0).Value = "$U$"+(nstr+1)
dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
args6(0).Value = "=SUM(U8:U"+nstr+")"
dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
args5(0).Value = "$V$"+(nstr+1)
dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
args6(0).Value = "=SUM(V8:V"+nstr+")"
dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
args5(0).Value = "$W$"+(nstr+1)
dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
args6(0).Value = "=SUM(W8:W"+nstr+")"
dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
args5(0).Value = "$X$"+(nstr+1)
dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
args6(0).Value = "=SUM(X8:X"+nstr+")"
dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
args5(0).Value = "$Y$"+(nstr+1)
dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
args6(0).Value = "=SUM(Y8:Y"+nstr+")"
dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
args5(0).Value = "$Z$"+(nstr+1)
dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
args6(0).Value = "=SUM(Z8:Z"+nstr+")"
dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
args5(0).Value = "$AA$"+(nstr+1)
dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
args6(0).Value = "=SUM(AA8:AA"+nstr+")"
dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
args5(0).Value = "$AB$"+(nstr+1)
dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
args6(0).Value = "=SUM(AB8:AB"+nstr+")"
dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
args5(0).Value = "$AC$"+(nstr+1)
dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
args6(0).Value = "=SUM(AC8:AC"+nstr+")"
dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
args5(0).Value = "$C$"+(nstr+2)
dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
args6(0).Value = "=COUNT(C8:C"+nstr+")"
dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
args5(0).Value = "$D$"+(nstr+2)
dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
args6(0).Value = "=COUNT(D8:D"+nstr+")"
dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
args5(0).Value = "$E$"+(nstr+2)
dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
args6(0).Value = "=COUNT(E8:E"+nstr+")"
dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
args5(0).Value = "$F$"+(nstr+2)
dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
args6(0).Value = "=COUNT(F8:F"+nstr+")"
dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
args5(0).Value = "$G$"+(nstr+2)
dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
args6(0).Value = "=COUNT(G8:G"+nstr+")"
dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
args5(0).Value = "$H$"+(nstr+2)
dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
args6(0).Value = "=COUNT(H8:H"+nstr+")"
dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
args5(0).Value = "$I$"+(nstr+2)
dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
args6(0).Value = "=COUNT(I8:I"+nstr+")"
dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
args5(0).Value = "$J$"+(nstr+2)
dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
args6(0).Value = "=COUNT(J8:J"+nstr+")"
dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
args5(0).Value = "$K$"+(nstr+2)
dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
args6(0).Value = "=COUNT(K8:K"+nstr+")"
dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
args5(0).Value = "$L$"+(nstr+2)
dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
args6(0).Value = "=COUNT(L8:L"+nstr+")"
dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
args5(0).Value = "$M$"+(nstr+2)
dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
args6(0).Value = "=COUNT(M8:M"+nstr+")"
dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
args5(0).Value = "$N$"+(nstr+2)
dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
args6(0).Value = "=COUNT(N8:N"+nstr+")"
dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
args5(0).Value = "$O$"+(nstr+2)
dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
args6(0).Value = "=COUNT(O8:O"+nstr+")"
dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
args5(0).Value = "$P$"+(nstr+2)
dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
args6(0).Value = "=COUNT(P8:P"+nstr+")"
dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
args5(0).Value = "$Q$"+(nstr+2)
dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
args6(0).Value = "=COUNT(Q8:Q"+nstr+")"
dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
args5(0).Value = "$R$"+(nstr+2)
dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
args6(0).Value = "=COUNT(R8:R"+nstr+")"
dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
args5(0).Value = "$S$"+(nstr+2)
dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
args6(0).Value = "=COUNT(S8:S"+nstr+")"
dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
args5(0).Value = "$T$"+(nstr+2)
dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
args6(0).Value = "=COUNT(T8:T"+nstr+")"
dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
args5(0).Value = "$U$"+(nstr+2)
dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
args6(0).Value = "=COUNT(U8:U"+nstr+")"
dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
args5(0).Value = "$V$"+(nstr+2)
dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
args6(0).Value = "=COUNT(V8:V"+nstr+")"
dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
args5(0).Value = "$W$"+(nstr+2)
dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
args6(0).Value = "=COUNT(W8:W"+nstr+")"
dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
args5(0).Value = "$X$"+(nstr+2)
dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
args6(0).Value = "=COUNT(X8:X"+nstr+")"
dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
args5(0).Value = "$Y$"+(nstr+2)
dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
args6(0).Value = "=COUNT(Y8:Y"+nstr+")"
dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
args5(0).Value = "$Z$"+(nstr+2)
dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
args6(0).Value = "=COUNT(Z8:Z"+nstr+")"
dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
args5(0).Value = "$AA$"+(nstr+2)
dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
args6(0).Value = "=COUNT(AA8:AA"+nstr+")"
dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
args5(0).Value = "$AB$"+(nstr+2)
dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
args6(0).Value = "=COUNT(AB8:AB"+nstr+")"
dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())
args5(0).Value = "$AC$"+(nstr+2)
dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args5())
args6(0).Value = "=COUNT(AC8:AC"+nstr+")"
dispatcher.executeDispatch(document, ".uno:EnterString", "", 0, args6())

args1(0).Name = "ToPoint"
args1(0).Value = "A1"

dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args1()

end sub


