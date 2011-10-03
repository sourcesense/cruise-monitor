Set voice = CreateObject("sapi.spvoice")
message = WScript.Arguments.Item(0)

voice.speak message