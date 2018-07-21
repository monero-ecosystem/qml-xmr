function setCustomWindowDecorations(bool){
	console.log("mocked function_call: " + arguments.callee.name);
}

var flags = (Qt.WindowSystemMenuHint | Qt.Window | Qt.WindowMinimizeButtonHint | Qt.WindowCloseButtonHint | Qt.WindowTitleHint | Qt.WindowMaximizeButtonHint);
var flagsCustomDecorations = (Qt.FramelessWindowHint | Qt.WindowSystemMenuHint | Qt.Window | Qt.WindowMinimizeButtonHint);