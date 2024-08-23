#Requires AutoHotkey v2.0
#Include StatMain.ahk

DetectFocus() {
    GetRobloxClientPos()
    loop 10 {
        if (ImageSearch(&x, &y, windowX, windowY, windowWidth, windowY+200, "*50 " A_ScriptDir ".\Img\Focus_" A_Index ".png")=1) {
            FocusDetect.Text:="Focus - " A_Index "x"
            return A_Index 
		}
        }
}

DetectRedBoost() {
    GetRobloxClientPos()
    loop 10 {
        if (ImageSearch(&x, &y, windowX, windowY, windowWidth, windowY+200, "*50 " A_ScriptDir ".\Img\RedBoost_" A_Index ".png")=1) {
            RedDetect.Text:="Red Boost - " A_Index "x"
            return A_Index 
		}
        }
}

DetectPrecision() {
    GetRobloxClientPos()
    loop 10 {
        if (ImageSearch(&x, &y, windowX, windowY, windowWidth, windowY+200, "*50 " A_ScriptDir ".\Img\Precise_" A_Index ".png")=1) {
            PrecDetect.Text:="Precision - " A_Index "x"
            return A_Index 
		}
        }
}

DetectHaste() {
    GetRobloxClientPos()
    loop 10 {
        if (ImageSearch(&x, &y, windowX, windowY, windowWidth, windowY+200, "*50 " A_ScriptDir ".\Img\haste_" A_Index ".png")=1) {
            HasteDetect.Text:="Haste - " A_Index "x"
            return A_Index 
		}
        }
}

GetRobloxClientPos() {
    global windowX, windowY, windowWidth, windowHeight
    try WinGetClientPos(&windowX, &windowY, &windowWidth, &windowHeight, "Roblox ahk_exe RobloxPlayerBeta.exe") ; im assuming you're using web roblox
    catch
        return windowX:=windowY:=windowWidth:=windowHeight:=0
    return 1
}

BabyLoveDetect(){
GetRobloxClientPos()
if ImageSearch(&x, &y, 0, 0, A_ScreenWidth, 200, "*50 " A_ScriptDir ".\Img\BabyLove.png")
BabyLDetect.Text:="Baby Love - 1"
else
BabyLDetect.Text:="Baby Love - 0"
}

Melody1Detect(){
GetRobloxClientPos()
if ImageSearch(&x, &y, 0, 0, A_ScreenWidth, 200, "*50 " A_ScriptDir ".\Img\Melody.png")
MelodyDetect.Text:="Melody - 1"
else
MelodyDetect.Text:="Melody - 0"
}

RedBoost()
{
        DetectRedBoost()
	GetRobloxClientPos()
}

Precision()
{
        DetectPrecision()
	GetRobloxClientPos()
}

Haste()
{
        DetectHaste()
	GetRobloxClientPos()
}

Focus()
{
        DetectFocus()
	GetRobloxClientPos()
}
Melody()
{
Melody1Detect()
GetRobloxClientPos()
}

BabyLove()
{
BabyLoveDetect()
GetRobloxClientPos()
}