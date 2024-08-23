#MaxThreads 255
#Requires AutoHotkey v2.0
#SingleInstance Force
#Include StatsFunctions.ahk


CoordMode "Mouse", "Screen"
CoordMode "Pixel", "Screen"
SendMode "Event"


Gouiee:=Gui("+ToolWindow +AlwaysOnTop", "Img\PreciseIco.png")
RedDetect := Gouiee.Add("Text", "+BackgroundTrans", "Nothing Detected")
PrecDetect := Gouiee.Add("Text", "+BackgroundTrans", "Nothing Detected")
FocusDetect := Gouiee.Add("Text", "+BackgroundTrans", "Nothing Detected")
HasteDetect := Gouiee.Add("Text", "+BackgroundTrans", "Nothing Detected")
MelodyDetect := Gouiee.Add("Text", "+BackgroundTrans", "Nothing Detected")
BabyLDetect := Gouiee.Add("Text", "+BackgroundTrans", "Nothing Detected")
Gouiee.Show("w200 h170")

TraySetIcon("Img\PreciseIco.png")
Gui.BackColor := "afafaf"

windowX:=windowY:=windowWidth:=windowHeight:=0 


loop
{
RedBoost()
Precision()
Focus()
Haste()
BabyLove()
Melody()
}

