============
Introduction
============

Mouse Fortress provides a framework for defining and executing custom hotkeys (button presses and combinations)
and menus (in the style of a context menu). You can define multiple sets of menus and keys, and swap freely between
them, making it easy to have different loadouts for different playstyles, as well as for fortress or adventure mode.

.. contents::

======================
Getting Mouse Fortress
======================

The main development version is hosted on github_, both the source and binaries may be found at https://github.com/Shukaro/MouseFortress

.. _github: http://www.github.com/

Major releases may be downloaded from the following sources.

Github: https://github.com/Shukaro/MouseFortress/downloads
Bay12 Forums: http://www.bay12forums.com/smf/index.php?topic=102563.0

Releases and other important announcements will typically be posted in the Bay12 thread, but you can always
download the latest development version at https://github.com/Shukaro/MouseFortress

=============
Compatibility
=============

Currently, only Windows XP, Vista, and Windows 7 are supported. (Older versions may or may not work)
Linux and OSX aren't supported at the moment, but cross-platform support is planned. If you'd like to
run Mouse Fortress under Linux or OSX, it's possible under Wine/Bootcamp/whatever.

The SDL version should probably be used.

====================
Installation/Removal
====================

Installation for Mouse Fortress is quite simple:

 * Unzip the archive wherever you'd like
 * Replace the original Dwarf Fortress.exe with the included copy

If you would rather not use the included .exe, simply open the original .exe in any hex editor and modify the
value at 186 from 40 to 00. The included .exe is also large-address aware.

Uninstalling is fairly simple, just delete the mouse folder and either revert your changes to Dwarf Fortress.exe
or download a new copy.

====================
Using Mouse Fortress
====================

Mouse Fortress reads simple .txt files in order to set up the custom menus and hotkeys, and a few defaults have
been provided in the menus and keys folders. Each line must contain only one menu or key, and you can define any
number of them. Of course duplicate keys won't work in the same key file, and due to technical restraints duplicate
menu items won't work in the same menu.

To define a custom menu, follow this syntax:

Name|Parent|Flag,Another Flag,Yet Another Flag

With name being the displayed name of the menu, parent being the menu it's under (if any), if you'd like to
define the menu as a topmost menu, simply leave the parent field blank. Flags are defined in the final field,
and are comma-seperated. Note how each field is seperated by a |.

To define a custom hotkey, follow this syntax:

Key(s)|Flag,Another Flag,Yet Another Flag

With key(s) being the hotkey or hotkey combination you want to use to activate the hotkey.

http://www.autohotkey.com/docs/KeyList.htm and http://www.autohotkey.com/docs/Hotkeys.htm explain the different hotkey
possibilities that you can use in the key field.

======================
Feedback & Bug Reports
======================

If you've found a bug, or would like to give some feedback or suggestions, you can report it in the bay12 Mouse Fortress
forum thread, the project's issues page, or by contacting me (shukaro@gmail.com).

=============
The .ini file
=============

The config.ini contains all the offsets used by the utility as well as a variety of other settings.

=====
Flags
=====

Any options or additional parameters for a flag are defined in parenthesis () after the string, eg: p(g) or ru(h)
You can define as many flags as you'd like, and they will execute in the order in which they appear.

t
=
Only executes additional flags if the game is currently at the "main" fortress menu. This is somewhat deprecated and may
not work as expected. It will pass on the keypress if the check fails.

m
=
Opens the menu. By default bound to RButton.

pan
===
Allows you to pan the camera around by dragging the mouse, operating on a vector basis.

s
=
Quits Mouse Fortress.

l
=
Reloads the script. You need to do this whenever you make changes to your menus/keys.

p(p/u/g)
========
Pauses (p), unpauses (u), or toggles (g), the pause state of DF.

g()
===
Goes to the designated menu. Menus are defined by the key combination required to get to them. For example, build wall
is bCw.

k()
===
Sends the designated sequence of keys.

a()
===
Send the designated command to DFHack.

r()
===
Executes the designated file or program. If you don't give an absolute path, the script's directory will
be assumed.

q
=
Toggles cursor tracking on or off.

dc
==
Only executes additional flags if the key is double-pressed.

d
=
Allows you to drag the camera around with your mouse.

ru(h/t)
=======
Measures point-to-point distance on all 3 planes. Is active when held (h) or toggled (t).

e
=
Returns to the main menu.

lm()
====
Loads the designated menu file.

lk()
====
Loads the designated key file.

w()
===
Waits the specified number of milliseconds.