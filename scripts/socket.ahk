/*************************************************************************
* @file Socket.ahk
* @author made by bentschi, improved by GeekDude, converted by ninju
* @date 02/29/2024
* @version 0.0.1
*************************************************************************/

class Socket {
	__New(socket := -1) {
		this.WM_SOCKET := 0x6969,this.MSG_PEEK := 2,this.FD_READ := 1, this.FD_ACCEPT := 8, this.FD_CLOSE := 32,this.Blocking := True,this.BlockSleep := 50,this.onRecv := this.tempFunc.bind(this),this.onAccept:=this.tempFunc.bind(this),this.OnDisconnect:=this.tempFunc.bind(this),this.bound:="",this.socketType:=0,this.ProtocolId:=0
		static init := 0
		if (!init){
			DllCall("LoadLibraryA", "Str", "ws2_32", "ptr")
			this.WSAData:=Buffer(394+A_PtrSize)
			if(err := DllCall("ws2_32\WSAStartup", "ushort", 0x202, "ptr", this.WSAData.ptr))
				throw("couldnt start socket: " err)
			if(NumGet(this.WSAData,2, "ushort")!=514)
				throw("ws2.2 is not available")
			init := 1
		}
		this.socket := socket
	}
	__Delete() {
		if(this.socket != -1)
			this.Disconnect()
	}
	Connect(Address)
	{
		if (this.Socket != -1)
			throw("Socket already connected")
		Next := pAddrInfo := this.GetAddrInfo(Address)
		while Next
		{
			ai_addrlen := NumGet(Next+0, 16, "UPtr")
			ai_addr := NumGet(Next+0, 16+(2*A_PtrSize), "Ptr")
			if ((this.Socket := DllCall("Ws2_32\socket", "Int", NumGet(Next+0, 4, "Int")
				, "Int", this.SocketType, "Int", this.ProtocolId, "UInt")) != -1)
			{
				if (DllCall("Ws2_32\WSAConnect", "UInt", this.Socket, "Ptr", ai_addr
					, "UInt", ai_addrlen, "Ptr", 0, "Ptr", 0, "Ptr", 0, "Ptr", 0, "Int") == 0)
				{
					DllCall("Ws2_32\freeaddrinfo", "Ptr", pAddrInfo) ; TODO: Error Handling
					return this.EventProcRegister(this.FD_READ | this.FD_CLOSE)
				}
				this.Disconnect()
			}
			Next := NumGet(Next+0, 16+(3*A_PtrSize), "Ptr")
		}
		throw("Error connecting")
	}
	getAddrInfo(address) {
		Hints := Buffer(16+(4*A_PtrSize),0)
		NumPut("Int", this.SocketType, hints, 8)
		NumPut("Int", this.ProtocolId, hints, 12)
		if(err:=DllCall("ws2_32\getaddrinfo", "astr", address[1], "astr", (address[2] ""), "uPtr", Hints.ptr, "ptr*", &result:=0))
			throw("getAddrInfo: " err)
		return result
	}
	Disconnect(){
		if this.socket ==-1
			return 0
		this.EventProcUnregister()
		if (DllCall("Ws2_32\closesocket", "UInt", this.Socket, "Int") == -1)
			throw "Error closing socket"
		this.Socket := -1
		return 1
	}
	EventProcRegister(lEvent)
	{
		this.AsyncSelect(lEvent)
		if !this.Bound
		{
			this.Bound := this.msgHandler.Bind(this)
			OnMessage(this.WM_SOCKET,this.bound)
		}
	}
	AsyncSelect(lEvent)
	{
		if (DllCall("Ws2_32\WSAAsyncSelect"
			, "UInt", this.Socket    ; s
			, "Ptr", A_ScriptHwnd    ; hWnd
			, "UInt", this.WM_SOCKET ; wMsg
			, "UInt", lEvent) == -1) ; lEvent
			throw "Error calling WSAAsyncSelect: " this.GetLastError()
	}
	GetLastError() => DllCall("Ws2_32\WSAGetLastError")
	EventProcUnregister()
	{
		this.AsyncSelect(0)
		if this.Bound
		{
			OnMessage(this.WM_SOCKET, this.Bound, 0)
			this.Bound := False
		}
	}
	msgHandler(wParam, lParam, Msg, hWnd)
	{
		Critical
		if (Msg != this.WM_SOCKET || wParam != this.Socket)
			return
		if (lParam & this.FD_READ)
			(this.onRecv)()
		else if (lParam & this.FD_ACCEPT)
			this.onAccept()
		else if (lParam & this.FD_CLOSE)
			this.EventProcUnregister(), this.OnDisconnect.call(this)
	}
	RecvText(BufSize:=0, Flags:=0, Encoding:="UTF-8")
	{
		if (Length := this.Recv(&Buffers, BufSize, flags))
			return StrGet(Buffers, Length, Encoding)
		return ""
	}
	Recv(&Buff, BufSize:=0, Flags:=0)
	{
		while (!(Length := this.MsgSize()) && this.Blocking)
			Sleep this.BlockSleep
		if !Length
			return 0
		if (!BufSize)
			BufSize := Length
		Buff := Buffer(BufSize)
		if ((r := DllCall("Ws2_32\recv", "UInt", this.Socket, "uPtr", Buff.ptr, "Int", BufSize, "Int", Flags)) == -1)
			throw "Error calling recv: " this.GetLastError()
		return r
	}
	SendText(Text, Flags:=0, Encoding:="UTF-8")
	{
		Buff := Buffer(StrPut(Text, Encoding) * ((Encoding="UTF-16"||Encoding="cp1200") ? 2 : 1))
		Length := StrPut(Text, Buff, Encoding)
		return this.Send(Buff, Length - 1)
	}
	Send(pBuffer, BufSize, Flags:=0)
	{
		if ((r := DllCall("Ws2_32\send", "UInt", this.Socket, "Ptr", pBuffer, "Int", BufSize, "Int", Flags)) == -1)
			throw "Error calling send: " this.GetLastError()
		return r
	}
	MsgSize()
	{
		static FIONREAD := 0x4004667F
		if (DllCall("Ws2_32\ioctlsocket", "UInt", this.Socket, "UInt", FIONREAD, "UInt*", &argp:=0) == -1)
			throw "Error calling ioctlsocket: " this.GetLastError()
		return argp
	}
	Accept()
	{
		if ((s := DllCall("Ws2_32\accept", "UInt", this.Socket, "Ptr", 0, "Ptr", 0, "Ptr")) == -1)
			throw "Error calling accept:" this.GetLastError()
		Sock := Socket(s)
		Sock.ProtocolId := this.ProtocolId
		Sock.SocketType := this.SocketType
		Sock.EventProcRegister(this.FD_READ | this.FD_CLOSE)
		return Sock
	}
	Listen(backlog:=32) => DllCall("Ws2_32\listen", "UInt", this.Socket, "Int", backlog) == 0
	Bind(Address)
	{
		if (this.Socket != -1)
			throw "Socket already connected"
		Next := pAddrInfo := this.GetAddrInfo(Address)
		while Next
		{
			ai_addrlen := NumGet(Next+0, 16, "UPtr")
			ai_addr := NumGet(Next+0, 16+(2*A_PtrSize), "Ptr")
			if ((this.Socket := DllCall("Ws2_32\socket", "Int", NumGet(Next+0, 4, "Int")
				, "Int", this.SocketType, "Int", this.ProtocolId, "UInt")) != -1)
			{
				if (DllCall("Ws2_32\bind", "UInt", this.Socket, "Ptr", ai_addr
					, "UInt", ai_addrlen, "Int") == 0)
				{
					DllCall("Ws2_32\freeaddrinfo", "Ptr", pAddrInfo) ; TODO: ERROR HANDLING
					return	this.EventProcRegister(this.FD_READ | this.FD_ACCEPT | this.FD_CLOSE)
				}
				this.Disconnect()
			}
			Next := NumGet(Next+0, 16+(3*A_PtrSize), "Ptr")
		}
		throw "Error binding"
	}
	tempFunc(*) => 1
}
class SocketTCP extends Socket
{
	static ProtocolId := 6 ; IPPROTO_TCP
	static SocketType := 1 ; SOCK_STREAM
}

class SocketUDP extends Socket
{
	static ProtocolId := 17 ; IPPROTO_UDP
	static SocketType := 2  ; SOCK_DGRAM
	
	SetBroadcast(Enable)
	{
		static SOL_SOCKET := 0xFFFF, SO_BROADCAST := 0x20
		if (DllCall("Ws2_32\setsockopt"
			, "UInt", this.Socket ; SOCKET s
			, "Int", SOL_SOCKET   ; int    level
			, "Int", SO_BROADCAST ; int    optname
			, "UInt*", !!Enable   ; *char  optval
			, "Int", 4) == -1)    ; int    optlen
			throw("Error calling setsockopt: " this.GetLastError())
	}
}