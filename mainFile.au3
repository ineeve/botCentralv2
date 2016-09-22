#include <FF.au3>
#include <MsgBoxConstants.au3>
#include <array.au3>
#include <File.au3>
#include <SQLite.au3>
#include <SQLite.dll.au3>

$username = "BotCentral000"
$pass = "123456789"

_SQLite_Startup()
ConsoleWrite("_SQLite_LibVersion=" & _SQLite_LibVersion() & @CRLF)
Local $hDskDb = _SQLite_Open(@WorkingDir & "\travian.db")
Local $hQuery, $aRow, $sMsg
_SQLite_Query ( -1, "Select f,pop From x_world Where a=3199;", $hQuery )
MsgBox(0, 0, $hQuery)
While _SQLite_FetchData($hQuery, $aRow) = $SQLITE_OK
    $sMsg &= $aRow[0]
	MsgBox(0, 0, $sMsg)
WEnd

_SQLite_Close()
_SQLite_Shutdown()
#comments-start
_FFStart(Default,Default,Default,True)
Global $hFF = _FFConnect();connects to MozRepl in Firefox Browser

Func login()
	_FFOPenURL("http://tx3.travian.pt/")
_FFSetValue($pass,_FFObjGet("password","name"))
_FFSetValue($username,_FFObjGet("name","name"))
_FFClick("s1","id")
EndFunc
Func getCValue()
   $getCURL = "/build.php?id=1"
   _FFOpenURL($getCURL)
   $cValue = _FFCmd(".getElementsByClassName('green build')[0].getAttribute('onclick').substring(40,46);")
   ;MsgBox(0,"",$cValue)
   return $cValue
EndFunc
Func getResourcesId(); deprecated, valve, please fix
   _FFOpenURL("/dorf1.php")
   Local $resourcesArray[20]
   For $i = 0 To 17
   $resourcesArray[$i] = _FFCMD(".getElementsByTagName('Area')["&$i&"].alt.substring(0,1)")
Next
return $resourcesArray
   EndFunc
Func getIdOfTheLowestLevelField($fieldName)
	_FFOpenURL("/dorf1.php")
   $resourcesArray = getResourcesId()
   Local $levelArray[10]
   $idOfTheLowestLevelField = -1
   $lowestLevel = 255
   $j = 0
   For $i = 0 To 17
	  if $fieldName == $resourcesArray[$i] Then
		$lvlOfCurrentId = _FFCMD(".getElementsByTagName('Area')["&$i&"].alt.match(/\d+/)[0]")
		 if $lvlOfCurrentId < $lowestLevel Then
			$idOfTheLowestLevelField = $i + 1
			$lowestLevel = $lvlOfCurrentId
			EndIf
	  EndIf
   Next
   return $idOfTheLowestLevelField
EndFunc
func upgradeField($fieldName, $optionalId =-1 )
   Local  $idOfTheLowestLevelField
   if ($optionalId == -1) Then
	  $idOfTheLowestLevelField = getIdOfTheLowestLevelField($fieldName)
   Else
	  $idOfTheLowestLevelField = $optionalId
   EndIf
   $cValue = getCValue()
   $url = "/dorf1.php?a="&$idOfTheLowestLevelField&"&c="&$cValue
   _FFOpenURL($url)
EndFunc
Func buildBuilding($buildingName,$buildingId = -1,$aValue = -1)
   $cValue = getCValue()
   _FFOpenURL("/dorf2.php")
   if ($aValue == -1 And $buildingId == -1) Then
	  switch $buildingName
	  case "armazem"
		 $aValue = 10
		 $buildingId = 19
	  case "celeiro"
		 $aValue=11
		 $buildingId=20
	  case "esconderijo"
		 $aValue=23
		 $buildingId=21
	  case "embaixada"
		 $aValue = 18
		 $buildingId=22
	  case "armadilhas"
		 $aValue=36
		 $buildingId=23
	  case "mercado"
		 $aValue = 17
		 $buildingId=24
	  case "residencia"
		 $aValue = 25
		 $buildingId=25
	  case "palacio"
		 $aValue = 26
		 $buildingId =25
	  case "pedreiro"
		 $aValue = 34
		 $buildingId =27
	  case "tesouraria"
		 $aValue = 27
		 $buildingId = 28
	  case "quartel"
		 $aValue = 19
		 $buildingId = 29
	  case "mansaoHeroi"
		 $aValue = 37
		 $buildingId = 30
	  case "academia"
		 $aValue = 22
		 $buildingId = 31
	  case "cavalarica"
		 $aValue = 20
		 $buildingId = 32
	  case "oficina"
		 $aValue = 21
		 $buildingId =33
	  case "moinho"
		 $aValue = 8
		 $buildingId = 34
	  case "serracao"
		 $aValue =5
		 $buildingId = 35
	  case "alvenaria"
		 $aValue =6
		 $buildingId = 36
	  case "fundicao"
		 $aValue =6
		 $buildingId = 36
	  case "padaria"
		 $aValue =9
		 $buildingId = 37
	  case "grandeArmazem"
		 $aValue =38
		 $buildingId = 38
	  case "palicada"
		 $aValue = 33
		 $buildingId =40
	  case "prm"
		 $aValue = 16
		 $buildingId = 39

	  EndSwitch

   EndIf


   $url = "/dorf2.php?a="&$aValue&"&id="&$buildingId&"&c="&$cValue
   sleep(500)
   _FFOpenURL($url)
EndFunc
Func upgradeBuilding($aValue)
   $cValue = getCValue()
   $url = "/dorf2.php?a="&$aValue&"&c="&$cValue
   _FFOpenURL($url)
EndFunc
Func getBuildingLvl($buildingName,$buildingId = -1)
   _FFOpenURL("/dorf2.php")
   if $buildingId == -1 Then
	  switch $buildingName
	  case "armazem"
		 $buildingId = 0
	  case "celeiro"
		 $buildingId=1
	  case "esconderijo"
		 $buildingId=2
	  case "embaixada"
		 $buildingId=3
	  case "armadilhas"
		 $buildingId=4
	  case "mercado"
		 $buildingId=5
	  case "residencia"
		 $buildingId=6
	  case "palacio"
		 $buildingId =6
	  case "edificioPrincipal"
		 $buildingId = 7
	  case "pedreiro"
		 $buildingId =8
	  case "tesouraria"
		 $buildingId = 29
	  case "quartel"
		 $buildingId = 10
	  case "mansaoHeroi"
		 $buildingId = 1
	  case "academia"
		 $buildingId = 12
	  case "cavalarica"
		 $buildingId = 13
	  case "oficina"
		 $buildingId =14
	  case "moinho"
		 $buildingId = 15
	  case "serracao"
		 $buildingId = 16
	  case "alvenaria"
		 $buildingId = 17
	  case "fundicao"
		 $buildingId = 17
	  case "padaria"
		 $buildingId = 18
	  case "grandeArmazem"
		 $buildingId = 19
	  case "prm"
		 $buildingId = 20
	  case "palicada"
		 $buildingId =21
	  EndSwitch
   Else
	  $buildingId = buildingId - 19
   EndIf
   $lvlOfCurrentId = _FFCMD(".getElementsByTagName('Area')["&$buildingId&"].alt.match(/\d+/)[0]")
   MsgBox(0,0,"nível ="&$lvlOfCurrentId)

   EndFunc

Func getTutReward()
   _FFOpenURL("/dorf1.php")
   sleep(1000)
   _FFCmd(".getElementById('questmasterButton').click()")
   sleep(1000)
   _FFCMD(".getElementsByClassName('green questButtonNext')[0].click()")
EndFunc
Func goOnAdventure()
   _FFOpenURL("/hero_adventure.php")
   sleep(1000)
   $adventureURL = _FFCmd(".getElementsByClassName('gotoAdventure arrow')[1].href")
   _FFOpenURL($adventureURL)
   _FFCmd(".getElementById('start').click()")
EndFunc
Func doTutorial()

   ;fazer missoes do tutorial
   ;missão1
   _FFOpenURL("/dorf1.php")
   _FFCmd(".getElementById('questmasterButton').click()")
   _FFCmd(".getElementById('dialogCancelButton').click()")
   _FFCmd(".getElementById('questmasterButton').click()")
   _FFCmd(".getElementById('questTutorialLightBulb').click()")
   _FFCMD(".getElementsByClassName('green questButtonNext')[0].click()")
   getTutReward()
   ;evoluir bosque para nivel2
   upgradeField("B",1)
   ;obter recompensa
   getTutReward()
   ;missao evoluir campo de cereais para nivel 1
   upgradeField("C")
   _FFOpenURL("/build.php?id=2") ; para o tutorial detetar que o campo foi aberto
   getTutReward()

   ;missao alterar producao do heroi para barro
   _FFCmd(".getElementById('heroImageButton').click()")
   sleep(1000)
   _FFCmd(".getElementById('resourceHero2').click()")
   _FFCmd(".getElementById('saveHeroAttributes').click()") ; salvar atributos
   sleep(500)
   getTutReward()


   ;missao entrar na aldeia e construir armazem
   buildBuilding("armazem")
   getTutReward()
   ;missao construir ponto de reuniao militar
   _FFOpenURL("/build.php?id=39") ; Para garantir que o travian deteta que abri o ponto de reu.militar
   buildBuilding("prm") ; Construir Ponto de Reunião Militar
   getTutReward()

   ; missao terminar de imediato
   _FFCmd(".getElementsByClassName('gold highlighted on')[0].click()")
   sleep(50)
   _FFCmd(".getElementsByClassName('gold highlighted on')[0].click()")
   getTutReward()


   ; missao enviar heroi em aventura
   _FFOpenURL("/hero_adventure.php")
   $adventureURL = _FFCmd(".getElementsByClassName('gotoAdventure arrow highlighted on')[1].href")
   _FFOpenURL($adventureURL)
   _FFCmd(".getElementById('start').click()")
   getTutReward()


   ;missao ler relatorio de aventura
   _FFOpenUrl("/berichte.php")
   sleep(1000)
   $reportURL = _FFCmd(".getElementsByClassName('adventure')[0].href")
   _FFOpenURL($reportURL)
   getTutReward()


   _FFOpenURL("/hero_inventory.php")
   sleep(500)
   _FFCmd(".getElementById('item_121124').click()") ; clica na poçao de cura
   _FFCmd(".getElementsByClassName('green ok dialogButtonOk')[0].click()")
   getTutReward()

   ;missao de ver interface do travian
   _FFCmd(".getElementsByClassName('layoutButton bulbWhite green  highlighted on')[0].click()")
   sleep(100)
   _FFCmd(".getElementsByClassName('overlayCloseLink')[0].click()") ; fechar a ajuda

   ;evoluir armazem porque os recursos devem estar cheios neste momento
   upgradeBuilding(19)

   ;construir celeiro
   buildBuilding("celeiro")
   getTutReward()
   ;acabar tutorial
   getTutReward()

EndFunc
Func getMissionRewards()
	Local $availableReward[10]
	_FFOpenURL("/dorf1.php")
	sleep(1000)
	For $i = 0 To 5
		If _FFCmd(".getElementsByClassName('quest')[" & $i & "].getElementsByClassName('reward')[0].classList.contains('reward')") == "1" Then
			_FFCmd(".getElementsByClassName('quest')[" & $i & "].click()")
			sleep(1000)
			_FFCmd(".getElementsByClassName('green questButtonGainReward')[0].click()")
			sleep(200)
			$i = $i -1
			EndIf
		Next
EndFunc
Func getResourcesQuantity()
	; madeira barro ferro cereal, armazem, celeiro, cerealLivre
	Local $recursos[6]
	For $i = 0 To 3
		$recursos[$i] = _FFCmd(".getElementById(""stockBarResource"&String($i+1)&""").getElementsByTagName(""span"")[0].innerHTML.replace(/\./,'')")
	Next
	recursos[4] = _FFCmd(".getElementById('stockBarWarehouse').innerHTML.replace(/\./,'')")
	recursos[5] = _FFCmd(".getElementById('stockBarGranary').innerHTML.replace(/\./,'')")
	recursos[6] = _FFCmd(".getElementById('stockBarFreeCrop').innerHTML.replace(/\./,'')")
	return $recursos
EndFunc
login()
goOnAdventure()
buildBuilding("quartel")
getMissionRewards()


#comments-end