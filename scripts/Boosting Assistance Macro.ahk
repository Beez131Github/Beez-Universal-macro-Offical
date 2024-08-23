    RunBoostingAssistanceMacro() {
        Hotkey("F4", (*) => StartBoostMacro())
        Hotkey("F3", (*) => StopBoostMacro())


        global running := false
        global HotbarSlot := [0, 0, 0, 0, 0, 0, 0]
        global HotbarInterval := [0, 0, 0, 0, 0, 0, 0]
        ; Load settings
        settingsFile := A_ScriptDir . "\tool_settings.ini"
        if (FileExist(settingsFile)) {
            Loop 7 {
                HotbarSlot[A_Index] := Integer(IniRead(settingsFile, "Settings", "Slot" . A_Index, "0"))
                HotbarInterval[A_Index] := Integer(IniRead(settingsFile, "Settings", "Interval" . A_Index, "0"))
            }
        }


        MainGui.SetFont("s10 norm", "Segoe UI")
        MainGui.Add("GroupBox", "x10 y40 w280 h280", "Hotbar Slots")
        yPos := 65
        Loop 7 {
            isChecked := HotbarSlot[A_Index] ? "Checked" : ""
            MainGui.Add("Checkbox", "x20 y" . yPos . " w150 vSlot" . A_Index . " " . isChecked, "Hotbar Slot " . A_Index)
            MainGui.Add("Edit", "x180 y" . yPos . " w50 vInterval" . A_Index, HotbarInterval[A_Index])
            MainGui.Add("Text", "x235 y" . (yPos+3) . " w50", "sec")
            yPos += 35
        }
        MainGui.SetFont("s8 bold c000000", "Tahoma")
        ToggleButton := MainGui.Add("Button", "x570 y300 w80 h30", "Start (F4)")
        ToggleButton.OnEvent("Click", (*) => StartBoostMacro())

        CloseButton := MainGui.Add("Button", "x480 y300 w80 h30", "Stop (F3)")
        CloseButton.OnEvent("Click", (*) => StopBoostMacro())


        SaveTools := MainGui.Add("Button", "x660 y300 w80 h30", "Save")
        SaveTools.OnEvent("Click", (*) => SaveToolSettings(HotbarSlot, HotbarInterval, settingsFile, MainGui))

        MainGui.SetFont("s8", "Segoe UI")
        MainGui.Add("Text", "x10 y500 w280 Center", "Made by beez131 and more")

        MainGui.Show("w300 h530")

        SaveToolSettings(HotbarSlot, HotbarInterval, settingsFile, MainGui) {
            MainGui.Submit(false)  ; Save the current state of all controls

            Loop 7 {
                slotEnabled := MainGui["Slot" . A_Index].Value
                intervalSec := MainGui["Interval" . A_Index].Value

                HotbarSlot[A_Index] := slotEnabled
                HotbarInterval[A_Index] := intervalSec

                IniWrite(slotEnabled ? "1" : "0", settingsFile, "Settings", "Slot" . A_Index)
                IniWrite(intervalSec, settingsFile, "Settings", "Interval" . A_Index)
            }

            MsgBox("Settings saved successfully!")
        }

        StartBoostMacro() {
            global running
            if (!running) {
                running := true
                MainGui.Submit(false)  ; Save the current state of all controls
                Loop 7 {
                    slotEnabled := MainGui["Slot" . A_Index].Value
                    intervalSec := MainGui["Interval" . A_Index].Value
                    HotbarSlot[A_Index] := slotEnabled
                    HotbarInterval[A_Index] := intervalSec
                    if (slotEnabled) {
                        SetTimer(PressKey.Bind(A_Index), intervalSec * 1000)
                    }
                }
            }
        }
        
        StopBoostMacro() {
            global running
            if (running) {
                running := false
                Loop 7 {
                    SetTimer((*) => PressKey(A_Index), 0)
                }
            }
        }
        

        PressKey(index) {
            if (running && HotbarSlot[index]) {
                Send(index)
            }
        }
    }
