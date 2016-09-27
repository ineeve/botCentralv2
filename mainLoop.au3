#include "library.au3"
#include <GUIConstantsEx.au3>

Global $guiMsg
$guiHandler = GUICreate("TravianBot v2", 800, 600, -1, -1)
$loginButton = GUICtrlCreateButton("login", 50, 550)
GUISetState(@SW_SHOW)

While(1)
$guiMsg = GUIGetMsg()
Switch($guiMsg)
	Case $loginButton
		login("BotCentral009", "141592653589", "http://tx3.travian.pt/")
	Case $GUI_EVENT_CLOSE
		ExitLoop
		EndSwitch
	WEnd

	;doTutorial()