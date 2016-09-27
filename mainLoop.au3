#include "library.au3"
#include <GUIConstantsEx.au3>

Global $guiMsg
$guiHandler = GUICreate("TravianBot v2", 800, 600, -1, -1)
$loginButton = GUICtrlCreateButton("login", 50, 550, 50)
$userName = GUICtrlCreateInput("BotCentral000", 120, 550, 150)
$password = GUICtrlCreateInput("123456789", 300, 550, 150)
$serverURL = GUICtrlCreateInput("http://tx3.travian.pt/", 600, 550, 150)
GUISetState(@SW_SHOW)

While(1)
$guiMsg = GUIGetMsg()
Switch($guiMsg)
	Case $loginButton
		login(GuiCtrlread($loginButton), GUICtrlRead($password), GUICtrlRead($serverURL))
	Case $GUI_EVENT_CLOSE
		ExitLoop
		EndSwitch
	WEnd

	;doTutorial()