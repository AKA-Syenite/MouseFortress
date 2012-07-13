#SingleInstance force
DetectHiddenWindows, On
SetTitleMatchMode, 2
#NoTrayIcon
SetKeyDelay, 0

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
			xdistance := (mousex - cursorx)
            ydistance := (mousey - cursory)
            if (xdistance >= 10)
                Send +{Right}
            if (ydistance >= 10)
                Send +{Down}
            if (xdistance <= -10)
                Send +{Left}
            if (ydistance <= -10)
                Send +{Up}
            if ((0 < xdistance && xdistance < 10) and (0 < ydistance && ydistance < 10))
                Send {Numpad3}
            if ((-10 < xdistance && xdistance < 0) and (0 < ydistance && ydistance < 10))
                Send {Numpad1}
            if ((-10 < xdistance && xdistance < 0) and (-10 < ydistance && ydistance < 0))
                Send {Numpad7}
            if ((0 < xdistance && xdistance < 10) and (-10 < ydistance && ydistance < 0))
                Send {Numpad9}
            if ((0 < xdistance && xdistance < 10) and (ydistance == 0))
                Send {Right}
            if ((0 < ydistance && ydistance < 10) and (xdistance == 0))
                Send {Down}
            if ((-10 < xdistance && xdistance < 0) and (ydistance == 0))
                Send {Left}
            if ((-10 < ydistance && ydistance < 0) and (xdistance == 0))
                Send {Up}
		}
	}
	else
		Sleep 1000
	Sleep 1
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