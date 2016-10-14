#include "libraryEN.au3"
#include <GUIConstantsEx.au3>

#Region Setup
Global $guiMsg
$guiHandler = GUICreate("TravianBot v2", 800, 600, -1, -1)
$loginButton = GUICtrlCreateButton("login", 50, 550, 50)
$userName = GUICtrlCreateInput("BotCentral000", 120, 550, 150)
$password = GUICtrlCreateInput("123546798", 300, 550, 150)
$serverURL = GUICtrlCreateInput("http://tx3.travian.com/", 600, 550, 150)
$funcButton = GUICtrlCreateButton("Run", 50, 500, 150)
$funcInput = GUICtrlCreateInput("", 250, 500, 500)
GUISetState(@SW_SHOW)
#EndRegion
;Global $deleteMe = False
;Global $firstTime = True
While(1)
$guiMsg = GUIGetMsg();updates gui state, incorporates a delay
#Region GUI
Switch($guiMsg)
   Case $loginButton
		login(GuiCtrlread($userName), GUICtrlRead($password), GUICtrlRead($serverURL))
		_SQLite_Startup() ; inicia ligação à base de dados
		;thinkV01() ; The Most Powerful Function Ever
		;_SQLite_Shutdown()
	Case $GUI_EVENT_CLOSE
		ExitLoop
	Case $funcButton
		Local $funcParams = StringSplit(GUICtrlRead($funcInput), ",", 2)
		Local $funcName = $funcParams[0]
		$funcParams[0] = "CallArgArray"
		For $i=1 To Ubound($funcParams)-1
			$funcParams[$i] = $funcParams[$i]
		Next
		If Ubound($funcParams) > 1 Then
		   Call($funcName, $funcParams)
		Else
		   Call($funcName)
		   EndIf
	Case $GUI_EVENT_CLOSE
		ExitLoop
	Case $funcButton
		callFunc(StringSplit(GUICtrlRead($funcInput), ",", 2)); don't worry, it works
EndSwitch
#EndRegion
;If $deleteMe == True Then
;
;	$firstTime = thinkV01($firstTime)
;	EndIf
WEnd

