#Requires AutoHotkey v2.0

nowUnix() {
    return DateDiff(A_NowUTC, "19700101000000", "Seconds")
}

global LastStockings := nowUnix()
global LastFeast := nowUnix()
global LastCandles := nowUnix()
global LastSamovar := nowUnix()
global LastLidArt := nowUnix()

Checker() {
    global LastStockings, LastFeast, LastCandles, LastSamovar, LastLidArt

    ; 1 = 1s
    StockingsTimer := 1    ; 1 hour
    FeastTimer := 5400        ; 1.5 hours
    CandlesTimer := 14400     ; 4 hours
    SamovarTimer := 21600     ; 6 hours
    LidArtTimer := 28800      ; 8 hours

    currentTime := nowUnix()

    if (currentTime - LastStockings >= StockingsTimer && BeesmasChecked("Stockings")) {
        MsgBox("1 hour has passed since LastStockings")
        LastStockings := currentTime
    }
    if (currentTime - LastFeast >= FeastTimer && BeesmasChecked("Feast")) {
        MsgBox("1.5 hours have passed since LastFeast")
        LastFeast := currentTime
    }
    if (currentTime - LastCandles >= CandlesTimer && BeesmasChecked("Candles")) {
        MsgBox("4 hours have passed since LastCandles")
        LastCandles := currentTime
    }
    if (currentTime - LastSamovar >= SamovarTimer && BeesmasChecked("Samovar")) {
        MsgBox("6 hours have passed since LastSamovar")
        LastSamovar := currentTime
    }
    if (currentTime - LastLidArt >= LidArtTimer && BeesmasChecked("LidArt")) {
        MsgBox("8 hours have passed since LastLidArt")
        LastLidArt := currentTime
    }
}


BeesmasChecked(value){
    if (IniRead("settings.ini", "Settings", value) == 1)[
        MsgBox("The person has this ssetting turned on lol")
    ]
}

Checker()