#SingleInstance force
#NoTrayIcon

IniRead, dragkey, config.ini, pass, dragkey

dragkey := RegExReplace(dragkey, "i)[^0-9a-z]", "")

MouseGetPos, start_x, start_y
state := "D"
while (state = "D")
{
	ToolTip, O, (start_x - 10), (start_y - 10)
	if (WinActive("Dwarf Fortress") and WinActive("ahk_class SDL_app"))
	{
		GetKeyState, state, %dragkey%, P
		MouseGetPos, x, y
		distance := sqrt(abs(x - start_x)**2 + abs(y - start_y)**2)
		speed := 10 * (-(1/8) * distance) + 500
		if ((x > (start_x + 20)) and ((y < (start_y + 20)) and (y > (start_y - 20))))
			send {numpad6}
		else if ((x < (start_x - 20)) and ((y < (start_y + 20)) and (y > (start_y - 20))))
			send {numpad4}
		else if ((y < (start_y - 20)) and ((x < (start_x + 20)) and (x > (start_x - 20))))
			send {numpad8}
		else if ((y > (start_y + 20)) and ((x < (start_x + 20)) and (x > (start_x - 20))))
			send {numpad2}
		else if ((x > (start_x + 20)) and (y < (start_y - 20)))
			send {numpad9}
		else if ((x < (start_x - 20)) and (y < (start_y - 20)))
			send {numpad7}
		else if ((x > (start_x + 20)) and (y > (start_y + 20)))
			send {numpad3}
		else if ((x < (start_x - 20)) and (y > (start_y + 20)))
			send {numpad1}
		Sleep speed
	}
}
ToolTip
ExitApp