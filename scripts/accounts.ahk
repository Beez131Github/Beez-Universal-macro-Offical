#Requires AutoHotkey v2.0
#SingleInstance Force

SetWorkingDir A_ScriptDir

KeyDelay := 40

Setkeydelay KeyDelay

CoordMode "Pixel", "Screen"
SendMode "Event"


#include %A_ScriptDir%\scripts\

#Include paths.ahk
#Include functions.ahk
#include joinserver.ahk
#Include webhook.ahk
#Include Boosting Assistance Macro.ahk
#Include MessageFunctions.ahk
#Include socket.ahk
#Include accounts.ahk
; #Include timers.ahk

#include %A_ScriptDir%\lib\

#Include FormData.ahk
#Include Gdip_All.ahk
#include Gdip_ImageSearch.ahk
#Include roblox.ahk
#Include walk.ahk


#Include %A_ScriptDir%\img\bitmaps.ahk

Tabs := MainGui.Add("Tab3", "x0 y10 w800 h350", ["Main", "Settings", "Accounts"])

Tabs.UseTab("Main")
; Add controls for the Main tab here

Tabs.UseTab("Settings")
; Add controls for the Settings tab here

Tabs.UseTab("Accounts")
; Add controls for the Accounts tab here
