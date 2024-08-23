#Requires AutoHotkey v2
#SingleInstance force

#include %A_ScriptDir%\scripts\

#Include functions.ahk



ImageToText(KeyCombo) {
    FileDelete A_ScriptDir "\ImageFromText.txt"
    FileAppend "", A_ScriptDir "\ImageFromText.txt"    


    Run A_ScriptDir "\Capture2Text\Capture2Text.exe"
    ;MouseMove(100, 100)
    ;Sleep 5000
    Send KeyCombo
}




TextVariableQuestA := ""
TextVariableQuestB := ""
global TextVariable := ""

UpdateTextVariable() {
    try {
        if (WhatQuestSearching == "A") {
            TextVariable := FileRead(A_ScriptDir "\ImageFromText.txt")
            ;MsgBox(TextVariable . "A")
            IniWrite(TextVariable, "RoboQuests.ini", "Settings", "QuestTextA")
        }

        if (WhatQuestSearching == "B") {
            TextVariable := FileRead(A_ScriptDir "\ImageFromText.txt")
            ;MsgBox(TextVariable . "B")
            IniWrite(TextVariable, "RoboQuests.ini", "Settings", "QuestTextB")
        }
    }
}



SplitRoboQuestsA() {
    QuestContent := GetQuestContent("A")
    QuestContent := RemoveNumbers(QuestContent)
    ProcessQuestContent(QuestContent)
}

SplitRoboQuestsB() {
    QuestContent := GetQuestContent("B")
    QuestContent := RemoveNumbers(QuestContent)
    ProcessQuestContent(QuestContent)
    
}

GetQuestContent(questType) {
    FileContent := FileRead("RoboQuests.ini")
    Lines := StrSplit(FileContent, "`n", "`r")
    QuestContent := ""
   
    inQuest := false
    for line in Lines {
        if (InStr(line, "QuestText" . questType . "=")) {
            inQuest := true
            QuestContent := SubStr(line, InStr(line, "=") + 1)
        } else if (inQuest && !InStr(line, "[")) {
            QuestContent .= "`n" line
        } else if (inQuest) {
            break
        }
    }
    return QuestContent
}

ProcessQuestContent(QuestContent) {
    ; Split the content into main parts
    MainParts := StrSplit(QuestContent, ".", , 4)
   
    ; Initialize variables
    QuestTitle := Trim(MainParts[1])
    FirstTask := ""
    SecondTask := ""
    ThirdTask := ""
   
    ; Handle tasks
    if (MainParts.Length >= 2)
        FirstTask := Trim(MainParts[2])
    if (MainParts.Length >= 3)
        SecondTask := Trim(MainParts[3])
    if (MainParts.Length >= 4)
        ThirdTask := Trim(MainParts[4])
   
    ; Prepare the message
    Message := "Quest: " QuestTitle
    if (FirstTask != "")
        Message .= "`nFirst Task: " FirstTask
    if (SecondTask != "")
        Message .= "`nSecond Task: " SecondTask
    if (ThirdTask != "")
        Message .= "`nThird Task: " ThirdTask
   
    MsgBox(Message)
}





RemoveNumbers(text) {
    text := RegExReplace(text, "-", ".")
    text := RegExReplace(text, "\d+,?\s*", "")
    text := RegExReplace(text, "\s*,\s*", " ")
    return Trim(text)
}

ReloadRoboQuestFile() {
    FileDelete A_ScriptDir "\RoboQuests.ini"
    FileAppend "", A_ScriptDir "\RoboQuests.ini"
}
    

CheckRoboQuestText() {
    ReloadRoboQuestFile()
    if PictureImageSearchItem("img/questa.png", 32) {
        global WhatQuestSearching := "A"
        MouseGetPos(&x, &y)
        MouseMove(x + -30, y - 20)
        ;PickQuestAorB()
        HyperSleep(500)
        ImageToText("#s")
        HyperSleep(1000)
        UpdateTextVariable()
        HyperSleep(500)
        SplitRoboQuestsA()
    }
    if PictureImageSearchItem("img/questb.png", 32) {
        global WhatQuestSearching := "B"
        MouseGetPos(&x, &y)
        MouseMove(x + -30, y - 20)
        ;PickQuestAorB()
        HyperSleep(500)
        ImageToText("#s")
        HyperSleep(1000)
        UpdateTextVariable()
        HyperSleep(1000)
        SplitRoboQuestsB()
    }
}

;IniWrite("0", "settings.ini", "RoboBear", "QuestText")