#Requires AutoHotkey v2.0
#SingleInstance Force

SetWorkingDir A_ScriptDir

KeyDelay := 40

Setkeydelay KeyDelay

CoordMode "Pixel", "Screen"
SendMode "Event"


#Include ImageToText.ahk
#include %A_ScriptDir%\scripts\

#Include paths.ahk
#Include functions.ahk
#include joinserver.ahk
#Include webhook.ahk
#Include Boosting Assistance Macro.ahk
#Include MessageFunctions.ahk
#Include socket.ahk
; #Include timers.ahk

#include %A_ScriptDir%\lib\

#Include FormData.ahk
#Include Gdip_All.ahk
#include Gdip_ImageSearch.ahk
#Include roblox.ahk
#Include walk.ahk

GetRobloxClientPos()
pToken := Gdip_Startup()
bitmaps := Map()
bitmaps.CaseSense := 0


#Include %A_ScriptDir%\img\bitmaps.ahk




; Initialize settings if the file does not exist
if (!FileExist("settings.ini")) {
    IniWrite("Insert Url", "settings.ini", "Settings", "url")
    IniWrite("Insert UserId", "settings.ini", "Settings", "discordID")
    IniWrite("Insert Movespeed", "settings.ini", "Settings", "movespeed")
    IniWrite("50000", "settings.ini", "Settings", "port")
    IniWrite("0", "settings.ini", "Settings", "KillVicBeeToggle")
    IniWrite("0", "settings.ini", "Settings", "IsHasteToggled")
    IniWrite("", "RoboQuests.ini", "RoboBear", "QuestTextA")
    IniWrite("", "RoboQuests", "RoboBear", "QuestTextB")
    IniWrite("0", "settings.ini", "Settings", "Graphics")
    IniWrite("50000", "settings.ini", "Settings", "DetectBlockedExp")
}

IniWrite(1, "settings.ini", "Settings", "FirstLoad")

; Read settings from the ini file
url := IniRead("settings.ini", "Settings", "url")
discordID := IniRead("settings.ini", "Settings", "discordID")
FieldGatherTime := IniRead("settings.ini", "Settings", "FieldGatherTime")
PlayerSpeed := IniRead("settings.ini", "Settings", "movespeed")
Port := IniRead("settings.ini", "Settings", "port")
KillVicBeeToggle := IniRead("settings.ini", "Settings", "KillVicBeeToggle")
DetectBlockedExp := IniRead("settings.ini", "Settings", "DetectBlockedExp")

TraySetIcon("img\basicbeeface.ico")

LaunchBoostTools(*) {
    RunBoostingAssistanceMacro()
}






MainGui := Gui("+Border +OwnDialogs", "Beez universal macro")
MainGui.BackColor := "afafaf"

secretOptionsActive := IniRead("settings.ini", "Settings", "SecretOptionsActive")
if (secretOptionsActive = "1") {
    Tabs := MainGui.Add("Tab3", "x0 y10 w750 h330", ["Main", "Settings", "Accounts", "Tools", "Secret"])
} else {
    Tabs := MainGui.Add("Tab3", "x0 y10 w750 h330", ["Main", "Settings", "Accounts", "Tools"])
}





ChooseSocketConnect() {
    if (SearcherSelected = "1") {
        SetupClientSocket()
    }
    else if (SearcherSelected = "0") {
        SetupSocket()
    }
}



MainGui.SetFont("s10 bold c000000", "Tahoma")
MainGui.AddText("x10 y40 w120 h20", "Gather Time:")
FieldGatherTimeEdit := MainGui.AddEdit("x140 y40 w300 h20", FieldGatherTime)
FieldGatherTimeEdit.BackColor := "000000"
FieldGatherTimeEdit.SetFont("c000000", "Tahoma")


MainGui.AddText("x550 y40 w120 h20", "Gather:")
MainGui.AddText("x545 y70 w120 h20", "Bug run:")


BasicButtons()

CreditsButton := MainGui.AddButton("x190 y300 w100 h30", "Credits")
CreditsButton.OnEvent('click', Credits)


MainGui.SetFont("s8 bold c000000", "Tahoma")

SecretFunction(*) {
    static clickCount := 0
    clickCount++
    
    if (clickCount == 3) {
        IniWrite("1", "settings.ini", "Settings", "SecretOptionsActive")
        msgbox("Secret options activated, please reopen the program to get the secret options.")
        ; Add your secret functionality here
        clickCount := 0  ; Reset the counter
        MainGui.Show()
    }
}



; Read Candles value from settings.ini
CandlesToggle := IniRead("settings.ini", "Settings", "CandlesToggle", "0")

; Create the checkbox with the appropriate initial state
CheckBoxCandles := MainGui.AddCheckBox("x10 y200 w80 h30 " . (CandlesToggle = "1" ? "Checked" : ""), "Candles")
CheckBoxCandles.OnEvent("Click", ToggleCandles)

ToggleCandles(*) {
    global CheckBoxCandles
    if CheckBoxCandles.Value {
        IniWrite("1", "settings.ini", "Settings", "CandlesToggle")
    } else {
        IniWrite("0", "settings.ini", "Settings", "CandlesToggle")
    }
}


; Read IsHasteToggled value from settings.ini
IsHasteToggled := IniRead("settings.ini", "Settings", "IsHasteToggled", "0")

; Create the checkbox with the appropriate initial state
CheckBoxHaste := MainGui.AddCheckBox("x100 y160 w150 h30 " . (IsHasteToggled = "1" ? "Checked" : ""), "Movespeed Correction")
CheckBoxHaste.OnEvent("Click", ToggleHaste)

ToggleHaste(*) {
    global CheckBoxHaste
    if CheckBoxHaste.Value {
        IniWrite("1", "settings.ini", "Settings", "IsHasteToggled")
    } else {
        IniWrite("0", "settings.ini", "Settings", "IsHasteToggled")
    }
}

; Read value from settings.ini
LidArtToggle := IniRead("settings.ini", "Settings", "LidArtToggle", "0")

; Create the checkbox with the appropriate initial state
CheckBoxLidArt := MainGui.AddCheckBox("x390 y200 w80 h30 " . (LidArtToggle = "1" ? "Checked" : ""), "Lid art")
CheckBoxLidArt.OnEvent("Click", ToggleLidArt)

ToggleLidArt(*) {
    global CheckBoxLidArt
    if CheckBoxLidArt.Value {
        IniWrite("1", "settings.ini", "Settings", "LidArtToggle")
    } else {
        IniWrite("0", "settings.ini", "Settings", "LidArtToggle")
    }
}

; Read Stockings value from settings.ini



Credits(*) {
    MsgBox("Beez Universal Macro`n`nCreated by Beez131`n`nContributers:`n- sharkboy1663`n- _epic.`n- natro macro - ahk discussion`n`nTesters:`n`n`n- ainzsanchez`n- fire_king66`n- cvtm3`n- jrjr0491`n- lucasjack712`n- thomburg`n- vitalgr0`n- yan.15")
}

StockingsToggle := IniRead("settings.ini", "Settings", "StockingsToggle", "0")

; Create the checkbox with the appropriate initial state
CheckBoxStockings := MainGui.AddCheckBox("x100 y200 w100 h30 " . (StockingsToggle = "1" ? "Checked" : ""), "Stockings")
CheckBoxStockings.OnEvent("Click", ToggleStockings)


ToggleStockings(*) {
    global CheckBoxStockings
    if CheckBoxStockings.Value {
        IniWrite("1", "settings.ini", "Settings", "StockingsToggle")
    } else {
        IniWrite("0", "settings.ini", "Settings", "StockingsToggle")
    }
}

KillVicBeeToggle := IniRead("settings.ini", "Settings", "KillVicBeeToggle", "0")

CheckBoxVicBee := MainGui.AddCheckBox("x10 y160 w80 h30 " . (KillVicBeeToggle = "1" ? "Checked" : ""), "Kill Vicious Bees")
CheckBoxVicBee.OnEvent("Click", ToggleVicHop)

; Event handler for the checkbox
ToggleVicHop(*) {
    global CheckBoxVicBee, KillVicBeeToggle
    if CheckBoxVicBee.Value {
        KillVicBeeToggle := 1
    } else {
        KillVicBeeToggle := 0
    }
    ; Automatically save the new value to settings.ini
    IniWrite(KillVicBeeToggle, "settings.ini", "Settings", "KillVicBeeToggle")
}

; Function to save settings


FieldGatherTimeEdit.OnEvent("Change", (*) => SaveSetting("FieldGatherTime", FieldGatherTimeEdit.Value))

SaveSetting(key, value) {
    IniWrite(value, "settings.ini", "Settings", key)
}

; Read Feast value from settings.ini
FeastToggle := IniRead("settings.ini", "Settings", "FeastToggle", "0")

; Create the checkbox with the appropriate initial state
CheckBoxFeast := MainGui.AddCheckBox("x200 y200 w100 h30 " . (FeastToggle = "1" ? "Checked" : ""), "Feast")
CheckBoxFeast.OnEvent("Click", ToggleFeast)

ToggleFeast(*) {
    global CheckBoxFeast
    if CheckBoxFeast.Value {
        IniWrite("1", "settings.ini", "Settings", "FeastToggle")
    } else {
        IniWrite("0", "settings.ini", "Settings", "FeastToggle")
    }
}


; Read Samovar value from settings.ini
SamovarToggle := IniRead("settings.ini", "Settings", "SamovarToggle", "0")

; Create the checkbox with the appropriate initial state
CheckBoxSamovar := MainGui.AddCheckBox("x300 y200 w80 h30 " . (SamovarToggle = "1" ? "Checked" : ""), "Samovar")
CheckBoxSamovar.OnEvent("Click", ToggleSamovar)

ToggleSamovar(*) {
    global CheckBoxSamovar
    if CheckBoxSamovar.Value {
        IniWrite("1", "settings.ini", "Settings", "SamovarToggle")
    } else {
        IniWrite("0", "settings.ini", "Settings", "SamovarToggle")
    }
}



;Gather field-----------------------------------

; Read the saved field choices from settings.ini
IsPinetreeActive := IniRead("settings.ini", "FieldGather", "IsPinetreeActive", "0")
IsPineappleActive := IniRead("settings.ini", "FieldGather", "IsPineappleActive", "0")
IsSunflowerActive := IniRead("settings.ini", "FieldGather", "IsSunflowerActive", "0")
IsStrawberryActive := IniRead("settings.ini", "FieldGather", "IsStrawberryActive", "0")
IsNoneActive := IniRead("settings.ini", "FieldGather", "FieldNone", "0")

; Define the ComboBox with options
ComboBox := MainGui.Add("ComboBox", "x600 y40", ["Pinetree", "Strawberry", "Sunflower", "Pineapple", "None"])

; Set the ComboBox to the saved choice
if (IsPinetreeActive = "1")
    ComboBox.Text := "Pinetree"
else if (IsStrawberryActive = "1")
    ComboBox.Text := "Strawberry"
else if (IsSunflowerActive = "1")
    ComboBox.Text := "Sunflower"
else if (IsPineappleActive = "1")
    ComboBox.Text := "Pineapple"
else if (IsNoneActive = "1")
    ComboBox.Text := "None"





; Function to handle selection change
ComboBox.OnEvent("Change", FieldChoiceChanged)

FieldChoiceChanged(Ctrl, EventInfo)
{
    selected := Ctrl.Text

    IniWrite("0", "settings.ini", "FieldGather", "IsPinetreeActive")
    IniWrite("0", "settings.ini", "FieldGather", "IsPineappleActive")
    IniWrite("0", "settings.ini", "FieldGather", "IsSunflowerActive")
    IniWrite("0", "settings.ini", "FieldGather", "IsStrawberryActive")
    IniWrite("0", "settings.ini", "FieldGather", "FieldNone")

    if (selected = "Pinetree")
        IniWrite("1", "settings.ini", "FieldGather", "IsPinetreeActive")
    else if (selected = "Strawberry")
        IniWrite("1", "settings.ini", "FieldGather", "IsStrawberryActive")
    else if (selected = "Sunflower")
        IniWrite("1", "settings.ini", "FieldGather", "IsSunflowerActive")
    else if (selected = "Pineapple")
        IniWrite("1", "settings.ini", "FieldGather", "IsPineappleActive")
    else if (selected = "None")
        IniWrite("1", "settings.ini", "FieldGather", "FieldNone")
}


;Toggle-Alt-Or-Main-----------------------------------

; Read the saved account type from settings.ini

NoAltSelected := IniRead("settings.ini", "AccountType", "NoAltSelected", "0")
MainAccSelected := IniRead("settings.ini", "AccountType", "MainAccSelected", "0")
SearcherSelected := IniRead("settings.ini", "AccountType", "SearcherSelected", "0")


AccountTypeChanged(Ctrl, EventInfo)
{
    selected := Ctrl.Text

    IniWrite("0", "settings.ini", "AccountType", "NoAltSelected")
    IniWrite("0", "settings.ini", "AccountType", "MainAccSelected")
    IniWrite("0", "settings.ini", "AccountType", "SearcherSelected")

    if (selected = "No Alts")
        IniWrite("1", "settings.ini", "AccountType", "NoAltSelected")
    else if (selected = "Main")
        IniWrite("1", "settings.ini", "AccountType", "MainAccSelected")
    else if (selected = "Searcher")
        IniWrite("1", "settings.ini", "AccountType", "SearcherSelected")
}





;---------------------------------------------

;bug run--------------------------------------

; Define the ComboBox with options and associate it with the variable FieldChoice
ComboBoxBugs := MainGui.Add("ComboBox", "x600 y70 Disabled", ["All bugs", "Ladybugs", "Rhino Beetles", "Mantis", "None"])

; Initialize variables for each option
global AllBugs := 0
global Ladybugs := 0
global RhinoBeetles := 0
global Mantis := 0
global NoBugRun := 0

; Function to handle selection change
ComboBoxBugs.OnEvent("Change", BugRunChanged)

BugRunChanged(Ctrl, EventInfo)
{
    ; Declare global variables within the function scope
    global AllBugs, Ladybugs, RhinoBeetles, Mantis

    ; Get the selected item directly from the ComboBox control
    selected := Ctrl.Text

    ; Reset all variables to 0
    AllBugs := 0
    Ladybugs := 0
    RhinoBeetles := 0
    Mantis := 0
    NoBugRun := 0

    ; Set the corresponding variable to 1 based on the selected item
    if (selected = "All bugs")
        AllBugs := 1
    else if (selected = "Ladybugs")
        Ladybugs := 1
    else if (selected = "Rhino Beetles")
        RhinoBeetles := 1
    else if (selected = "Mantis")
        Mantis := 1
    else if (selected = "None")
        NoBugRun := 1

    ; Optional: Output the current state for testing
    MsgBox("AllBugs: " AllBugs ", Ladybugs: " Ladybugs ", RhinoBeetles: " RhinoBeetles ", Mantis: " Mantis)

}

;CustomSettingsGUI-------------------------------------------

ShowCustomSettingsGUI() {
    CustomGui := Gui("+AlwaysOnTop")
    CustomGui.Add("Text", "x10 y10", "Custom Options:")
    CustomGui.Add("Button", "x10 y40 w100", "Option 1").OnEvent("Click", (*) => MsgBox("Option 1 clicked"))
    CustomGui.Add("Button", "x10 y70 w100", "Option 2").OnEvent("Click", (*) => MsgBox("Option 2 clicked"))
    CustomGui.Show()
}

customButton := MainGui.AddButton("x410 y300 w100 h30", "Custom (F5)")
customButton.OnEvent('click', (*) => ShowCustomSettingsGUI())

;Accounts-page-------------------------------------
Tabs.UseTab("Accounts")
BasicButtons()
MainGui.SetFont("s10 Bold c000000", "Tahoma")
MainGui.AddText("x540 y40 w120 h20", "Account:")
MainGui.AddText("x10 y40 w120 h20", "Port:")
PortEdit := MainGui.AddEdit("x140 y40 w300 h20", Port)
PortEdit.BackColor := "000000"
PortEdit.SetFont("s10 Bold c000000", "Tahoma")

PortEdit.OnEvent("Change", (*) => SaveSetting("port", PortEdit.Value))

ComboBoxAccType := MainGui.Add("ComboBox", "x600 y40", ["No Alts", "Main", "Searcher"])

; Set the ComboBox to the saved choice
if (NoAltSelected = "1")
    ComboBoxAccType.Text := "No Alts"
else if (MainAccSelected = "1")
    ComboBoxAccType.Text := "Main"
else if (SearcherSelected = "1")
    ComboBoxAccType.Text := "Searcher"

; Function to handle selection change
ComboBoxAccType.OnEvent("Change", AccountTypeChanged)

MainGui.SetFont("s12 Bold c000000", "Tahoma")

ActivateSocket := MainGui.AddButton("x600 y100 w120 h20", "Connect")
ActivateSocket.OnEvent('click', (*) => SetupSocket())
MainGui.SetFont("s10 c000000", "Tahoma")
;settings-page-------------------------------------
Tabs.UseTab("Settings")
BasicButtons()

MainGui.AddText("x10 y40 w120 h20", "Movespeed:")
MovespeedEdit := MainGui.AddEdit("x140 y40 w300 h20", PlayerSpeed)
MovespeedEdit.BackColor := "000000"
MovespeedEdit.SetFont("c000000", "Tahoma")

MainGui.AddText("x10 y70 w120 h20", "Discord User ID:")
DiscordIDEdit := MainGui.AddEdit("x140 y70 w300 h20", discordID)
DiscordIDEdit.BackColor := "000000"
DiscordIDEdit.SetFont("c000000", "Tahoma")

DiscordIDEdit.OnEvent("Change", (*) => SaveSetting("discordID", DiscordIDEdit.Value))

MainGui.AddText("x10 y170 w120 h20", "Blocked Exp time:")
BlockedExpEdit := MainGui.AddEdit("x140 y170 w300 h20", DetectBlockedExp)
BlockedExpEdit.BackColor := "000000"
BlockedExpEdit.SetFont("c000000", "Tahoma")

BlockedExpEdit.OnEvent("Change", (*) => SaveSetting("DetectBlockedExp", BlockedExpEdit.Value))

MainGui.SetFont("s10 c000000", "Tahoma")
MainGui.AddText("x10 y100 w120 h20", "Discord Webhook URL:")
URLEdit := MainGui.AddEdit("x140 y100 w300 h20", url)
URLEdit.BackColor := "000000"
URLEdit.SetFont("c000000", "Tahoma")
MainGui.AddText("x10 y130 w120 h20", "Graphics Quality:")


initialGraphics := IniRead("settings.ini", "Settings", "Graphics", "1")

MyEdit := MainGui.Add("Edit", "x140 y130 w50 h20 vMyEdit ReadOnly -TabStop")
MyUpDown := MainGui.Add("UpDown", "vMyUpDown Range1-10", initialGraphics)

MyEdit.OnEvent("Focus", (*) => ControlSend("{Tab}", MyEdit))

MyUpDown.OnEvent("Change", (*) => SaveGraphicsSetting(MyUpDown.Value))

SaveGraphicsSetting(value) {
    IniWrite(value, "settings.ini", "Settings", "Graphics")
}




URLEdit.OnEvent("Change", (*) => SaveSetting("url", URLEdit.Value))


;secret-------------------------------------------------
Tabs.UseTab("Tools")
BasicButtonsOffset()
RunBoostingAssistanceMacro()

StatsButton := MainGui.AddButton("x300 y260 w120 h30", "Show Stats UI")
StatsButton.OnEvent("Click", ShowStatsUI)

ShowStatsUI(*) {
    Run A_ScriptDir "\StatMain.ahk"
}
;--------------------------------------------------------

if (secretOptionsActive = "1") {
    Tabs.UseTab("Secret")
    SecretButton := MainGui.AddButton("x10 y40 w160 h30", "Test Alt-Main Msg")
    SecretButton.OnEvent("Click", SocketMessageTestButtonClicked)

    SecretButton := MainGui.AddButton("x180 y40 w160 h30", "Test Robo Find Pass")
    SecretButton.OnEvent("Click", CheckRoboPass)

    SecretButton := MainGui.AddButton("x350 y40 w160 h30", "Test Read Robo Quest")
    SecretButton.OnEvent("Click", CheckRoboQuestButton)

    CheckRoboPass(*) {
        ActivateRoblox()
        HyperSleep(1000)
        CheckIfRoboPass()
    }

    CheckRoboQuestButton(*) {
        ActivateRoblox()
        HyperSleep(1000)
        CheckRoboQuestText()
    }

    SocketMessageTestButtonClicked(*) {
        NoAltSelected := IniRead("settings.ini", "AccountType", "NoAltSelected")
        MainAccSelected := IniRead("settings.ini", "AccountType", "MainAccSelected")
        SearcherSelected := IniRead("settings.ini", "AccountType", "SearcherSelected")
    
        if (NoAltSelected = "1") {
            MsgBox("No Alt mode selected")
        } else if (MainAccSelected = "1") {
            MsgBox("Main Account mode selected")
            MessageTestSocketMain()
        } else if (SearcherSelected = "1") {
            MsgBox("Searcher mode selected")
            MessageTestSocketAlt()
        } else {
            MsgBox("No specific account type selected")
        }
    }
}
;--------------------------------------------------------

MainGui.Show("w750 h340")

BasicButtons(*) {
    MainGui.SetFont("s8 c000000", "Tahoma")
    StartButton := MainGui.Add("Button", "x10 y300 w80 h30", "Start (F1)")
    StopButton := MainGui.AddButton("x100 y300 w80 h30", "Close (F2)")

    StartButton.OnEvent('click', Start)
    StopButton.OnEvent('click', StopMainMacro)
    FooterLabel := MainGui.AddText("x540 y320 w200 h20 Right -Theme", "v0.0.1")
    FooterLabel.OnEvent("Click", SecretFunction)

}

BasicButtonsOffset(*) {
    MainGui.SetFont("s8 c000000", "Tahoma")
    StartButton := MainGui.Add("Button", "x300 y300 w80 h30", "Start (F1)")
    StopButton := MainGui.AddButton("x390 y300 w80 h30", "Close (F2)")

    StartButton.OnEvent('click', Start)
    StopButton.OnEvent('click', StopMainMacro)
    FooterLabel := MainGui.AddText("x10 y320 w40 h20 Right -Theme", "v0.0.1")
    FooterLabel.OnEvent("Click", SecretFunction)

}

; Start function
Start(*) {
    ; Read the SearcherSelected value from settings.ini
    SearcherSelected := IniRead("settings.ini", "AccountType", "SearcherSelected")
    KillVicBeeToggleSelected := IniRead("settings.ini", "Settings", "KillVicBeeToggle")

    if (SearcherSelected = "1" and KillVicBeeToggleSelected = 1) {
        MsgBox("SearcherSelected and KillVicBeeToggle is set to 1. Running a different command.")
        ; Execute when SearcherSelected is 1
        NoIMGPlayerStatus("Starting Searcher mode", 16776960)
        GetServerIds()
        OnError((e, mode) => (mode = "return") * (-1))
        loop {
            MainLoopSearcher()
        }
    } else if (KillVicBeeToggle = 0) {
        ; Execute when KillVicBeeToggle is 0
        MsgBox("KillVicBeeToggle is set to 0. Running a different command.")
        NoIMGPlayerStatus("Starting v1.0.1 Beez universal macro", 16776960)
        GetServerIds()
        OnError((e, mode) => (mode = "return") * (-1))
        loop {
            MainLoopNonVic()
        }
    } else {
        ; Execute when KillVicBeeToggle is 1
        MsgBox("KillVicBeeToggle is set to 1. Running a different command.")
        NoIMGPlayerStatus("Starting v1.0.1 Beez universal macro", 16776960)
        GetServerIds()
        OnError((e, mode) => (mode = "return") * (-1))
        loop {
            MainLoop()
        }
    }
}

StopMainMacro(*) {
    Send "{" WKey " up}{" AKey " up}{" SKey " up}{" Dkey " up}"
    ExitApp()
}

NoIMGPlayerStatus("Connected to discord!", 3426654)

F1:: {
    ; Read the SearcherSelected value from settings.ini
    SearcherSelected := IniRead("settings.ini", "AccountType", "SearcherSelected")
    KillVicBeeToggleSelected := IniRead("settings.ini", "Settings", "KillVicBeeToggle")

    if (SearcherSelected = "1" and KillVicBeeToggleSelected = 1) {
        MsgBox("SearcherSelected and KillVicBeeToggle is set to 1. Running a different command.")
        ; Execute when SearcherSelected is 1
        NoIMGPlayerStatus("Starting Searcher mode", 16776960)
        GetServerIds()
        OnError((e, mode) => (mode = "return") * (-1))
        loop {
            MainLoopSearcher()
        }
    } else if (KillVicBeeToggle = 0) {
        ; Execute when KillVicBeeToggle is 0
        MsgBox("KillVicBeeToggle is set to 0. Running a different command.")
        StartAllTimers()
        NoIMGPlayerStatus("Starting v1.0.1 Beez universal macro", 16776960)
        GetServerIds()
        OnError((e, mode) => (mode = "return") * (-1))
        loop {
            MainLoopNonVic()
        }
    } else {
        ; Execute when KillVicBeeToggle is 1
        MsgBox("KillVicBeeToggle is set to 1. Running a different command.")
        StartAllTimers()
        NoIMGPlayerStatus("Starting v1.0.1 Beez universal macro", 16776960)
        GetServerIds()
        OnError((e, mode) => (mode = "return") * (-1))
        loop {
            MainLoop()
        }
    }
}

F2:: StopMainMacro()

StopMacros() {
    StopMainMacro()
}
F5:: SetGraphics()

F5testloop() {
    QuestContent := GetQuestContent("A")
    QuestContent := RemoveNumbers(QuestContent)
    ProcessQuestContent(QuestContent)
}


;1044681040465235973


WKey := "sc011" ; w
AKey := "sc01e" ; a
SKey := "sc01f" ; s
Dkey := "sc020" ; d
RotLeft := "sc33" ; ,
RotRight := "vkBE" ; .
RotUp := "sc149" ; PgUp
RotDown := "sc151" ; PgDn
ZoomIn := "sc017" ; i
ZoomOuter := "sc018" ; o
Ekey := "sc012" ; e
Rkey := "sc013" ; r
Lkey := "sc026" ; l
EscKey := "sc001" ; Esc
EnterKey := "sc01c" ; Enter
SpaceKey := "sc039" ; Space
Onekey := "sc002" ; 1
SlashKey := "sc035" ; /
LeftShiftKey := "sc02a" ; Left Shift
RightShiftKey := "sc036" ; Right Shift


NoVicMainLoop() {
    ;
}


MainLoop() {
    while (JoinServer() == 2) {
        HyperSleep(350)
    }


    if (NightDetection() == 1) {
        PlayerStatus("Night Detected!!", 0, false)
        UseFirstLoadFunctions()
        ZoomOut()
        if (StartServerLoop() == 1){
            return
        }
    } else {
        NoIMGPlayerStatus("Searching For Night Servers.", 1752220)
        return
    }

    KillViciousBees()
    return
}

MainLoopSearcher() {
    while (JoinServer() == 2) {
        HyperSleep(350)
    }


    if (NightDetection() == 1) {
        PlayerStatus("Night Detected!!", 0, false)
        UseFirstLoadFunctions()
        ZoomOut()
        ;code to message main
    } else {
        NoIMGPlayerStatus("Searching For Night Servers.", 1752220)
        return
    }

    return
}


MainLoopNonVic() {
    while (JoinServer() == 2) {
        HyperSleep(350)
    }
    StartServerLoop()
    NoIMGPlayerStatus("Joined server successfully.", 2067276)
    ZoomOut()

    ; Run StartServerLoop() only once before entering the main loop

    ; This loop keeps the script running in the current server
    loop {
        UseFirstLoadFunctions()
        UseAllTheTimers()
        PerformFieldActions()
        ResetMainNonVicCharacter()
        ; CollectItems()
        ; CompleteQuests()

        ; Add periodic checks or actions here if needed
        ;Sleep 60000  ; Wait for 1 minute before next iteration
    }
}

KillViciousBees() {
    if (CheckIfDefeated() == 1 || VicActivated() == 1) {
        PlayerStatus("Vicious bee has already been defeated...", 2123412, false)
        return
    } else if (PictureImageSearch("img\stickbug.png", 26)) {
        PlayerStatus("Leaving server because StickBug confuses VicHopMacro", 2123412, false)
    }
    UseAllTheTimers()
    NoIMGPlayerStatus("Going to Pepper Patch.", 2067276)
    PepperPatch()
    PlayerStatus("Finished Checking Pepper Patch.", 5763719, false)

    loopresult := VIciousAttackLoop(3)
    if (loopresult == 3) {
        if (ResetMainCharacter() == false) {

            return
        }
        PepperPatch()
        VIciousAttackLoop(3)
        return
    } else if (loopresult == 1) {
        Sleep 1
    } else {
        return
    }


    if (ResetMainCharacter() == false) {
        return
    }

    if (CheckIfDefeated() == 1 || VicActivated() == 1) {
        PlayerStatus("Vicious bee has already been defeated...", 2123412, false)
        return
    } else if (PictureImageSearch("img\stickbug.png", 26)) {
        PlayerStatus("Leaving server because StickBug confuses VicHopMacro", 2123412, false)
    }
    UseAllTheTimers()
    NoIMGPlayerStatus("Going to Mountain Top Feild.", 2067276)
    MountainTop()
    PlayerStatus("Finished Checking Mountain Top Feild.", 5763719, false)
    loopresult := VIciousAttackLoop(2)
    if (loopresult == 3) {
        if (ResetMainCharacter() == false) {
            return
        }
        MountainTop()
        VIciousAttackLoop(2)
        return
    } else if (loopresult == 1) {
        Sleep 1
    } else {
        return
    }


    if (ResetMainCharacter() == false) {
        return
    }
    if (CheckIfDefeated() == 1 || VicActivated() == 1) {
        PlayerStatus("Vicious bee has already been defeated...", 2123412, false)
        return
    } else if (PictureImageSearch("img\stickbug.png", 26)) {
        PlayerStatus("Leaving server because StickBug confuses VicHopMacro", 2123412, false)
    }

    UseAllTheTimers()
    NoIMGPlayerStatus("Going to Rose Feild.", 2067276)
    Rose()
    PlayerStatus("Finished Checking Rose Feild.", 5763719, false)
    loopresult := VIciousAttackLoop()
    if (loopresult == 3) {
        if (ResetMainCharacter() == false) {
            return
        }
        Rose()
        VIciousAttackLoop()
        return
    } else if (loopresult == 1) {
        Sleep 1
    } else {
        return
    }


    if (ResetMainCharacter() == false) {
        return
    }

    NoIMGPlayerStatus("Going to Cactus Feild.", 2067276)
    if (CheckIfDefeated() == 1 || VicActivated() == 1) {
        PlayerStatus("Vicious bee has already been defeated...", 2123412, false)
        return
    } else if (PictureImageSearch("img\stickbug.png", 26)) {
        PlayerStatus("Leaving server because StickBug confuses VicHopMacro", 2123412, false)
    }
    UseAllTheTimers()
    ;
    Cactus()
    PlayerStatus("Finished Checking Cactus feild.", 5763719, false)
    loopresult := VIciousAttackLoop()
    if (loopresult == 3) {
        if (ResetMainCharacter() == false) {
            return
        }
        Cactus()
        VIciousAttackLoop()
        return
    } else if (loopresult == 1) {
        Sleep 1
    } else {
        return
    }
    NoIMGPlayerStatus("No Vicious bees found...", 8359053)
}

JoinServer() {
    ActivateRoblox()
    SetKeyDelay 100
    send "{esc}{l}{Enter}"
    SetKeyDelay KeyDelay
    joinrandomserver()
    if (DetectLoading(0x2257A8, DetectBlockedExp)) {
        Sleep 850
        return 1
    } else {
        return 2
    }
}

MovespeedEdit.OnEvent("Change", (*) => SaveSetting("movespeed", MovespeedEdit.Value))