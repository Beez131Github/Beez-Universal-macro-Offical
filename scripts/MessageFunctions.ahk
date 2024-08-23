#Include socket.ahk

; Set up the global error handler with an anonymous function
;onError (e, mode) => mode = "return" ? -1 : 0

global mySock := ""
global Port
Port := IniRead("settings.ini", "Settings", "port")


SetupSocket() {
    MsgBox("Setting up socket..." . port)
    global mySock := SocketTCP()
    mySock.OnAccept := AcceptFunc
    mySock.OnRecv := ReceiveMessage
    mySock.Bind(["127.0.0.1", Port])
    mySock.Listen()
    MsgBox("Socket setup complete.")
}

SetupClientSocket() {
    MsgBox("Setting up client socket... " . port)
    global mySock := SocketTCP()
    mySock.OnRecv := ReceiveMessage
    mySock.Connect(["127.0.0.1", Port])
    MsgBox("Client socket connected to server.")
}

ReadAndDisplayMessage() {
    if (mySock.MsgSize() > 0) {
        message := mySock.RecvText()
        MsgBox("Received message: " . message)
    }
}


SendMessage(message) {
    mySock.SendText(message)
}

ReceiveMessage() {
    return mySock.RecvText()
}

AcceptFunc(socket := 0, event := 0) {
    Client := mySock.accept()
    Client.SendText("hi")
}
GenerateNightCode() {
    return Format("{:08X}", Random(0, 0xFFFFFFFF))
}

SendNightCode() {
    if (InStr(ReceiveMessage(), "night", true)) {
        nightCode := GenerateNightCode()
        SendMessage(nightCode)
        return nightCode
    }
    return ""
}


ReceiveNightMessage() {
    message := mySock.RecvText()
    if (InStr(message, "NightCode:", true) == 1) {
        nightCode := SubStr(message, 11)
        ; Store the night code in a variable or use it as needed
        return "Night code received: " . nightCode
    }
    return message
}

MessageTestSocketAlt() {
    SendMessage("Test message from alt")
    MsgBox("Message sent to server")
}


MessageTestSocketMain() {
    message := ReceiveMessage()
    MsgBox("Received message: " . message)
}
