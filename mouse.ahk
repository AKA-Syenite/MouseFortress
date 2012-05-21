#Persistent
#SingleInstance force
SetKeyDelay, 0, 5
#IfWinActive ahk_class SDL_app
SetTitleMatchMode, 2
DetectHiddenWindows, On

IniRead, menu, config.ini, keys, menu, RButton
IniRead, base, config.ini, offsets, base
IniRead, sidemenutypeoffset, config.ini, offsets, sidemenutype 
IniRead, menucount, config.ini, pass, menucount
IniRead, keycount, config.ini, pass, keycount
IniRead, pauseoffset, config.ini, offsets, pause
IniRead, version, config.ini, settings, version
IniRead, dfversion, config.ini, settings, dfversion
IniRead, menus, config.ini, settings, menus
IniRead, keys, config.ini, settings, keys

Menu, tray, tip, Mouse Fortress v%version% for %dfversion%`n%menus%: %menucount% menus loaded.`n%keys%: %keycount% keys loaded.

activatemenus()
activatekeys()
Run cursor.exe
Traytip,, Initialization Complete!`n%menucount% menus and %keycount% keys loaded!

gomenu(code)
{
	Loop 5
	{
		SendInput {Escape}
		Sleep 10
	}
SendInput, {Enter}
Sleep 20
SendInput, %code%
}

flagexec(flags)
{
global base, sidemenutypeoffset, pauseoffset, fullscreen
full := flags
Loop, parse, flags, `,
{
	flag := RegExReplace(A_LoopField, "\(.+\)", "")
	if (flag = "t")
	{
		side := ReadMemory(base+sidemenutypeoffset,"Dwarf Fortress")
		if (side <> 0)
		{
			SendInput, %A_ThisHotkey%
			Exit
		}
	}
	if (flag = "m")
		Menu, context, show
	if (flag = "pan")
	{
		IniWrite, %A_ThisHotkey%, config.ini, pass, dragkey
		Run pan.exe
	}
	if (flag = "s")
		ExitApp
	if (flag = "l")
		Run launch.exe
	if (flag = "p")
	{
		pause := ReadMemory(base+pauseoffset,"Dwarf Fortress")
		throw := RegExMatch(full, "p\(.*?\)", match)
		match := RegExReplace(match, "p\(|\)", "")
		if (match = "p")
			WriteMemory(16777216,base+pauseoffset,"Dwarf Fortress")
		if (match = "u")
			WriteMemory(0,base+pauseoffset,"Dwarf Fortress")
		if (match = "g")
		{
			if (pause = "0")
				WriteMemory(16777216,base+pauseoffset,"Dwarf Fortress")
			else
				WriteMemory(0,base+pauseoffset,"Dwarf Fortress")
		}
	}
	if (flag = "g")
	{
		throw := RegExMatch(full, "g\(.*?\)", match)
		match := RegExReplace(match, "g\(|\)", "")
		gomenu(match)
	}
	if (flag = "k")
	{
		throw := RegExMatch(full, "k\(.*?\)", match)
		match := RegExReplace(match, "k\(|\)", "")
		SendInput, %match%
	}
	if (flag = "a")
	{
		throw := RegExMatch(full, "a\(.*?\)", match)
		match := RegExReplace(match, "a\(|\)", "")
		WinRestore, Dwarf Fortress.exe
		ControlSend,, %match%{Enter}, Dwarf Fortress.exe
	}
	if (flag = "r")
	{
		throw := RegExMatch(full, "r\(.*?\)", match)
		match := RegExReplace(match, "r\(|\)", "")
		Run, %match%
	}
	if (flag = "q")
	{
		IniRead, cursoron, config.ini, pass, cursoron
		if (cursoron = "1")
		{
			IniWrite, 0, config.ini, pass, cursoron
			WinClose, cursor.exe
			Traytip,, Tracking Disabled!
		}
		else
		{
			IniWrite, 1, config.ini, pass, cursoron
			Run, cursor.exe
			Traytip,, Tracking Enabled!
		}
	}
	if (flag = "dc")
	{
		if not (A_PriorHotKey = A_ThisHotKey and A_TimeSincePriorHotkey < 500)
		{
			Exit
		}
	}
	if (flag = "d")
	{
		IniWrite, %A_ThisHotkey%, config.ini, pass, dragkey
		Run drag.exe
	}
	if (flag = "ru")
	{
		throw := RegExMatch(full, "ru\(.*?\)", match)
		match := RegExReplace(match, "ru\(|\)", "")
		if (match = "h")
		{
			IniWrite, %match%, config.ini, pass, flagvar
			IniWrite, %A_ThisHotkey%, config.ini, pass, dragkey
			Run rule.exe
		}
		IniRead, ruleon, config.ini, pass, ruleon
		if ((match = "t") and (ruleon = "0"))
		{
			IniWrite, %match%, config.ini, pass, flagvar
			IniWrite, 1, config.ini, pass, ruleon
			Run rule.exe
		}
		if ((match = "t") and (ruleon = "1"))
		{
			WinClose, rule.exe
			IniWrite, 0, config.ini, pass, ruleon
		}
	}
	if (flag = "e")
	{
		Loop 5
		{
			SendInput {Escape}
			Sleep 10
		}
		SendInput, {Enter}	
	}
	if (flag = "lm")
	{
		throw := RegExMatch(full, "lm\(.*?\)", match)
		match := RegExReplace(match, "lm\(|\)", "")
		IniWrite, %match%, config.ini, settings, menus
		Run launch.exe
	}
	if (flag = "lk")
	{
		throw := RegExMatch(full, "lk\(.*?\)", match)
		match := RegExReplace(match, "lk\(|\)", "")
		IniWrite, %match%, config.ini, settings, keys
		Run launch.exe
	}
}
}

activatemenus()
{
global menus
Traytip,, Activating Menus...
Loop, Read, %A_ScriptDir%\menus\%menus%.txt
{
	Loop, parse, A_LoopReadLine,|
	{
		if A_Index = 1
		{
			menuname := RegExReplace(A_LoopField, "i)[^0-9a-z]", "")
			%menuname%count := 0
		}
	}
}
Loop, Read, %A_ScriptDir%\menus\%menus%.txt
{
	multi := 0
	parent := "context"
	Loop, parse, A_LoopReadLine,|
	{
		if A_Index = 1
		{
			name := A_Loopfield
			menuname := RegExReplace(A_LoopField, "i)[^0-9a-z]", "")
			Loop, Read, %A_ScriptDir%\menus\%menus%.txt
			{
				Loop, parse, A_LoopReadLine,|
				{
					if A_Index = 1
					{
						testmenuname := RegExReplace(A_LoopField, "i)[^0-9a-z]", "")
						if (menuname = testmenuname)
							multi++
					}
				}
			}
		}
		if A_Index = 2
		{
			parent := RegExReplace(A_LoopField, "i)[^0-9a-z]", "")
			if (parent = "")
				parent := "context"
		}
	}
	if (multi > 1)
	{
		%menuname%count := %menuname%count + 1
		if (%menuname%count > 1)
			menuname .= (%menuname%count - 1)
	}
	if (name <> "")
	{
		menu, %parent%, add, %name%, %menuname%
		if (menuname = lastparent)
			menu, %parent%, add, %name%, :%menuname%
	}
	else if (name = "")
		menu, %parent%, add
	lastparent := parent
	parent := ""
}
Traytip,, Menus Activated!
}

activatekeys()
{
global keys
count := 1
Traytip,, Activating Keys...
Loop, read, %A_ScriptDir%\keys\%keys%.txt
{
	Loop, parse, A_LoopReadLine,|
	{
		if A_Index = 1
		{
			Hotkey, %A_LoopField%, Key%count%
			count++
		}
	}
}
Traytip,, Keys Activated!
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

WriteMemory(WVALUE,MADDRESS,PROGRAM)
{
winget, pid, PID, %PROGRAM%
ProcessHandle := DllCall("OpenProcess", "int", 2035711, "char", 0, "UInt", PID, "UInt")
DllCall("WriteProcessMemory", "UInt", ProcessHandle, "UInt", MADDRESS, "Uint*", WVALUE, "Uint", 4, "Uint *", 0)
DllCall("CloseHandle", "int", ProcessHandle)
return
}

Exit

#Include menus.ahk
#Include keys.ahk