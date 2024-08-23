
BasicSmallSquarePattern() {
    Send "{" WKey " down}"
    Movespeed(500)
    Send "{" WKey " up}"
    HyperSleep(50)

    Send "{" DKey " down}"
    Movespeed(500)
    Send "{" DKey " up}"
    HyperSleep(50)

    Send "{" SKey " down}"
    Movespeed(500)
    Send "{" SKey " up}"
    HyperSleep(50)

    Send "{" AKey " down}"
    Movespeed(500)
    Send "{" AKey " up}"
    HyperSleep(50)
}


TravelPinetree() {
    Send "{" EKey " down}"
    Movespeed(50)
    Send "{" EKey " up}"
    HyperSleep(800)
    glider()
    HyperSleep(50)
    Send "{" DKey " down}"
    Movespeed(500)
    Send "{" DKey " up}"
    HyperSleep(4000)
    Send "{" SKey " down}"
    Hypersleep(500)
    Send "{" SKey " up}"
    HyperSleep(3000)
    Send "{" SKey " down}"
    Movespeed(2000)
    Send "{" SKey " up}"
    HyperSleep(50)
    Send "{" DKey " down}"
    Movespeed(2000)
    Send "{" DKey " up}"


    Send "{" WKey " down}"
    Movespeed(1500)
    Send "{" WKey " up}"
    HyperSleep(50)
    Send "{" AKey " down}"
    Movespeed(1500)
    Send "{" AKey " up}"
    HyperSleep(50)
    Send "{" RotRight " down}"
    Movespeed(50)
    Send "{" RotRight " up}"
    HyperSleep(50)
    Send "{" RotRight " down}"
    Movespeed(50)
    Send "{" RotRight " up}"
    sprinkler()
}

TravelSunflower() {
    Send "{" DKey " down}"
    Movespeed(700, 10)
    Send "{" DKey " up}"
    HyperSleep(50)

    Send "{" SKey " down}"
    Movespeed(2000)
    Send "{" SKey " up}"

    Send "{" AKey " down}"
    Movespeed(1000)
    Send "{" AKey " up}"

    HyperSleep(50)

    Send "{" SKey " down}"
    Movespeed(1500)
    Send "{" SKey " up}"

    Send "{" DKey " down}"
    Movespeed(2000)
    Send "{" DKey " up}"

    ViewRight()
    ViewRight()

    Send "{" AKey " down}"
    Movespeed(1500)
    Send "{" AKey " up}"

    Send "{" DKey " down}"
    Movespeed(1000)
    Send "{" DKey " up}"

    SDkeyDown
    Movespeed(1000)
    SDkeyUp()

    sprinkler()
}


TravelPineapple() {
    HyperSleep(100)
    Send "{" EKey " down}"
    HyperSleep(100)
    Send "{" EKey " up}"
    Send "{" AKey " down}"
    HyperSleep(1600)
    glider()
    HyperSleep(2500)
    Send "{" AKey " up}"
    Send "{" SpaceKey " 1}"
    HyperSleep(3000)
    Send "{" SKey " down}"
    Movespeed(3000)
    Send "{" SKey " up}"
    HyperSleep(50)
    Send "{" DKey " down}"
    Movespeed(3000)
    Send "{" DKey " up}"
    HyperSleep(50)
    ViewRight()
    ViewRight()
    ViewRight()
    ViewRight()



    Send "{" SKey " down}"
    Movespeed(1000)
    Send "{" SKey " up}"
    HyperSleep(50)
    Send "{" DKey " down}"
    Movespeed(1000)
    Send "{" DKey " up}"
    HyperSleep(50)
    sprinkler()
}


TravelStrawberry() {
    Send "{" EKey " down}"
    Movespeed(50)
    Send "{" EKey " up}"
    HyperSleep(600)
    glider()
    HyperSleep(50)
    Send "{" DKey " down}"
    Movespeed(500)
    Send "{" DKey " up}"
    HyperSleep(1500)
    Send "{" SpaceKey " down}"
    Movespeed(20)
    Send "{" SpaceKey " up}"

    HyperSleep(1300)
    ViewRight()
    ViewRight()

    Send "{" DKey " down}"
    Movespeed(500)
    Send "{" DKey " up}"


    WDkeyDown()
    Movespeed(1500)
    WDkeyUp()

    SAkeyDown()
    Movespeed(1500)
    SAkeyUp()
    sprinkler()


}

GatherCornerNorthEast() {
    Click("down")
    Send "{" DKey " down}"
    Movespeed(1000)
    Send "{" DKey " up}"

    Send "{" WKey " down}"
    Movespeed(300)
    Send "{" WKey " up}"

    Send "{" AKey " down}"
    Movespeed(1000)
    Send "{" AKey " up}"

    Send "{" WKey " down}"
    Movespeed(300)
    Send "{" WKey " up}"



    Send "{" DKey " down}"
    Movespeed(1000)
    Send "{" DKey " up}"

    Send "{" WKey " down}"
    Movespeed(300)
    Send "{" WKey " up}"

    Send "{" AKey " down}"
    Movespeed(1000)
    Send "{" AKey " up}"

    Send "{" WKey " down}"
    Movespeed(2000)
    Send "{" WKey " up}"

    Send "{" DKey " down}"
    Movespeed(2000)
    Send "{" DKey " up}"






    Send "{" SKey " down}"
    Send "{" AKey " down}"
    Movespeed(1500)
    Send "{" SKey " up}"
    Send "{" AKey " up}"
    Click("up")
    HyperSleep(50)
}

GatherCornerNorthWest() {
    Click("down")
    Send "{" AKey " down}"
    Movespeed(1000)
    Send "{" AKey " up}"

    Send "{" WKey " down}"
    Movespeed(300)
    Send "{" WKey " up}"

    Send "{" DKey " down}"
    Movespeed(1000)
    Send "{" DKey " up}"

    Send "{" WKey " down}"
    Movespeed(300)
    Send "{" WKey " up}"



    Send "{" AKey " down}"
    Movespeed(1000)
    Send "{" AKey " up}"

    Send "{" WKey " down}"
    Movespeed(300)
    Send "{" WKey " up}"

    Send "{" DKey " down}"
    Movespeed(1000)
    Send "{" DKey " up}"

    Send "{" WKey " down}"
    Movespeed(750)
    Send "{" WKey " up}"

    Send "{" AKey " down}"
    Movespeed(1250)
    Send "{" AKey " up}"






    Send "{" SKey " down}"
    Send "{" DKey " down}"
    Movespeed(1000)
    Send "{" SKey " up}"
    Send "{" DKey " up}"
    Click("up")
    HyperSleep(50)
}


GatherCornerNorthWestCenterSunflower() {
    Click("down")
    Send "{" AKey " down}"
    Movespeed(750)
    Send "{" AKey " up}"

    Send "{" WKey " down}"
    Movespeed(300)
    Send "{" WKey " up}"

    Send "{" DKey " down}"
    Movespeed(750)
    Send "{" DKey " up}"

    Send "{" WKey " down}"
    Movespeed(300)
    Send "{" WKey " up}"



    Send "{" AKey " down}"
    Movespeed(750)
    Send "{" AKey " up}"

    Send "{" WKey " down}"
    Movespeed(300)
    Send "{" WKey " up}"

    Send "{" DKey " down}"
    Movespeed(750)
    Send "{" DKey " up}"

    Send "{" WKey " down}"
    Movespeed(750)
    Send "{" WKey " up}"

    Send "{" AKey " down}"
    Movespeed(3000)
    Send "{" AKey " up}"





    Send "{" DKey " down}"
    Movespeed(1000)
    Send "{" DKey " up}"
    HyperSleep(50)
    SDkeyDown()
    Movespeed(1400)
    SDkeyUp()
    HyperSleep(50)
    Click("up")
    HyperSleep(50)
}

ReturnHiveSunflower() {
    Send "{" WKey " down}"
    Movespeed(2000)
    Send "{" WKey " up}"
    HyperSleep(50)
    Send "{" AKey " down}"
    Movespeed(3000)
    Send "{" AKey " up}"
    HyperSleep(50)
    Send "{" SKey " down}"
    Movespeed(600)
    Send "{" SKey " up}"
    HyperSleep(50)
    Send "{" AKey " down}"
    Movespeed(2500)
    Send "{" AKey " up}"
    HyperSleep(50)
    Send "{" SKey " down}"
    Movespeed(1500)
    Send "{" SKey " up}"
    HyperSleep(50)
    Send "{" AKey " down}"
    Movespeed(1000)
    Send "{" AKey " up}"
    HyperSleep(50)
    Send "{" DKey " down}"
    Movespeed(500)
    Send "{" DKey " up}"


    Send "{" RotLeft " down}"
    Movespeed(50)
    Send "{" RotLeft " up}"
    HyperSleep(50)
    Send "{" RotLeft " down}"
    Movespeed(50)
    Send "{" RotLeft " up}"


    MoveRightByCurrentHive()
}

ReturnHivePineApple() {
    Send "{" WKey " down}"
    Movespeed(2000)
    Send "{" WKey " up}"
    HyperSleep(50)
    Send "{" DKey " down}"
    Movespeed(4000)
    Send "{" DKey " up}"
    HyperSleep(50)
    Send "{" SKey " down}"
    Movespeed(9000)
    Send "{" SKey " up}"
    HyperSleep(50)
    Send "{" WKey " down}"
    Movespeed(300)
    Send "{" WKey " up}"
    HyperSleep(50)
    Send "{" AKey " down}"
    Movespeed(1500)
    Send "{" AKey " up}"

    Send "{" SpaceKey " down}"
    Movespeed(100)
    Send "{" SpaceKey " up}"
    Send "{" AKey " down}"
    Movespeed(500)
    Send "{" AKey " up}"
    HyperSleep(50)
    ClickE()
    HyperSleep(50)
    Send "{" WKey " down}"
    Movespeed(200)
    Send "{" WKey " up}"
    HyperSleep(50)
    ClickE()
    HyperSleep(50)
    Send "{" WKey " down}"
    Movespeed(200)
    Send "{" WKey " up}"
    HyperSleep(50)
    ClickE()
    HyperSleep(50)
    Send "{" WKey " down}"
    Movespeed(200)
    Send "{" WKey " up}"
    HyperSleep(50)
    ClickE()
    HyperSleep(50)
    Send "{" WKey " down}"
    Movespeed(200)
    Send "{" WKey " up}"
    HyperSleep(50)
    ClickE()
    HyperSleep(2500)

    ViewLeft()
    ViewLeft()
    ViewLeft()
    ViewLeft()

    HyperSleep(50)

    Send "{" WKey " down}"
    Movespeed(2500)
    Send "{" WKey " up}"
    HyperSleep(50)

    Send "{" SKey " down}"
    Movespeed(200)
    Send "{" SKey " up}"

    Send "{" DKey " down}"
    Movespeed(2500)
    Send "{" DKey " up}"
    
    Send "{" SKey " down}"
    Movespeed(400)
    Send "{" SKey " up}"

    Send "{" AKey " down}"
    Movespeed(400)
    Send "{" AKey " up}"

    MoveRightByCurrentHive()

    Send "{" WKey " down}"
    Movespeed(200)
    Send "{" WKey " up}"
}


; Define the CheckHiveReset function
HiveReturnStraw() {
    Send "{" AKey " down}"
    Movespeed(3000)
    Send "{" SpaceKey " down}"
    HyperSleep(2500)
    Send "{" AKey " up}"
    Send "{" SpaceKey " up}"
    HyperSleep(50)
    Send "{" WKey " down}"
    Movespeed(3000)
    Send "{" WKey " up}"
    HyperSleep(50)
    Send "{" AKey " down}"
    Movespeed(7000)
    Send "{" AKey " up}"

    HyperSleep(50)
    ViewLeft()
    ViewLeft()

    Send "{" AKey " down}"
    Movespeed(500)
    Send "{" AKey " up}"

    Send "{" WKey " down}"
    Movespeed(1000)
    Send "{" WKey " up}"
    HyperSleep(50)
    Send "{" AKey " down}"
    Movespeed(200)
    Send "{" AKey " up}"
    HyperSleep(50)
    Send "{" WKey " down}"
    Movespeed(1500)
    Send "{" WKey " up}"
    HyperSleep(50)
    Send "{" AKey " down}"
    Movespeed(200)
    Send "{" AKey " up}"
    HyperSleep(50)
    Send "{" WKey " down}"
    Movespeed(300)
    Send "{" WKey " up}"
    HyperSleep(50)
    Send "{" DKey " down}"
    Movespeed(700)
    Send "{" DKey " up}"
    HyperSleep(50)
    Send "{" AKey " down}"
    Movespeed(1000)
    Send "{" AKey " up}"

    MoveRightByCurrentHive()
}

; Define the HiveReturnPine function
HiveReturnPinetree() {
    Send "{" DKey " down}"
    Movespeed(2000)
    Send "{" DKey " up}"

    Send "{" SKey " down}"
    Movespeed(8000)
    Send "{" SKey " up}"

    Send "{" RotLeft " down}"
    HyperSleep(50)
    Send "{" RotLeft " up}"
    HyperSleep(50)
    Send "{" RotLeft " down}"
    HyperSleep(50)
    Send "{" RotLeft " up}"

    Send "{" WKey " down}"
    Movespeed(7000)
    Send "{" WKey " up}"

    Send "{" DKey " down}"
    Movespeed(2000)
    Send "{" DKey " up}"

    Send "{" SKey " down}"
    Movespeed(500)
    Send "{" SKey " up}"

    Send "{" WKey " down}"
    Movespeed(1000)
    Send "{" WKey " up}"

    Send "{" SpaceKey " down}"
    HyperSleep(20)
    Send "{" SpaceKey " up}"
    HyperSleep(80)
    glider()
    HyperSleep(5000)

    Send "{" WKey " down}"
    Movespeed(1500)
    Send "{" WKey " up}"
;-------------------------------------------------------------------------------
    Send "{" SKey " down}"
    Movespeed(200)
    Send "{" SKey " up}"
;-------------------------------------------------------------------------------
    Send "{" DKey " down}"
    Movespeed(3000)
    Send "{" DKey " up}"

    Send "{" SKey " down}"
    Movespeed(300)
    Send "{" SKey " up}"

    Send "{" AKey " down}"
    Movespeed(400)
    Send "{" AKey " up}"

    MoveRightByCurrentHive()
}


PepperPatch() {
    SetKeyDelay 0, 50

    Send "{" DKey " down}"
    Movespeed(2500, 1)
    Send "{" DKey " up}"

    Send "{" DKey " down}{" SpaceKey " down}"
    Movespeed(200, 2)
    Send "{" SpaceKey " up}"
    Send "{" WKey " down}"
    Movespeed(450, 4)
    Send "{" WKey " up}"
    Movespeed(500, 5)
    Send "{" DKey " up}"

    Send "{" WKey " down}{" DKey " down}"
    Movespeed(200, 2)
    Send "{" DKey " up}"
    Movespeed(300, 3)
    Send "{" WKey " up}"

    Send "{" WKey " down}{" SpaceKey " down}"
    Movespeed(500, 2)
    Send "{" SpaceKey " up}{" WKey " up}"
    Send "{" WKey " down}"
    Send "{" AKey " down}"
    Movespeed(300, 3)
    Send "{" AKey " up}"
    Movespeed(1900, 19)
    Send "{" WKey " up}"
    Send "{" DKey " down}"
    Movespeed(200, 6)
    Send "{" DKey " up}"

    Send "{" SpaceKey " down}{" WKey " down}"
    Movespeed(300, 2)
    Send "{" SpaceKey " up}{" WKey " up}"
    Movespeed(500, 0)
    Send "{" SpaceKey " down}{" WKey " down}"
    Movespeed(300, 2)
    Send "{" SpaceKey " up}{" WKey " up}"
    Movespeed(500, 0)

    Send "{" SpaceKey " down}{" WKey " down}"
    Movespeed(300, 2)
    Send "{" SpaceKey " up}{" WKey " up}"
    Movespeed(500, 0)
    Send "{" SpaceKey " down}{" WKey " down}"
    Movespeed(300, 2)
    Send "{" SpaceKey " up}{" WKey " up}"
    Movespeed(500, 0)

    PlayerStatus("Debugging pepper patch lmk if this breaks", 7419530, false)
    Send "{" WKey " down}"
    Movespeed(1600, 16)
    Send "{" SpaceKey " down}"
    Movespeed(200, 2)
    Send "{" SpaceKey " up}"
    Movespeed(300, 3)
    Send "{" WKey " up}"

    Send "{" WKey " down}"
    Send "{" DKey " down}"
    Movespeed(2000, 20)
    Send "{" WKey " up}"
    Send "{" DKey " up}"
    Send "{" SpaceKey " down}"
    Send "{" DKey " down}"
    Movespeed(250, 2)
    Send "{" SpaceKey " up}"
    Movespeed(2000, 20)
    Send "{" DKey " up}"

    Send "{" SpaceKey " down}"
    Send "{" DKey " down}"
    Movespeed(100, 1)
    Send "{" SpaceKey " up}"
    Movespeed(1100, 8)
    Send "{" DKey " up}"
    Movespeed(200, 2)
    Send "{" SKey " down}"
    Movespeed(700, 7)
    Send "{" SKey " up}"

    Send "{" WKey " down}"
    Movespeed(1600, 16)
    Movespeed(650, 5)
    Send "{" WKey " up}"

    Send "{" DKey " down}"
    Movespeed(700, 5)
    Send "{" DKey " up}"

    Send "{" SKey " down}"
    Movespeed(1600, 16)
    Movespeed(650, 6)
    Send "{" SKey " up}"

    Send "{" DKey " down}"
    Movespeed(600, 5)
    Send "{" DKey " up}"

    Send "{" WKey " down}"
    Movespeed(1600, 16)
    Movespeed(650, 6)
    Send "{" WKey " up}"
}


MountainTop() {
    SetKeyDelay 0, 50

    Movespeed(100, 0)
    Send "{" EKey " down}"
    Movespeed(100, 0)
    Send "{" EKey " up}"
    Movespeed(3500, 0)

    Send "{" WKey " down}"
    Movespeed(1700, 15)
    Send "{" WKey " up}"

    Send "{" AKey " down}"
    Movespeed(750, 6)
    Send "{" AKey " up}"

    Send "{" SKey " down}"
    Movespeed(2300, 20)
    Send "{" SKey " up}"

    Send "{" DKey " down}"
    Movespeed(1500, 12)
    Send "{" DKey " up}"

    Send "{" WKey " down}"
    Movespeed(1500, 15)
    Movespeed(750, 3)
    Send "{" WKey " up}"
}

Rose() {
    SetKeyDelay 50, 50

    Send "{" EKey " down}"
    Movespeed(100, 0)
    Send "{" EKey " up}"

    Movespeed(230, 0)

    Send "{" DKey " down}"
    Send "{" SpaceKey " down}"
    Movespeed(25, 0)
    Send "{" SpaceKey " up}"
    Send "{" SpaceKey " down}"
    Movespeed(25, 0)
    Send "{" SpaceKey " up}"
    Movespeed(500, 0)
    Send "{" DKey " up}"

    Movespeed(3000, 0)

    Send "{" SpaceKey " down}"
    Movespeed(50, 0)
    Send "{" SpaceKey " up}"

    Movespeed(500, 0)
    Send "{" AKey " down}"
    Movespeed(1700, 17)
    Movespeed(1100, 9)
    Send "{" AKey " up}"

    Send "{" SKey " down}"
    Movespeed(600, 6)
    Send "{" SKey " up}"

    Send "{" DKey " down}"
    Movespeed(1700, 17)
    Movespeed(1100, 9)
    Send "{" DKey " up}"

    Send "{" SKey " down}"
    Movespeed(600, 6)
    Send "{" SKey " up}"

    Send "{" AKey " down}"
    Movespeed(1700, 17)
    Movespeed(1100, 9)
    Send "{" AKey " up}"
}

Cactus() {
    SetKeyDelay 50, 50

    Send "{" EKey " down}"
    Movespeed(100, 0)
    Send "{" EKey " up}"

    Movespeed(750, 0)
    Send "{" DKey " down}"
    Send "{" SpaceKey " down}"
    Movespeed(300, 0)
    Send "{" SpaceKey " up}"
    Send "{" SpaceKey " down}"
    Movespeed(100, 0)
    Send "{" SpaceKey " up}"
    Movespeed(1500, 0)
    Send "{" DKey " up}"

    Send "{" SKey " down}"
    Movespeed(400, 0)
    Send "{" SpaceKey " down}"
    Movespeed(300, 0)
    Send "{" SpaceKey " up}"
    Send "{" SKey " up}"

    Movespeed(2000, 0)

    Send "{" DKey " down}"
    Movespeed(2600, 24)
    Send "{" DKey " up}"

    Send "{" SKey " down}"
    Movespeed(500, 4)
    Send "{" SKey " up}"

    Send "{" AKey " down}"
    Movespeed(2600, 24)
    Send "{" AKey " up}"

    Send "{" SKey " down}"
    Movespeed(500, 4)
    Send "{" SKey " up}"

    Send "{" DKey " down}"
    Movespeed(2600, 24)
    Send "{" DKey " up}"
}





somavar(){
    HyperSleep(100)
    Send "{" EKey " down}"
    HyperSleep(100)
    Send "{" EKey " up}"
    Send "{" AKey " down}"
    HyperSleep(1600)
    glider()
    HyperSleep(4500)
    Send "{" AKey " up}"
    Send "{" SpaceKey " 1}"
    HyperSleep(2000)

    Send "{" SKey " down}"
    movespeed(4000, 40)
    Send "{" SKey " up}"

    Send "{" SpaceKey " down}{" SKey " down}"
    HyperSleep(50)
    Send "{" SpaceKey " up}"
    movespeed(2000, 20)
    Send "{" AKey " down}"
    movespeed(1000, 10)
    Send "{" SKey " up}{" AKey " up}"

    Send "{" SpaceKey " down}{" SKey " down}"
    movespeed(750, 7)
    Send "{" SpaceKey " up}"
    movespeed(500, 5)
    Send "{" SKey " up}"

    Send "{" AKey " down}"
    movespeed(500, 5)
    Send "{" AKey " up}"

    Send "{" EKey " down}"
    HyperSleep(50)
    Send "{" EKey " up}"

    HyperSleep(5000)
    Send "{" RotLeft " 1}"  ; <--- , key (turn left)

    Send "{" WKey " down}"
    movespeed(300, 3)
    Send "{" WKey " up}"

    Send "{" Dkey " down}"
    movespeed(300, 3)
    Send "{" Dkey " up}"

    Send "{" SKey " down}"
    movespeed(500, 5)
    Send "{" SKey " up}"

    Send "{" AKey " down}"
    movespeed(500, 3)
    Send "{" AKey " up}"

    Send "{" WKey " down}"
    movespeed(500, 3)
    Send "{" WKey " up}"
}




feast(){
    HyperSleep(100)
    Send "{" EKey " down}"
    HyperSleep(100)
    Send "{" EKey " up}"
    Send "{" DKey " down}"
    HyperSleep(1025)
    glider()
    HyperSleep(1100)
    Send "{" DKey " up}"
    Send "{" SKey " down}"
    HyperSleep(300)
    Send "{" SKey " up}"
    Send "{" SpaceKey " 1}"
    HyperSleep(1000)
    Send "{" AKey " down}"
    movespeed(0, 10)
    Send "{" AKey " up}"

    ;; Claim Feist
    Send "{" EKey " 1}"
    HyperSleep(6000)
    Send "{" RotRight " 3}"
    ; landed
    Send "{" WKey " down}"
    movespeed(400, 10)
    Send "{" WKey " up}"

    Send "{" Dkey " down}"
    movespeed(200, 6)
    Send "{" Dkey " up}"

    Send "{" SKey " down}"
    movespeed(600, 4)
    Send "{" SKey " up}"
   
    Send "{" AKey " down}"
    movespeed(600, 6)
    Send "{" AKey " up}"

    Send "{" WKey " down}"
    movespeed(600, 4)
    Send "{" WKey " up}"

    Send "{" Dkey " down}"
    movespeed(500, 5)
    Send "{" Dkey " up}"

    Send "{" SKey " down}"
    movespeed(500, 4)
    Send "{" SKey " up}"
}

wealthClock()  {
    HyperSleep(100)
    Send "{" EKey " down}"
    HyperSleep(100)
    Send "{" EKey " up}"
    Send "{" AKey " down}"
    HyperSleep(600)
    glider()
    HyperSleep(3400)
    Send "{" AKey " up}"
    Send "{" WKey " down}"
    HyperSleep(3000)
    Send "{" SpaceKey " 1}"
    HyperSleep(2000)
    Send "{" WKey " up}"
    HyperSleep(10)
    Send "{" AKey " down}"
    Movespeed(2000, 6) ;<-- Need to replace with Walk wh its fixed
    Send "{" AKey " up}"
    HyperSleep(100)

    loop 5 {
        Send "{" SKey " down}"
        Movespeed(300, 1)
        Send "{" SKey " up}"
        HyperSleep(100)
        Send "{" AKey " down}"
        Movespeed(600, 3)
        Send "{" AKey " up}"
        HyperSleep(100)
    }
    Send "{" AKey " down}"
    Movespeed(600, 3)
    Send "{" SpaceKey " Down}"
    HyperSleep(500)
    Send "{" SpaceKey " Up}"
    HyperSleep(500)
    Movespeed(500, 3)
    Send "{" AKey " up}"
    HyperSleep(100)
    Send "{" WKey " down}"
    Movespeed(1000, 6)
    Send "{" WKey " up}"
    HyperSleep(100)
    Send "{" AKey " down}"
    Movespeed(2000, 6)
    Send "{" AKey " up}"
    HyperSleep(100)
    Send "{" SKey " down}"
    Send "{" DKey " down}"
    Movespeed(800, 6)
    Send "{" DKey " up}"
    Send "{" SKey " up}"
    ClickE()
}


stockings(){
    HyperSleep(100)
    Send "{" EKey " down}"
    HyperSleep(100)
    Send "{" EKey " up}"
    Send "{" AKey " down}"
    HyperSleep(600)
    glider()
    HyperSleep(3400)
    Send "{" AKey " up}"
    Send "{" WKey " down}"
    HyperSleep(3000)
    Send "{" SpaceKey " 1}"
    HyperSleep(2000)
    Send "{" WKey " up}"
    HyperSleep(10)
    Send "{" SKey " down}"
    Movespeed(600, 6) ;<-- Need to replace with Walk wh its fixed
    Send "{" SKey " up}"
    ClickE()
    ;claim and collect items 
    HyperSleep(100)
    Send "{" WKey " down}"
    Movespeed(1000, 6) ;<-- Need to replace with Walk wh its fixed
    Send "{" WKey " up}"
    HyperSleep(100)
    Send "{" AKey " down}"
    Movespeed(1000, 6) ;<-- Need to replace with Walk wh its fixed
    Send "{" AKey " up}"

    HyperSleep(100)
    Send "{" DKey " down}"
    Movespeed(1000, 6) ;<-- Need to replace with Walk wh its fixed
    Send "{" DKey " up}"

    HyperSleep(100)
    Send "{" SKey " down}"
    Movespeed(200, 6) ;<-- Need to replace with Walk wh its fixed
    Send "{" SKey " up}"

    HyperSleep(100)
    Send "{" AKey " down}"
    Movespeed(1000, 6) ;<-- Need to replace with Walk wh its fixed
    Send "{" AKey " up}"

    HyperSleep(100)
    Send "{" SKey " down}"
    Movespeed(200, 6) ;<-- Need to replace with Walk wh its fixed
    Send "{" SKey " up}"

    HyperSleep(100)
    Send "{" DKey " down}"
    Movespeed(1000, 6) ;<-- Need to replace with Walk wh its fixed
    Send "{" DKey " up}"
}




OnnetsLidArt() {
    SetKeyDelay 0, 50
    Send "{" EKey " down}"
    HyperSleep(100)
    Send "{" EKey " up}"
    HyperSleep(3000)
    Send "{" SKey " down}"
    HyperSleep(3800)
    Send "{" SKey " up}"
    Send "{" EKey " down}"
    HyperSleep(100)
    Send "{" EKey " up}"
    Send "{" DKey " down}"
    HyperSleep(2000)
    Send "{" DKey " up}"
    Send "{" AKey " down}"
    HyperSleep(500)
    Send "{" AKey " up}"
    Send "{" SKey " down}"
    HyperSleep(6500)
    Send "{" SKey " up}"
    Send "{" SpaceKey " down}"
    HyperSleep(300)
    Send "{" SKey " down}"
    HyperSleep(100)
    Send "{" SKey " up}"
    Send "{" SpaceKey " up}"
    Send "{" SKey " down}"
    HyperSleep(4000)
    Send "{" SpaceKey " down}"
    HyperSleep(450)
    Send "{" SKey " up}"
    Send "{" SpaceKey " up}"

    ;Loot collection

    Send "{" EKey " down}"
    HyperSleep(100)
    Send "{" EKey " up}"

    HyperSleep(5000)

    Send "{" AKey " down}"
    HyperSleep(200)
    Send "{" AKey " up}"

    Send "{" WKey " down}"
    HyperSleep(200)
    Send "{" WKey " up}"

    Send "{" DKey " down}"
    HyperSleep(300)
    Send "{" DKey " up}"

    Send "{" SKey " down}"
    HyperSleep(300)
    Send "{" SKey " up}"

    Send "{" AKey " down}"
    HyperSleep(300)
    Send "{" AKey " up}"

    Send "{" WKey " down}"
    HyperSleep(300)
    Send "{" WKey " up}"
}

;1044681040465235973

Candles() {
    SetKeyDelay 0, 50
    Movespeed(300)
    Send "{" DKey " down}"
    Movespeed(250)
    Send "{" SpaceKey " up}"
    Movespeed(2300)
    Send "{" DKey " up}"
    ;; 35 bee zone still at ground

    Send "{" WKey " down}"
    Movespeed(400)
    Send "{" WKey " up}"
    Movespeed(100)
    Send "{" SKey " down}"
    Movespeed(350)
    Send "{" SKey " up}"
    Movespeed(100)

    ;;jumping into it
    Send "{" DKey " down}{" SpaceKey " down}"
    Movespeed(200)
    Send "{" SpaceKey " up}"
    Send "{" WKey " down}"
    Movespeed(450)
    Send "{" WKey " up}"
    Movespeed(500)
    Send "{" DKey " up}"
        
    Send "{" WKey " down}{" DKey " down}"
    Movespeed(200)
    Send "{" DKey " up}"
    Movespeed(300)
    Send "{" WKey " up}"
    
    Send "{" SpaceKey " down}"
    Movespeed(100)
    Send "{" SpaceKey " up}"
    Send "{" DKey " down}"
    Movespeed(3000)
    Send "{" DKey " up}"
    Send "{" AKey " down}"
    Movespeed(500)
    Send "{" AKey " up}"

    ;Turn towards candles

    Send "{" SKey " down}"
    Movespeed(150)
    Send "{" SKey " up}"

    Send "{" LeftShiftKey " down}"
    HyperSleep(100)
    Send "{" LeftShiftKey " up}"
    HyperSleep(100)
    Send "{" RotLeft " 1}"
    HyperSleep(100)
    Send "{" RotLeft " 1}"
    HyperSleep(100)
    Send "{" RotLeft " 1}"
    HyperSleep(100)
    Send "{" RotLeft " 1}"

    ;glide to candles
    Send "{" SpaceKey " down}"
    Movespeed(480)
    Send "{" SpaceKey " up}"
    HyperSleep(50)
    Send "{" SpaceKey " down}"
    Movespeed(100)
    Send "{" SpaceKey " up}"
    HyperSleep(1500)

    ;move to candles
    Send "{" LeftShiftKey " down}"
    HyperSleep(100)
    Send "{" LeftShiftKey " up}"
    Send "{" AKey " down}"
    Movespeed(2000)
    Send "{" AKey " up}"

    Send "{" DKey " down}"
    Movespeed(1000)
    Send "{" DKey " up}"

    Send "{" WKey " down}"
    Movespeed(750)
    Send "{" WKey " up}"

    ;use candles

    ;<--- needs to check if candles are on cooldown or not

    ;Collection
    Send "{" AKey " down}"
    Movespeed(250)
    Send "{" AKey " up}"

    Send "{" WKey " down}"
    Movespeed(250)
    Send "{" WKey " up}"

    Send "{" SKey " down}"
    Movespeed(500)
    Send "{" SKey " up}"
}
