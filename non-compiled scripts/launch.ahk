FileDelete menus.ahk
FileDelete keys.ahk

count := 1
menucount := 0

TrayTip,, Building Menus...
Loop, Read, menus.txt
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
Loop, Read, menus.txt
{
	multi := 0
	Loop, parse, A_LoopReadLine,|
	{
		if A_Index = 1
		{
			menucount++
			menuname := RegExReplace(A_LoopField, "i)[^0-9a-z]", "")
			Loop, Read, menus.txt
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
		if A_Index = 3
			flags := A_LoopField
	}
	if (multi > 1)
	{
		%menuname%count := %menuname%count + 1
		if (%menuname%count > 1)
			menuname .= (%menuname%count - 1)
	}
	if (menuname <> "")
	{
		FileAppend,
		(
%menuname%:

		),menus.ahk
		if (flags <> "")
		{
			FileAppend,
			(
flagexec("%flags%")

			),menus.ahk
		}
		FileAppend,
		(
return


		),menus.ahk
	}
	menuname := ""
	flags := ""
}
Traytip,, Menus Built!

keycount := 0

Traytip,, Building Keys...
Loop, read, keys.txt
{
	Loop, parse, A_LoopReadLine,|
	{
		if A_Index = 1
		{
			keycount++
		}
		if A_Index = 2
			flags := A_LoopField
	}
	FileAppend,
	(
Key%keycount%:

	),keys.ahk
	if (flags <> "")
	{
		FileAppend,
		(
flagexec("%flags%")

		),keys.ahk
	}
	FileAppend,
	(
return


	),keys.ahk
	flags := ""
}
Traytip,, Keys Built!

IniWrite, %menucount%, config.ini, pass, menucount
IniWrite, %keycount%, config.ini, pass, keycount

Traytip,, Launching Script.
Run mouse.exe