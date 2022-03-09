# Auto Hot Key

AutoHotkey doesn't do anything on its own; it needs a script to tell it what to do. A script is simply a plain text file with the .ahk filename extension containing instructions for the program, like a configuration file, but much more powerful. A script can do as little as performing a single action and then exiting, but most scripts define a number of hotkeys, with each hotkey followed by one or more actions to take when the hotkey is pressed.

## AutoHotkey Script Showcase

This showcase lists some scripts created by different authors which show what AutoHotkey might be capable of. For more ready-to-run scripts and functions, see Scripts and Functions Forum.

- [Screen Magnifier](https://www.autohotkey.com/docs/scripts/index.htm#Screen_Magnifier)
- [LiveWindows](https://www.autohotkey.com/docs/scripts/index.htm#LiveWindows)
- [Mouse Gestures](https://www.autohotkey.com/docs/scripts/index.htm#MouseGestures)
- [Context Sensitive Help in Any Editor](https://www.autohotkey.com/docs/scripts/index.htm#ContextSensitiveHelp)
- [Easy Window Dragging](https://www.autohotkey.com/docs/scripts/index.htm#EasyWindowDrag)
- [DE)">Easy Window Dragging (KDE style](https://www.autohotkey.com/docs/scripts/index.htm#EasyWindowDrag_)
- [Easy Access to Favorite Folders](https://www.autohotkey.com/docs/scripts/index.htm#FavoriteFolders)
- [IntelliSense](https://www.autohotkey.com/docs/scripts/index.htm#IntelliSense)
- [Using a Joystick as a Mouse](https://www.autohotkey.com/docs/scripts/index.htm#JoystickMouse)
- [Joystick Test Script](https://www.autohotkey.com/docs/scripts/index.htm#JoystickTest)
- [On-Screen ANSI Keyboard (OSAK](https://www.autohotkey.com/docs/scripts/index.htm#KeyboardOnScreen)
- [Minimize Window to Tray Menu](https://www.autohotkey.com/docs/scripts/index.htm#MinimizeToTrayMenu)
- [Changing MsgBox's Button Names](https://www.autohotkey.com/docs/scripts/index.htm#MsgBoxButtonNames)
- [Numpad 000 Key](https://www.autohotkey.com/docs/scripts/index.htm#Numpad000)
- [Using Keyboard Numpad as a Mouse](https://www.autohotkey.com/docs/scripts/index.htm#NumpadMouse)
- [earchTheStartMenu)">Seek (Search the Start Menu](https://www.autohotkey.com/docs/scripts/index.htm#Seek_)
- [ToolTip Mouse Menu](https://www.autohotkey.com/docs/scripts/index.htm#TooltipMouseMenu)
- [Volume On-Screen-Display (OSD](https://www.autohotkey.com/docs/scripts/index.htm#VolumeOSD)
- [Window Shading](https://www.autohotkey.com/docs/scripts/index.htm#WindowShading)
- [WinLIRC Client](https://www.autohotkey.com/docs/scripts/index.htm#WinLIRC)
- [HTML Entities Encoding](https://www.autohotkey.com/docs/scripts/index.htm#HTML_Entities_Encoding)
- [1 Hour Software](https://www.autohotkey.com/docs/scripts/index.htm#1_Hour_Software)
- [Toralf's Scripts](https://www.autohotkey.com/docs/scripts/index.htm#Toralf_s_Scripts)
- [Sean's Scripts](https://www.autohotkey.com/docs/scripts/index.htm#Sean_s_Scripts)
- [Archived Scripts and Functions Forum](https://www.autohotkey.com/docs/scripts/index.htm#Scripts_and_Functions_Forum)

## 1. Some of my own shortcuts

### 1.1 Keyboard shortcuts Matrix

```ahk
`hash`              #       Windows Key
`exclamation mark`  1       ALT
`caret`             ^       CTRL
`plus`              +       Shift
```

### 1.2 Run as Admin

Add the following to the top of your script to let it run in admin mode, so that it can support any apps

```ahk
if not A_IsAdmin
{
   Run, *RunAs %A_ScriptFullPath% ; Requires v1.0.92.01+
   ExitApp
}
```

## 2. Some Shortcut keys

### 2.1. Script to reload your scripts file

```ahk
^!ScrollLock::      ; CTRL + ALRT + Scroll Lock
Run, "C:\dev\autoHotKey\base.ahk"
Return
```


### 2.2. Auto Completing Passwords

```ahk
::pw::
SendInput *******
Return

::pwlo::
SendInput ********************
Return

::cof::
Send code-insiders -r 
Return
```

### 2.3 Open paths quickly in Windows

This will let you press CTRL + ALT + p (p for paths or whatever key you prefer).
Then releaseing all the keys and then pressing `a` to open `C:\Apps`, `d` to open `C:\Dev` etc
```ahk
!^p::      ; CTRL + ALT + p
input, command, L1
if command = a
Run, "C:\Apps"
if  command = d
Run, "C:\Dev"
if command = w
Run, "c:\laragon\www"
if command = o
Run, command = "c:\Users\charl\Downloads"
if command = s
Run, command = "c:\Software"
if command = h
Run, command = "c:\Windows\System32\drivers\etc"
if command = k
Run, command = "c:\dev\autoHotKey"
Return
```
