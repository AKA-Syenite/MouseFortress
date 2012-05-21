---Introduction---

Mouse Fortress is, at its core, a framework for creating custom menus and hotkeys which can do anything from
sending keys to moving the cursor dynamically. Menus.txt and Keys.txt are where all custom menus and keys are
defined. Config.ini is the script's settings file, and it's where anything user-configurable that isn't a
custom menu or hotkey is stored. Launch.exe is what you should run to launch (duh) the script, it sets up 
menus.ahk and keys.ahk. Mouse.ahk is the main script, and everything else is auxiliary.

---Installation---

Installation for Mouse Fortress is straightforward, and is as follows:

Unzip the mouse folder anywhere you'd like.
Replace the Dwarf Fortress.exe in your game folder with the included copy.
	Alternatively, use any hex editor to open your Dwarf Fortress.exe and modify the value at 186 
	from 40 to 00. This ensures that Dwarf Fortress will always start at the same base address in memory.
	The included .exe is Large-Address Aware, as well.
Run launch.exe.
By default, RButton opens the menu.

---Customization---

The real meat of Mouse Fortress is in its custom menus and hotkeys, which are defined in menus.txt and
keys.txt respectively.

A variety of keys and menus have been predefined in menus.txt and keys.txt, and examples.txt contains syntax explanations and examples for usage, so it's advisable to take a look through it before diving into
customization.

Support, further updates, and a changelog can be found in Mouse Fortress' forum thread here:
http://www.bay12forums.com/smf/index.php?topic=102563.0


