#SingleInstance force
DetectHiddenWindows, On
SetTitleMatchMode, 2
#NoTrayIcon

IniRead, base, config.ini, offsets, base
IniRead, cursorxoffset, config.ini, offsets, cursorx
IniRead, cursoryoffset, config.ini, offsets, cursory
IniRead, windowxoffset, config.ini, offsets, windowx
IniRead, windowyoffset, config.ini, offsets, windowy
IniRead, mousexoffset, config.ini, offsets, mousex
IniRead, mouseyoffset, config.ini, offsets, mousey
IniRead, sidemenutypeoffset, config.ini, offsets, sidemenutype 
IniRead, constructioncursoroffset, config.ini, offsets, constructioncursor
IniRead, cursoron, config.ini, pass, cursoron
IniRead, fullmenuoffset, config.ini, offsets, fullmenu

SetTimer, checkmouse, 1

Loop
{
    if (moved = "0")
        Continue
	IfWinNotExist, mouse.ahk
		ExitApp
	if (WinActive("Dwarf Fortress") and WinActive("ahk_class SDL_app"))
	{
		if (cursoron = "0")
			Continue
		cursorx := ReadMemory(base+cursorxoffset,"Dwarf Fortress")
		cursory := ReadMemory(base+cursoryoffset,"Dwarf Fortress")
		windowx := ReadMemory(base+windowxoffset,"Dwarf Fortress")
		windowy := ReadMemory(base+windowyoffset,"Dwarf Fortress")
		mousex := ReadMemory(base+mousexoffset,"Dwarf Fortress")
		mousey := ReadMemory(base+mouseyoffset,"Dwarf Fortress")
		sidemenutype := ReadMemory(base+sidemenutypeoffset,"Dwarf Fortress")
		constructioncursor := ReadMemory(base+constructioncursoroffset,"Dwarf Fortress")
		fullmenu := ReadMemory(base+fullmenuoffset,"Dwarf Fortress")
		mousex := ((mousex + windowx) - 1)
		mousey := ((mousey + windowy) - 1)
        if ((cursorx == mousex) and (cursory == mousey))
            moved := 0
		if ((cursorx > 4000000000) or ((sidemenutype = "16") and (constructioncursor > 4000000000)) or (fullmenu = "0") or (sidemenutype = "0"))
		{
			Sleep 5
			Continue
		}
		if ((cursorx < 4000000000) and (mousex < 4000000000))
		{
			if ((mousex > (cursorx + 10)) and (mousey = cursory))
				Send +{Right}
			if ((mousex < (cursorx - 10)) and (mousey = cursory))
				Send +{Left}
			if ((mousey > (cursory + 10)) and (mousex = cursorx))
				Send +{Down}
			if ((mousey < (cursory - 10)) and (mousex = cursorx))
				Send +{Up}
			if ((mousex > cursorx) and (mousey = cursory))
				Send {numpad6}
			if ((mousex < cursorx) and (mousey = cursory))
				Send {numpad4}
			if ((mousey < cursory) and (mousex = cursorx))
				Send {numpad8}
			if ((mousey > cursory) and (mousex = cursorx))
				Send {numpad2}
			if ((mousex > cursorx) and (mousey < cursory))
				Send {numpad9}
			if ((mousex < cursorx) and (mousey < cursory))
				Send {numpad7}
			if ((mousex > cursorx) and (mousey > cursory))
				Send {numpad3}
			if ((mousex < cursorx) and (mousey > cursory))
				Send {numpad1}
		}
	}
	else
		Sleep 1000
	Sleep 5
}

ReadMemory(MADDRESS,PROGRAM)
{
WinGetTitle, Title, A
if (Title = PROGRAM)
{
	winget, pid, PID, A
	VarSetCapacity(MVALUE,4,0)
	ProcessHandle := DllCall("OpenProcess", "Int", 24, "Char", 0, "UInt", pid, "UInt")
	DllCall("ReadProcessMemory","UInt",ProcessHandle,"UInt",MADDRESS,"Str",MVALUE,"UInt",4,"UInt *",0)
	Loop 4
	result += *(&MVALUE + A_Index-1) << 8*(A_Index-1)
} 
else
{
	result := 4294967295
}
return, result 
}

checkmouse:
MouseGetPos, xaa, yaa
Sleep 1
MouseGetPos, xbb, ybb
if ((xaa <> xbb) and (yaa <> ybb))
    moved := 1
Return