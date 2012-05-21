#SingleInstance force
#NoTrayIcon

IniRead, dragkey, config.ini, pass, dragkey
IniRead, base, config.ini, offsets, base
IniRead, windowxoffset, config.ini, offsets, windowx
IniRead, windowyoffset, config.ini, offsets, windowy
IniRead, mousexoffset, config.ini, offsets, mousex
IniRead, mouseyoffset, config.ini, offsets, mousey
IniRead, zleveloffset, config.ini, offsets, zlevel
IniRead, flagvar, config.ini, pass, flagvar

dragkey := RegExReplace(dragkey, "i)[^0-9a-z]", "")

windowx := ReadMemory(base+windowxoffset,"Dwarf Fortress")
windowy := ReadMemory(base+windowyoffset,"Dwarf Fortress")
start_mousex := ReadMemory(base+mousexoffset,"Dwarf Fortress")
start_mousey := ReadMemory(base+mouseyoffset,"Dwarf Fortress")
start_mousex := ((start_mousex + windowx) - 1)
start_mousey := ((start_mousey + windowy) - 1)
start_zlevel := ReadMemory(base+zleveloffset,"Dwarf Fortress")

if (flagvar = "h")
{
	state := "D"
	while (state = "D")
	{
		if (WinActive("Dwarf Fortress") and WinActive("ahk_class SDL_app"))
		{
			GetKeyState, state, %dragkey%, P
			windowx := ReadMemory(base+windowxoffset,"Dwarf Fortress")
			windowy := ReadMemory(base+windowyoffset,"Dwarf Fortress")
			mousex := ReadMemory(base+mousexoffset,"Dwarf Fortress")
			mousey := ReadMemory(base+mouseyoffset,"Dwarf Fortress")
			zlevel := ReadMemory(base+zleveloffset,"Dwarf Fortress")
			mousex := ((mousex + windowx) - 1)
			mousey := ((mousey + windowy) - 1)
			if (mousex > start_mousex)
				ew := " East"
			if (mousex < start_mousex)
				ew := " West"
			if (mousex = start_mousex)
				ew := " Same"
			if (mousey > start_mousey)
				ns := " South"
			if (mousey < start_mousey)
				ns := " North"
			if (mousey = start_mousey)
				ns := " Same"
			if (zlevel > start_zlevel)
				ud := " Up"
			if (zlevel < start_zlevel)
				ud := " Down"
			if (zlevel = start_zlevel)
				ud := " Same"
			ToolTip, % "EW: " . (abs(mousex - start_mousex) + 1) . ew . "`n" . "NS: " . (abs(mousey - start_mousey) + 1) . ns . "`n" . "UD: " . (abs(zlevel - start_zlevel) + 1) . ud
			Sleep 25
		}
	}
	ToolTip
	ExitApp
}
if (flagvar = "t")
{
	IniRead, on, config.ini, pass, ruleon
	while (on = "1")
	{
		if (WinActive("Dwarf Fortress") and WinActive("ahk_class SDL_app"))
		{
			IniRead, on, config.ini, pass, ruleon
			windowx := ReadMemory(base+windowxoffset,"Dwarf Fortress")
			windowy := ReadMemory(base+windowyoffset,"Dwarf Fortress")
			mousex := ReadMemory(base+mousexoffset,"Dwarf Fortress")
			mousey := ReadMemory(base+mouseyoffset,"Dwarf Fortress")
			zlevel := ReadMemory(base+zleveloffset,"Dwarf Fortress")
			mousex := ((mousex + windowx) - 1)
			mousey := ((mousey + windowy) - 1)
			if (mousex > start_mousex)
				ew := " East"
			if (mousex < start_mousex)
				ew := " West"
			if (mousex = start_mousex)
				ew := ""
			if (mousey > start_mousey)
				ns := " South"
			if (mousey < start_mousey)
				ns := " North"
			if (mousey = start_mousey)
				ns := ""
			if (zlevel > start_zlevel)
				ud := " Up"
			if (zlevel < start_zlevel)
				ud := " Down"
			if (zlevel = start_zlevel)
				ud := ""
			ToolTip, % "E/W: " . (abs(mousex - start_mousex) + 1) . ew . "`n" . "N/S: " . (abs(mousey - start_mousey) + 1) . ns . "`n" . "U/D: " . (abs(zlevel - start_zlevel) + 1) . ud
			Sleep 25
		}
	}
	ToolTip
	ExitApp
}

ReadMemory(MADDRESS,PROGRAM)
{
winget, pid, PID, %PROGRAM%
VarSetCapacity(MVALUE,4,0)
ProcessHandle := DllCall("OpenProcess", "Int", 24, "Char", 0, "UInt", pid, "UInt")
DllCall("ReadProcessMemory","UInt",ProcessHandle,"UInt",MADDRESS,"Str",MVALUE,"UInt",4,"UInt *",0)
Loop 4
result += *(&MVALUE + A_Index-1) << 8*(A_Index-1)
return, result 
}