#SingleInstance force
#NoTrayIcon

IniRead, dragkey, config.ini, pass, dragkey
IniRead, base, config.ini, offsets, base
IniRead, cursorxoffset, config.ini, offsets, cursorx
IniRead, cursoryoffset, config.ini, offsets, cursory
IniRead, windowxoffset, config.ini, offsets, windowx
IniRead, windowyoffset, config.ini, offsets, windowy
IniRead, mousexoffset, config.ini, offsets, mousex
IniRead, mouseyoffset, config.ini, offsets, mousey
IniRead, windowsizexoffset, config.ini, offsets, windowsizex
IniRead, windowsizeyoffset, config.ini, offsets, windowsizey
IniRead, mapsizexoffset, config.ini, offsets, mapsizex
IniRead, mapsizeyoffset, config.ini, offsets, mapsizey

dragkey := RegExReplace(dragkey, "i)[^0-9a-z]", "")

windowx := ReadMemory(base+windowxoffset,"Dwarf Fortress")
windowy := ReadMemory(base+windowyoffset,"Dwarf Fortress")
start_mousex := ReadMemory(base+mousexoffset,"Dwarf Fortress")
start_mousey := ReadMemory(base+mouseyoffset,"Dwarf Fortress")
start_mousex := ((start_mousex + windowx) - 1)
start_mousey := ((start_mousey + windowy) - 1)
mapsizex := ReadMemory(base+mapsizexoffset,"Dwarf Fortress")
mapsizey := ReadMemory(base+mapsizeyoffset,"Dwarf Fortress")

state := "D"
while (state = "D")
{
	if (WinActive("Dwarf Fortress") and WinActive("ahk_class SDL_app"))
	{
		GetKeyState, state, %dragkey%, P
		windowx := ReadMemory(base+windowxoffset,"Dwarf Fortress")
		if (windowx > 4000000000)
			WriteMemory("0",base+windowxoffset,"Dwarf Fortress")
		windowy := ReadMemory(base+windowyoffset,"Dwarf Fortress")
		if (windowy > 4000000000)
			WriteMemory("0",base+windowyoffset,"Dwarf Fortress")
		mousex := ReadMemory(base+mousexoffset,"Dwarf Fortress")
		mousey := ReadMemory(base+mouseyoffset,"Dwarf Fortress")
		windowsizex := ReadMemory(base+windowsizexoffset,"Dwarf Fortress")
		windowsizey := ReadMemory(base+windowsizeyoffset,"Dwarf Fortress")
		mousex := ((mousex + windowx) - 1)
		mousey := ((mousey + windowy) - 1)
		if ((mousex < 4000000000) and (mousey < 4000000000))
		{
			if (mousex <> start_mousex)
			{
				if ((mousex > start_mousex) and (windowx > 0))
				{
					windowx := windowx - (mousex - start_mousex)
					WriteMemory(windowx,base+windowxoffset,"Dwarf Fortress")
				}
				if ((mousex < start_mousex) and (windowx < (mapsizex - windowsizex + 32)))
				{
					windowx := windowx - (mousex - start_mousex)
					WriteMemory(windowx,base+windowxoffset,"Dwarf Fortress")				
				}
			}
			if (mousey <> start_mousey)
			{
				if ((mousey > start_mousey) and (windowy > 0))
				{
					windowy := windowy - (mousey - start_mousey)
					WriteMemory(windowy,base+windowyoffset,"Dwarf Fortress")
				}
				if ((mousey < start_mousey) and (windowy < (mapsizey - windowsizey + 1)))
				{
					windowy := windowy - (mousey - start_mousey)
					WriteMemory(windowy,base+windowyoffset,"Dwarf Fortress")				
				}
			}
		}
		
		Sleep 25
	}
}
ToolTip
ExitApp

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

WriteMemory(WVALUE,MADDRESS,PROGRAM)
{
winget, pid, PID, %PROGRAM%
ProcessHandle := DllCall("OpenProcess", "int", 2035711, "char", 0, "UInt", PID, "UInt")
DllCall("WriteProcessMemory", "UInt", ProcessHandle, "UInt", MADDRESS, "Uint*", WVALUE, "Uint", 4, "Uint *", 0)
DllCall("CloseHandle", "int", ProcessHandle)
return
}