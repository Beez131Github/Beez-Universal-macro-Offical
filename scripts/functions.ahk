
#Include paths.ahk

PictureImageSearch(ImagePath, Strength) {
    hwnd := GetRobloxHWND()
    GetRobloxClientPos(hwnd)
    SearchOptions := "*" Strength " " . ImagePath
    if ImageSearch(&FoundX, &FoundY, windowX, windowY, windowX + windowWidth, windowY + windowHeight, SearchOptions) {
        return 1
    } else {
        return 0
    }
}


PictureImageSearchItem(ImagePath, Strength) {
    hwnd := GetRobloxHWND()
    GetRobloxClientPos(hwnd)
    SearchOptions := "*" Strength " " . ImagePath
    if ImageSearch(&FoundX, &FoundY, windowX, windowY, windowX + windowWidth, windowY + windowHeight, SearchOptions) {
        MouseMove(FoundX, FoundY)  ; Move 10 pixels to the right
        return 1
    } else {
        return 0
    }
}

PictureImageSearchItemWithCoords(ImagePath, Strength, X1, Y1, X2, Y2) {
    hwnd := GetRobloxHWND()
    GetRobloxClientPos(hwnd)
    SearchOptions := "*" Strength " " . ImagePath

    if ImageSearch(&FoundX, &FoundY, windowX + X1, windowY + Y1, windowX + X2, windowY + Y2, SearchOptions) {
        MouseMove(FoundX, FoundY)
        return 1
    } else {
        return 0
    }
}



HyperSleep(ms)
{
    static freq := (DllCall("QueryPerformanceFrequency", "Int64*", &f := 0), f)
    DllCall("QueryPerformanceCounter", "Int64*", &begin := 0)
    current := 0, finish := begin + ms * freq / 1000
    while (current < finish)
    {
        if ((finish - current) > 30000)
        {
            DllCall("Winmm.dll\timeBeginPeriod", "UInt", 1)
            DllCall("Sleep", "UInt", 1)
            DllCall("Winmm.dll\timeEndPeriod", "UInt", 1)
        }
        DllCall("QueryPerformanceCounter", "Int64*", &current)
    }
}

MovespeedNoHaste(milliseconds) {

    Playerspeed := IniRead("settings.ini", "Settings", "movespeed")
    Basespeed := 33.35
    Setspeedtime := Basespeed / Playerspeed

    HyperSleep(milliseconds * Setspeedtime)
}

Movespeed(milliseconds, studs := 0) {
    IsHasteToggled := IniRead("settings.ini", "Settings", "IsHasteToggled", "0")

    if (IsHasteToggled = "0") {
        MovespeedNoHaste(milliseconds)
    } else {
        Walk(studs)
    }
}


global current_hive := 1
global KeyDelay

StartServer() {
    global KeyDelay
    global current_hive
    CloseQuest()
    ;send "{" RotRight " 1}"
    Movespeed(300)
    Send "{" WKey " down}"
    Send "{" DKey " down}"
    Movespeed(2300)
    Send "{" WKey " up}"
    Movespeed(500)
    Send "{" DKey " up}"
    Send "{" WKey " down}"
    ;send "{" RotLeft " 1}"
    Movespeed(1000)
    Send "{" WKey " up}"
    Send "{" DKey " down}"
    Movespeed(700)
    Send "{" DKey " up}"
    Send "{" AKey " down}"
    Send "{" SKey " down}"
    Movespeed(700)
    Send "{" AKey " up}"
    Send "{" SKey " up}"
    current_hive := FindHiveSlot()
    if (current_hive = 0) {
        PlayerStatus("Could Not Claim hive retrying..", 15277667, false)
        KeyDelay := 100
        SetKeyDelay 100
        send "{" EscKey "}{" Rkey "}{" EnterKey "}"
        SetKeyDelay KeyDelay
        HyperSleep(500)
        HealthDetection()
        ZoomOut()
        return 3
    }
    if (ResetMainCharacter() == false) {
        return 4
    }
}


StartServerLoop() {
    StartServerAttempts := 0
    ServerVar := StartServer()
    while (ServerVar == 3 || ServerVar == 4) {
        StartServerAttempts++
        if StartServerAttempts == 3 {
            PlayerStatus("leaving server could not claim hive current_hive = 0", 8359053, true)
            return 1
        }

        if ServerVar == 4 {
            PlayerStatus("leaving server reset count went over 4...", 8359053, true)
            return 1 
        }
        ServerVar := StartServer()
    }
    return current_hive
}

ZoomOut() {
    Send "{" ZoomOuter " 15}"
}


DetectLoading(loadingColor, timeout) {
    startTime := A_TickCount
    loop {
        color := PixelGetColor(458, 151)
        ActivateRoblox()
        if (color = loadingColor) {
            break ;; detected loading color
        }
        if (A_TickCount - startTime >= timeout) {
            try {
                PlayerStatus("Closing roblox place restricted error", 15548997, false)
                HWND := GetRobloxHWND()
                WinClose(HWND)
                WinClose(HWND)
            } catch Error as e {
                return false
            }
            return false ; Timeout reached for loading color. This means it was not on screen
        }
        Sleep(100)
    }


    loop {
        color := PixelGetColor(458, 151)
        if (color != loadingColor) {
            break ;; detected loading color going away
        }
        Sleep(100)
    }

    return true ; Loading succesfully managed
}


NightDetection() {
    hwnd := GetRobloxHWND()
    GetRobloxClientPos(hwnd)
    offsetY := GetYOffset()
    pBMScreen := Gdip_BitmapFromScreen(windowX + windowWidth // 2 - 200 "|" windowY + offsetY "|" 400 "|" windowHeight)

    if (Gdip_ImageSearch(pBMScreen, bitmaps["nightground"], , , , , , 6) = 1 || Gdip_ImageSearch(pBMScreen, bitmaps["nightground2"], , , , , , 6) = 1) {
        Gdip_DisposeImage(pBMScreen)
        return 1
    } else {
        Gdip_DisposeImage(pBMScreen)
        return 0
    }
}

CheckSpawnPos() {
    send "{" ZoomIn " 1}"
    hwnd := GetRobloxHWND()
    GetRobloxClientPos(hwnd)
    offsetY := GetYOffset()
    pBMScreen := Gdip_BitmapFromScreen(windowX "|" windowY + offsetY "|" windowWidth "|" windowHeight)
    if (Gdip_ImageSearch(pBMScreen, bitmaps["DayLeaderboard"], , , , , , 10) = 1 || Gdip_ImageSearch(pBMScreen, bitmaps["NightLeaderboard"], , , , , , 10) = 1) {
        PlayerStatus("Leaderboard Detected, Rotating..", 9807270, false)
        SetKeyDelay 100
        send "{" RotRight " 4}"
        Sleep(1000)
        send "{" ZoomOuter " 1}"
        SetKeyDelay KeyDelay
        return
    }

}

FindHiveSlot() {
    global current_hive
    Movespeed(300)
    ;Send "{" AKey " down}"
    ;Movespeed(500)
    ;Send "{" AKey " up}"
    ; Movespeed(1500)
    current_hive := 1
    if (ClaimHive(current_hive)) {
        return current_hive
    }
    Loop 5 {
        Send "{" AKey " down}"
        Movespeed(1045)
        Send "{" AKey " up}"
        Movespeed(1500)
        current_hive++
        if (ClaimHive(current_hive)) {
            return current_hive
        }
    }
    return 0
}

MoveRightByCurrentHive() {
    
    if (current_hive == 0) {
        ; Handle the error case
        MsgBox("Failed to get current hive. Aborting movement.")
        return
    }

    current_hive_travel := current_hive - 1

    Loop current_hive_travel {
        Send "{" AKey " down}"
        Movespeed(1045)
        Send "{" AKey " up}"
        HyperSleep(100)
    }
}

MoveLeftByCurrentHive() {
    
    if (current_hive == 0) {
        ; Handle the error case
        MsgBox("Failed to get current hive. Aborting movement.")
        return
    }

    current_hive_travel := current_hive - 1

    Loop current_hive_travel {
        Send "{" Dkey " down}"
        Movespeed(1045)
        Send "{" DKey " up}"
        HyperSleep(100)
    }
}

ClaimHive(current_hive) {

    GetBitmap() {
        hwnd := GetRobloxHWND()
        GetRobloxClientPos(hwnd)
        offsetY := GetYOffset()
        pBMScreen := Gdip_BitmapFromScreen(windowX + windowWidth // 2 - 200 "|" windowY + offsetY "|400|125")
        while ((A_Index <= 20) && (Gdip_ImageSearch(pBMScreen, bitmaps["FriendJoin"], , , , , , 6) = 1)) {
            Gdip_DisposeImage(pBMScreen)
            MouseMove windowX + windowWidth // 2 - 3, windowY + 24
            Click
            MouseMove windowX + 350, windowY + offsetY + 100
            Sleep 500
            pBMScreen := Gdip_BitmapFromScreen(windowX + windowWidth // 2 - 200 "|" windowY + offsetY "|400|125")
        }
        return pBMScreen
    }

    Sleep(500)
    pBMScreen := GetBitmap()
    if (Gdip_ImageSearch(pBMScreen, bitmaps["claimhive"], , , , , , 2, , 6) = 1) {
        Send "{" Ekey " down}"
        Sleep(200)
        Send "{" Ekey " up}"
        PlayerStatus("Claimed hiveslot " current_hive, 10181046, false)
        Gdip_DisposeImage(pBMScreen)
        return current_hive
    }
    Gdip_DisposeImage(pBMScreen)
}


ResetMainCharacter() {
    resetcharattempts := 0
    ResetVar := ResetCharacter()
    while (ResetVar == 2) {
        resetcharattempts++
        if resetcharattempts > 6 {
            PlayerStatus("Failed too many times going to cannon, leaving server...", 8359053, true)
            return false
        }
        ResetVar := ResetCharacter()
    }
    return true
}



ResetMainNonVicCharacter() {
    resetcharattempts := 0
    ResetVar := ResetNonVicCharacter()
    while (ResetVar == 2 && resetcharattempts < 3) {
        resetcharattempts++
        PlayerStatus("Attempt " . resetcharattempts . " to reset character...", 8359053, false)
        Sleep(1000)  ; Add a delay between attempts
        ResetVar := ResetNonVicCharacter()
    }
    if (resetcharattempts >= 3) {
        PlayerStatus("Failed to reset character after 3 attempts, leaving server...", 8359053, true)
        return false
    }
    return true
}



ResetNonVicCharacter() {
    CloseQuest()
    send "{" EscKey "}{" Rkey "}{" EnterKey "}"
    Sleep(500)
    HealthDetection()
    ZoomOut()
    
    ; Go directly to the cannon
    GoToRamp()
    ZoomOut()
    RedCannon()
    
    ; Check if at the hive
    if (CheckFireButton()) {
        return 1
    } else {
        return 2
    }
}


ResetCharacter() {
    CloseQuest()
    send "{" EscKey "}{" Rkey "}{" EnterKey "}"
    Sleep(500)
    HealthDetection()
    ZoomOut()
    CheckSpawnPos()
    Send "{" RotDown " 1}"
    if (CheckCocoSpawn() == 1) {
        Send "{" RotUp " 1}"
        FalseGoToRamp()
        RedCannon()
        if (CheckFireButton() == 0) {
            return 2
        }
        return 1
    } else {
        Send "{" RotUp " 1}"
        ZoomOut()
        HiveCorrection()
        GoToRamp()
        ZoomOut()
        RedCannon()
        if (CheckFireButton() == 0) {
            return 2
        }
    }
    return 1
}






HealthDetection() {
    while (PictureImageSearch("img\Health.png", 32)) {
        Sleep(100)
    }
    Sleep(500)
    return 1

}

CheckCocoSpawn() {
    HyperSleep(300)
    hwnd := GetRobloxHWND()
    GetRobloxClientPos(hwnd)
    offsetY := GetYOffset()
    pBMScreen := Gdip_BitmapFromScreen(windowX "|" windowY + offsetY "|" windowWidth "|" windowHeight)
    if (Gdip_ImageSearch(pBMScreen, bitmaps["NightCoconut"], , , , , , 10) = 1 || Gdip_ImageSearch(pBMScreen, bitmaps["DayCoconut"], , , , , , 10) = 1 || Gdip_ImageSearch(pBMScreen, bitmaps["DayCoconut2"], , , , , , 10) = 1 ) { ; || Gdip_ImageSearch(pBMScreen, bitmaps["NightCoconut2"], , , , , , 10) = 1
        Gdip_DisposeImage(pBMScreen)
        return 1
    }
    else {
        Gdip_DisposeImage(pBMScreen)
        return 0
    }
}


HiveCorrection() {
    hwnd := GetRobloxHWND()
    GetRobloxClientPos(hwnd)
    offsetY := GetYOffset()
    pBMScreen := Gdip_BitmapFromScreen(windowX + windowWidth // 2 - 200 "|" windowY + offsetY "|" 400 "|" windowHeight)

    if (Gdip_ImageSearch(pBMScreen, bitmaps["nightground"], , , , , , 6) = 1 || Gdip_ImageSearch(pBMScreen, bitmaps["nightground2"], , , , , , 6) = 1 || Gdip_ImageSearch(pBMScreen, bitmaps["ground"], , , , , , 6) = 1) {
        Gdip_DisposeImage(pBMScreen)
        return 1
    }
    else {
        Gdip_DisposeImage(pBMScreen)
        PlayerStatus("Ground Not Detected Rotating..", 9807270, false)
        SetKeyDelay 100
        send "{" RotLeft " 4}"
        Setkeydelay KeyDelay
        return 0
    }
}


GoToRamp() {
    global current_hive
    Movespeed(300)
    Send "{" Dkey " down}"
    Movespeed(1045 * current_hive)
    Send "{" Dkey " up}"
    Movespeed(500)
    Send "{" SpaceKey " down}"
    Send "{" Dkey " down}"
    Movespeed(100)
    Send "{" SpaceKey " up}"
    Movespeed(200)
    Send "{" Dkey " up}"
}

FalseGoToRamp() {
    Send "{" WKey " down}"
    Movespeed(1800)
    Send "{" WKey " up}"
    Send "{" Dkey " down}"
    Movespeed(3000)
    Send "{" Dkey " up}"
    Send "{" SpaceKey " down}"
    Send "{" Dkey " down}"
    Movespeed(100)
    Send "{" SpaceKey " up}"
    Movespeed(200)
    Send "{" Dkey " up}"
}

RedCannon() {
    Send "{" DKey " down}"
    Movespeed(400)
    Send "{" DKey " up}"
    Send "{" WKey " down}"
    Movespeed(400)
    Send "{" WKey " up}"
    Send "{" SpaceKey " down}"
    Send "{" Dkey " down}"
    Movespeed(600)
    Send "{" SpaceKey " up}"
    Send "{" Dkey " up}"

}

glider() {
    loop 2 {
        Send "{" SpaceKey " down}"
        HyperSleep(250)
        Send "{" SpaceKey " up}"
    }
}

sprinkler() {
    Send "{" OneKey " down}"
    HyperSleep(250)
    Send "{" OneKey " up}"
}

ViewRight() {
    Send "{" RotRight " down}"
    HyperSleep(50)
    Send "{" RotRight " up}"
    HyperSleep(50)
}

ViewLeft() {
    Send "{" RotLeft " down}"
    HyperSleep(50)
    Send "{" RotLeft " up}"
    HyperSleep(50)
}

WDkeyDown() {
    Send "{" WKey " down}"
    Send "{" DKey " down}"
}

WDkeyUp() {
    Send "{" WKey " up}"
    Send "{" DKey " up}"
}

SAkeyDown() {
    Send "{" SKey " down}"
    Send "{" AKey " down}"
}

SAkeyUp() {
    Send "{" SKey " up}"
    Send "{" AKey " up}"
}

SDkeyUp() {
    Send "{" SKey " up}"
    Send "{" DKey " up}"
}

SDkeyDown() {
    Send "{" SKey " down}"
    Send "{" DKey " down}"
}


CheckFireButton() {
    HyperSleep(400)
    hwnd := GetRobloxHWND()
    offsetY := GetYOffset(hwnd)
    pBMScreen := Gdip_BitmapFromScreen(windowX + windowWidth // 2 - 200 "|" windowY + offsetY "|400|125")
    if (Gdip_ImageSearch(pBMScreen, bitmaps["redcannon"], , , , , , 2, , 2) = 1) {
        Gdip_DisposeImage(pBMScreen)
        return 1
    }
    return 0
}

VicActivated() {

    Send "{" SlashKey "}" "{" EnterKey "}"
    Sleep(100)
    if PictureImageSearch("img\Warning.png", 32) {
        return 1
    }

    return 0
}

Dead := false

PepperAttackVic() {
    PlayerStatus("Starting Pepper Kill Cycle", 15105570, false)
    global Dead
    Dead := false

    StartTime := 0
    StartTime := A_TickCount
    while (!CheckIfDefeated()) {
        ElapsedTime := A_TickCount - StartTime
        if (ElapsedTime > 150000) { ;; 1 minute and 30 seconds to kill vic bee
            return 2
        }
        if (Dead == true) {
            return 3
        }

        Loop 2 {
            PlayerDied()
            Send "{" WKey " down}"
            Movespeed(400)
            PlayerDied()
            Send "{" WKey " up}"
            PlayerDied()
            Movespeed(500)
        }
        Loop 2 {
            PlayerDied()
            Send "{" AKey " down}"
            Movespeed(400)
            PlayerDied()
            Send "{" AKey " up}"
            Movespeed(500)
            PlayerDied()
        }
        Loop 2 {
            PlayerDied()
            Send "{" SKey " down}"
            Movespeed(400)
            PlayerDied()
            Send "{" SKey " up}"
            Movespeed(500)
            PlayerDied()
        }
        Loop 2 {
            PlayerDied()
            Send "{" Dkey " down}"
            Movespeed(400)
            PlayerDied()
            Send "{" Dkey " up}"
            Movespeed(500)
            PlayerDied()
        }
        PlayerStatus("Looped finished", 15105570, false)

    }
    Sleep(5000)
    PlayerStatus("Vicious bee has been defeated!", 7419530, true)
    
    return 2
}

MtnAttackVic() {
    PlayerStatus("Starting Mtn Kill Cycle", 11027200, false)
    StartTime := 0
    StartTime := A_TickCount

    global Dead
    Dead := false


    while (!CheckIfDefeated()) {
        ElapsedTime := A_TickCount - StartTime
        if (ElapsedTime > 150000) { ;; 2m 30s to kill vic bee
            break
        }
        if (Dead == true) {
            return 3
        }
        PlayerDied()
        Send "{" Dkey " down}"
        Movespeed(1500)
        Send "{" Dkey " up}"
        PlayerDied()
        loop 5 {
            PlayerDied()
            Send "{" SKey " down}"
            Movespeed(400)
            PlayerDied()
            Send "{" SKey " up}"
        }
        Send "{" AKey " down}"
        Movespeed(400)
        PlayerDied()
        Send "{" AKey " up}"
        PlayerDied()
        loop 5 {
            Send "{" WKey " down}"
            PlayerDied()
            Movespeed(400)
            Send "{" WKey " up}"
        }
        PlayerStatus("Looped finished", 11027200, false)

    }
    Sleep(5000)
    PlayerStatus("Vicious bee has been defeated!", 7419530, true)
    
    return 2
}

AttackVic() {
    PlayerStatus("Starting Vicious Kill Cycle", 15844367, false)
    StartTime := 0
    StartTime := A_TickCount

    global Dead
    Dead := false


    while (!CheckIfDefeated()) {
        ElapsedTime := A_TickCount - StartTime
        if (ElapsedTime > 120000) { ;; 1m 30s to kill vic bee
            break
        }
        if (Dead == true) {
            return 3
        }
        Loop 2 {
            PlayerDied()
            Send "{" WKey " down}"
            Movespeed(400)
            PlayerDied()
            Send "{" WKey " up}"
            Movespeed(500)
        }
        Loop 2 {
            PlayerDied()
            Send "{" AKey " down}"
            Movespeed(400)
            PlayerDied()
            Send "{" AKey " up}"
            Movespeed(500)
        }
        Loop 2 {
            PlayerDied()
            Send "{" SKey " down}"
            Movespeed(400)
            PlayerDied()
            Send "{" SKey " up}"
            Movespeed(500)
        }
        Loop 2 {
            PlayerDied()
            Send "{" Dkey " down}"
            Movespeed(400)
            PlayerDied()
            Send "{" Dkey " up}"
            Movespeed(500)
        }
        PlayerStatus("Looped finished", 15844367, false)
    }
    Sleep(5000)
    PlayerStatus("Vicious bee has been defeated!", 7419530, true)
    

    return 2
}

PlayerDied() {
    global Dead
    if PictureImageSearch("img\died.png", 32) {
        Dead := true
        PlayerStatus("Bro Died To vicious bee during battle... What an embarrassment", 2899536, false)
        return 1
    } else {
        return 0
    }
}


CheckIfDefeated() {
    if PictureImageSearch("img\defeated2.png", 32) {
        return 1
    } else {
        return 0
    }
}

UseFirstLoadFunctions() {
    if (IniRead("settings.ini", "Settings", "FirstLoad", 0) == 1) {
        SetGraphics()
        IniWrite(0, "settings.ini", "Settings", "FirstLoad")
    }
}

SetGraphics() {
    GraphicsSetting := IniRead("settings.ini", "Settings", "Graphics", "0")
    GraphicsSetting := GraphicsSetting - 1
    send "{" EscKey "}"
    HyperSleep(500)
    if PictureImageSearchItem("img\InvFriends.png", 32) {
        HyperSleep(500)
        MouseGetPos(&x, &y)
        MouseMove(x + 160, y - 100)
        HyperSleep(500)
        Click()
        HyperSleep(500)
        MouseGetPos(&x, &y)
        MouseMove(x - 160, y + 200)
        if PictureImageSearchItem("img\MovementMode.png", 32) {
            HyperSleep(500)
            MouseGetPos(&x, &y)
            MouseMove(x + 150, y + 0)
            HyperSleep(500)
            loop 15 {
                ScrollDown()
                HyperSleep(200)
            }
            MouseGetPos(&x, &y)
            MouseMove(x - 1, y + 50)
            HyperSleep(500)


            if PictureImageSearchItem("img\GraphicsQ.png", 32) {
                HyperSleep(1000)
                if PictureImageSearchItemWithCoords("img\MenuPlus.png", 32, 855, 380, 1380, 460) {
                    HyperSleep(500)
                    Click()
                    HyperSleep(500)
                    if PictureImageSearchItemWithCoords("img\MenuMinus.png", 32, 855, 380, 1380, 460) {
                        HyperSleep(500)
                        loop 10 {
                            HyperSleep(100)
                            Click()
                        }
                        if PictureImageSearchItem("img\MenuPlus.png", 32) {
                            HyperSleep(500)
                            loop GraphicsSetting {
                                Click()
                                HyperSleep(200)
                            }
                            HyperSleep(500)
                            send "{" EscKey "}"
                            return 4
                        }
                        else {
                            send "{" EscKey "}"
                            return 3
                        }
                    }
                }
                
            }
            else {
                send "{" EscKey "}"
                return 2
            }
        }
        else {
            send "{" EscKey "}"
            return 1
        }
    }
    else {
        send "{" EscKey "}"
        return 0
    }
    send "{" EscKey "}"
    return 5
}

openInv() {
    hwnd := GetRobloxHWND()
    GetRobloxClientPos(hwnd)
    SearchOptions := "*0 img/openinv.png"
    if ImageSearch(&FoundX, &FoundY, windowX + 0, windowY + 100, windowX + 50, windowY + 150, SearchOptions) {
        MouseMove(FoundX+150, FoundY+200)
    } else {
        Click 30, 120
        HyperSleep(200)
        MouseMove(200, 300)
    }
}


CloseInv() {
    hwnd := GetRobloxHWND()
    GetRobloxClientPos(hwnd)
    SearchOptions := "*0 img/openinv.png"
    if ImageSearch(&FoundX, &FoundY, windowX + 0, windowY + 100, windowX + 50, windowY + 150, SearchOptions) {
        MouseMove(FoundX, FoundY)
        Click
    } else {
    }
}




CheckIfRoboPass() {
    openInv()
    if (FindInvItem("img\RoboPass.png") == 1) {
        MsgBox("RoboPass found! Activating...")
        IniWrite("1", "settings.ini", "Settings", "RoboPass")
        return 1
    } else {
        MsgBox("RoboPass not found.")
        IniWrite("1", "settings.ini", "Settings", "RoboPass")
        return 0
    }
}

StartRoboFirstRound() {
    loop 5 {
        if PictureImageSearchItem("img/round1start.png", 32) {
            MouseGetPos(&x, &y)
            MouseMove(x + 30, y - 20)
            MsgBox("Round 1 started!")
            return 1
        } else {
            MouseMove(800, 825)
            Click
            HyperSleep(200)
        }
    }
}

CheckIfInMenu() {
    if PictureImageSearchItem("img/inroboscreen.png", 32) {
        
        return 1
    }
    else {
        return 0
    }
}

global PickQuestA := 0
global PickQuestB := 1

PickQuestAorB() {
    if PickQuestA == 1 {
        if PictureImageSearchItem("img/questa.png", 32) {
            ;
        }
    }
    
    if PickQuestB == 1 {
        if PictureImageSearchItem("img/questb.png", 32) {
            ;
        }
    }
}





FindInvItem(imagePath) {
    ScrollUp100()
    Loop 50 {  
        if PictureImageSearchItem(imagePath, 32) {
            MouseGetPos(&x, &y)
            MouseMove(x + 30, y)
            return 1
        } else {
            ScrollDown()
            HyperSleep(200)
        }
    }
    return 0
}



ScrollUp() {
    Send "{WheelUp}"
}

ScrollDown() {
    Send "{WheelDown}"
}

ScrollUp100() {
    Loop 100 {
        ScrollUp()
        HyperSleep(25)
    } 
}


; Main Function to call only

; 3 = died
; 2 = Succesfully defeated / timeout reached
VIciousAttackLoop(CurrentFeild := 1) {
    if (VicActivated() == 1) {
        result := ViciousBattle(CurrentFeild)
        if (result == 3) {
            return 3
        } else {
            return
        }

    }
    return 1
}

; From Vicious Attack Loop Function to call only
ViciousBattle(State) {
    if (state == 1) {
        result := AttackVic()

        if (result == 2) {
            return
        } else {
            return 3
        }
    }
    if (state == 2) {
        result := MtnAttackVic()

        if (result == 2) {
            return
        } else {
            return 3
        }
    }
    if (state == 3) {
        result := PepperAttackVic()

        if (result == 2) {
            return
        } else {
            return 3
        }
    }
    return
}

ClickE() {
    Send "{" EKey " down}"
    Movespeed(50)
    Send "{" EKey " up}"
}


GatherDuration := IniRead("settings.ini", "Settings", "FieldGatherTime") *  60000

UsePineTreeGather() {
    startTime := A_TickCount
    TravelPinetree()
    while ((A_TickCount - startTime) < GatherDuration) {
        ; Your code here
        GatherCornerNorthEast()
    }
    HiveReturnPinetree()
}

UseStrawGather() {
    startTime := A_TickCount
    TravelStrawberry()
    while ((A_TickCount - startTime) < GatherDuration) {
        ; Your code here
        GatherCornerNorthEast()
    }
    HiveReturnStraw()
}

UsePineappleGather() {
    startTime := A_TickCount
    TravelPineapple()
    while ((A_TickCount - startTime) < GatherDuration) {
        ; Your code here
        GatherCornerNorthWest()
    }
    ReturnHivePineapple()
}

UseSunflowerGather() {
    startTime := A_TickCount
    TravelSunflower()
    while ((A_TickCount - startTime) < GatherDuration) {
        ; Your code here
        GatherCornerNorthWestCenterSunflower()
    }
    ReturnHiveSunflower()
}

PerformFieldActions() {
    IsPinetreeActive := IniRead("settings.ini", "FieldGather", "IsPinetreeActive", "0")
    IsStrawberryActive := IniRead("settings.ini", "FieldGather", "IsStrawberryActive", "0")
    IsSunflowerActive := IniRead("settings.ini", "FieldGather", "IsSunflowerActive", "0")
    IsPineappleActive := IniRead("settings.ini", "FieldGather", "IsPineappleActive", "0")

    if (IsPinetreeActive = "1") {
        UsePineTreeGather()
    }
    else if (IsStrawberryActive = "1") {
        UseStrawGather()
    }
    else if (IsSunflowerActive = "1") {
        UseSunflowerGather()
    }
    else if (IsPineappleActive = "1") {
        UsePineappleGather()
    }
    else {
        MsgBox("No field selected or no gathering active. Please choose a field.")
    }
}




DetectQuest() {
    if (ImageSearch(&foundX, &foundY, 0, 0, A_ScreenWidth, A_ScreenHeight, "img/DetectQuest.png")) {
        return true
    } else {
        return false
    }
}

CloseQuest() {
    global foundX := 1000  ; Set this to your preferred initial X coordinate
    global foundY := 800   ; Set this to your preferred initial Y coordinate

    loop {
        if (DetectQuest()) {
            MouseMove(foundX, foundY)
            Click
            Sleep 100
        } else {
            return false  ; Quest closed successfully
        }
    }
    return true  ; This line will only be reached if the loop never exits
}

nowUnix() {
    return DateDiff(A_NowUTC, "19700101000000", "Seconds")
}

global LastStockings := nowUnix()
global LastFeast := nowUnix()
global LastCandles := nowUnix()
global LastSamovar := nowUnix()
global LastLidArt := nowUnix()

setAllTimerToZero() {
    global LastStockings := nowUnix() - 3600
    global LastFeast := nowUnix() - 5400
    global LastCandles := nowUnix() - 14400
    global LastSamovar := nowUnix() - 21600
    global LastLidArt := nowUnix() - 28800
}

global IsStockingsActivated := 0
global IsFeastActivated := 0
global IsCandlesActivated := 0
global IsSamovarActivated := 0
global IsLidArtActivated := 0

StartAllTimers() {
    MsgBox("Starting all timers")
    if (IniRead("settings.ini", "Settings", "CandlesToggle") = "1") {
        StartTimer("Candles")
    }
    if (IniRead("settings.ini", "Settings", "StockingsToggle") = "1") {
        StartTimer("Stockings")
    }
    if (IniRead("settings.ini", "Settings", "SamovarToggle") = "1") {
        StartTimer("Samovar")
    }
    if (IniRead("settings.ini", "Settings", "FeastToggle") = "1") {
        StartTimer("Feast")
    }
    if (IniRead("settings.ini", "Settings", "LidArtToggle") = "1") {
        StartTimer("LidArt")
    }
}

StartTimer(timerName) {
    global
    duration := GetTimerDuration(timerName)
    %"Last" . timerName% := nowUnix()
    SetTimer(() => CheckTimer(timerName, nowUnix()), 1000)
    ;MsgBox("Timer " . timerName . " started. Duration: " . duration . " seconds")
}

CheckTimer(timerName, currentTime) {
    global
    lastTime := %"Last" . timerName%
    duration := GetTimerDuration(timerName)
   
    timeElapsed := currentTime - lastTime
    timeLeft := duration - timeElapsed

    if (timeLeft <= 0) {
        %"Last" . timerName% := currentTime
        return 0
    }
    return timeLeft
}

GetTimerDuration(timerName) {
    switch timerName {
        case "Stockings": return 3600    ; 1 hour
        case "Feast": return 5400        ; 1.5 hours
        case "Candles": return 14400     ; 4 hours
        case "Samovar": return 21600     ; 6 hours
        case "LidArt": return 28800      ; 8 hours
    }
}

UseTimerTool() {
    currentTime := nowUnix()

    if (IniRead("settings.ini", "Settings", "CandlesToggle") = "1") {
        if (CheckTimer("Candles", currentTime)) {
            CandlesLoop()
        }
    }

    if (IniRead("settings.ini", "Settings", "StockingsToggle") = "1") {
        if (CheckTimer("Stockings", currentTime)) {
            StockingsLoop()
        }
    }

    if (IniRead("settings.ini", "Settings", "SamovarToggle") = "1") {
        if (CheckTimer("Samovar", currentTime)) {
            SamovarLoop()
        }
    }

    if (IniRead("settings.ini", "Settings", "FeastToggle") = "1") {
        if (CheckTimer("Feast", currentTime)) {
            FeastLoop()
        }
    }

    if (IniRead("settings.ini", "Settings", "LidArtToggle") = "1") {
        if (CheckTimer("LidArt", currentTime)) {
            LidArtLoop()
        }
    }
}

UseBeesmasTools() {
    ;MsgBox("Starting all beesmas timers")
    global LastCandles, LastStockings, LastSamovar, LastFeast, LastLidArt

    currentTime := nowUnix()
    
    for _, tool in ["Candles", "Stockings", "Samovar", "Feast", "LidArt"] {
        if (IniRead("settings.ini", "Settings", tool . "Toggle") = "1") {
            lastTime := %"Last" . tool%
            duration := CheckTimer(tool, nowUnix())
            if (currentTime - lastTime >= duration) {
;                MsgBox("Timer for " . tool . " has expired. Starting " . tool . " loop.")
                %tool . "Loop"%()
 ;               MsgBox("Timer for " . tool . " has expired. ending " . tool . " loop.")
                %"Last" . tool% := currentTime
                StartTimer(tool)
            }
        }
    }

    MsgBox("Finished beesmas timers")
}

UseCandles() {
    global LastCandles
    currentTime := nowUnix()
    if (IniRead("settings.ini", "Settings", "CandlesToggle") = "1") {
        lastTime := LastCandles
        duration := CheckTimer("Candles", nowUnix())
        if (currentTime - lastTime >= duration) {
            ;MsgBox("Timer for Candles has expired. Starting Candles loop.")
            CandlesLoop()
            ;MsgBox("Timer for Candles has expired. ending Candles loop.")
            LastCandles := currentTime
            StartTimer("Candles")
        }
    }
}

UseStockings() {
    global LastStockings
    currentTime := nowUnix()
    if (IniRead("settings.ini", "Settings", "StockingsToggle") = "1") {
        lastTime := LastStockings
        duration := CheckTimer("Stockings", nowUnix())
        if (currentTime - lastTime >= duration) {
            ;MsgBox("Timer for Stockings has expired. Starting Stockings loop.")
            StockingsLoop()
            ;MsgBox("Timer for Stockings has expired. ending Stockings loop.")
            LastStockings := currentTime
            StartTimer("Stockings")
        }
    }
}

UseSamovar() {
    global LastSamovar
    currentTime := nowUnix()
    if (IniRead("settings.ini", "Settings", "SamovarToggle") = "1") {
        lastTime := LastSamovar
        duration := CheckTimer("Samovar", nowUnix())
        if (currentTime - lastTime >= duration) {
            ;MsgBox("Timer for Samovar has expired. Starting Samovar loop.")
            SamovarLoop()
            ;MsgBox("Timer for Samovar has expired. ending Samovar loop.")
            LastSamovar := currentTime
            StartTimer("Samovar")
        }
    }
}

UseFeast() {
    global LastFeast
    currentTime := nowUnix()
    if (IniRead("settings.ini", "Settings", "FeastToggle") = "1") {
        lastTime := LastFeast
        duration := CheckTimer("Feast", nowUnix())
        if (currentTime - lastTime >= duration) {
            ;MsgBox("Timer for Feast has expired. Starting Feast loop.")
            FeastLoop()
            ;MsgBox("Timer for Feast has expired. ending Feast loop.")
            LastFeast := currentTime
            StartTimer("Feast")
        }
    }
}

UseLidArt() {
    global LastLidArt
    currentTime := nowUnix()
    if (IniRead("settings.ini", "Settings", "LidArtToggle") = "1") {
        lastTime := LastLidArt
        duration := CheckTimer("LidArt", nowUnix())
        if (currentTime - lastTime >= duration) {
            ;MsgBox("Timer for LidArt has expired. Starting LidArt loop.")
            LidArtLoop()
            ;MsgBox("Timer for LidArt has expired. ending LidArt loop.")
            LastLidArt := currentTime
            StartTimer("LidArt")
        }
    }
}

UseAllTheTimers() {
    UseCandles()
    UseStockings()
    UseSamovar()
    UseFeast()
    UseLidArt()
    ;MsgBox("Timer loop completed, if you see this, something went correct if it has not been the min amount of time before last timer use/start time or program")
}


CandlesLoop() {
    Candles()
    ResetMainNonVicCharacter()
}

StockingsLoop() {
    Stockings()
    ResetMainNonVicCharacter()
}

SamovarLoop() {
    Somavar()
    ResetMainNonVicCharacter()
}

FeastLoop() {
    Feast()
    ResetMainNonVicCharacter()
}

LidArtLoop() {
    OnnetsLidArt()
    ResetMainNonVicCharacter()
}

CheckAndUseBeesmasTools() {
    currentTime := nowUnix()

    if (currentTime - LastStockings >= 3600 && IniRead("settings.ini", "Settings", "StockingsToggle") = "1") {
        StockingsLoop()
        LastStockings := currentTime
    }

    if (currentTime - LastFeast >= 5400 && IniRead("settings.ini", "Settings", "FeastToggle") = "1") {
        FeastLoop()
        LastFeast := currentTime
    }

    if (currentTime - LastCandles >= 14400 && IniRead("settings.ini", "Settings", "CandlesToggle") = "1") {
        CandlesLoop()
        LastCandles := currentTime
    }

    if (currentTime - LastSamovar >= 21600 && IniRead("settings.ini", "Settings", "SamovarToggle") = "1") {
        SamovarLoop()
        LastSamovar := currentTime
    }

    if (currentTime - LastLidArt >= 28800 && IniRead("settings.ini", "Settings", "LidArtToggle") = "1") {
        LidArtLoop()
        LastLidArt := currentTime
    }
}

