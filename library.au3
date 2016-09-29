#include-once
#include <FF.au3>
#include <MsgBoxConstants.au3>
#include <array.au3>
#include <File.au3>
#include <SQLite.au3>
#include <SQLite.dll.au3>

#comments-start
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
#comments-end


Func login($username, $pass, $serverURL);review because of GUI, maybe create a start function that starts firefox and then login after
   _FFStart(Default,Default,Default,False)
   Global $hFF = _FFConnect();connects to MozRepl in Firefox Browser
	_FFOPenURL($serverURL)
_FFSetValue($pass,_FFObjGet("password","name"))
_FFSetValue($username,_FFObjGet("name","name"))
_FFClick("s1","id")
EndFunc
Func getCValue();returns a magic value used to do fundamental things
   $getCURL = "/build.php?id=1"
   _FFOpenURL($getCURL)
   If _FFCmd(".getElementsByClassName('green build')[0].className") == "green build disabled" Then
	   return _FFCmd(".getElementsByClassName('gold builder')[0].getAttribute('onclick').substring(40,46)")
   Else
	   return _FFCmd(".getElementsByClassName('green build')[0].getAttribute('onclick').substring(40,46);")
   EndIf
EndFunc
Func getResourcesId(); deprecated, valve, please fix
   smartURL("/dorf1.php")
   Local $resourcesArray[20]
   For $i = 0 To 17
   $resourcesArray[$i] = _FFCMD(".getElementsByTagName('Area')["&$i&"].alt.substring(0,1)")
Next
return $resourcesArray
   EndFunc
Func getIdOfTheLowestLevelField($fieldName);returns the id of the lowest field level (of that specific type)
   smartURL("/dorf1.php")
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
func upgradeField($fieldName, $optionalId =-1 );upgrades field, default is lowest level of that type
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
Func buildBuilding($buildingName,$buildingId = -1,$aValue = -1);builds a non existing building on the village
   $cValue = getCValue()
   smartURL("/dorf2.php")
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
Func upgradeBuilding($aValue);upgrades building from a value
   $cValue = getCValue()
   $url = "/dorf2.php?a="&$aValue&"&c="&$cValue
   _FFOpenURL($url)
EndFunc
Func getBuildingLvl($buildingName,$buildingId = -1);returns building level
   smartURL("/dorf2.php")
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
	  $buildingId = $buildingId - 19
   EndIf
   $lvlOfCurrentId = _FFCMD(".getElementsByTagName('Area')["&$buildingId&"].alt.match(/\d+/)[0]")
   ;MsgBox(0,0,"nível ="&$lvlOfCurrentId)
   return $lvlOfCurrentId
   EndFunc
Func getTutReward();please review me
   smartURL("/dorf1.php")
   sleep(1000)
   _FFCmd(".getElementById('questmasterButton').click()")
   sleep(1000)
   _FFCMD(".getElementsByClassName('green questButtonNext')[0].click()")
EndFunc
Func goOnAdventure();takes the hero to adventure
   if _FFCmd(".URL.match(/travian[^\/]+(\/[^\?]+)\?*/)[1]") <> "/hero_adventure.php" Then
	  _FFOpenURL("/hero_adventure.php")
   EndIf

   sleep(1000)
   $adventureURL = _FFCmd(".getElementsByClassName('gotoAdventure arrow')[1].href")
   _FFOpenURL($adventureURL)
   _FFCmd(".getElementById('start').click()")
EndFunc
Func doTutorial();please fix this crap

   ;fazer missoes do tutorial
   ;missão1
   sleep(500)
   If _FFCmd(".getElementsByClassName('green questButtonNext highlighted on').length") == 0 Then
	  Return
   EndIf
   _FFCmd(".getElementsByClassName('green questButtonNext highlighted on').click()")

   sleep(2000)

   _FFCmd(".getElementById('questmasterButton').click()")
   sleep(3000)
   _FFCmd(".getElementById('dialogCancelButton').click()")
   sleep(3000)
   _FFCmd(".getElementById('questmasterButton').click()")
   sleep(3000)
   _FFCmd(".getElementById('questTutorialLightBulb').click()")
   sleep(3000)
   _FFCmd(".getElementsByClassName('green questButtonNext')[0].click()")
   sleep(3000)

   ;evoluir bosque para nivel1
   _FFOpenURL("/build.php?id=1")
   upgradeField("B",1)
   ;obter recompensa
   sleep(500)
   getTutReward() ; termina de imediato
   sleep(500)

   ;evoluir bosque para nivel 2
   _FFOpenURL("/build.php?id=1")
   upgradeField("B",1)
   sleep(500)
   getTutReward()
   sleep(500)
   ;missao evoluir campo de cereais para nivel 1
   _FFOpenURL("/build.php?id=2"); para o tutorial detetar que o campo foi aberto
   upgradeField("C")

   sleep(500)
   getTutReward()

   ;missao alterar producao do heroi para barro
   balanceResources(1)

   getTutReward()


   ;missao entrar na aldeia e construir armazem
   buildBuilding("armazem")
   sleep(1000)

   getTutReward()
   ;missao construir ponto de reuniao militar
   _FFOpenURL("/build.php?id=39") ; Para garantir que o travian deteta que abri o ponto de reu.militar
   sleep(1000)
   buildBuilding("prm") ; Construir Ponto de Reunião Militar
   sleep(1000)
   getTutReward()
   sleep(1000)



   ; missao terminar de imediato
   smartURL("/dorf2.php")
   sleep(1000)
   _FFCmd(".getElementsByClassName('gold highlighted on')[0].click()")
   sleep(1000)
   _FFCmd(".getElementsByClassName('gold highlighted on')[0].click()")
   sleep(1000)
   getTutReward()


   ; missao enviar heroi em aventura
   _FFOpenURL("/hero_adventure.php")
   $adventureURL = _FFCmd(".getElementsByClassName('gotoAdventure arrow highlighted on')[1].href")
   _FFOpenURL($adventureURL)
   _FFCmd(".getElementById('start').click()")
   sleep(1000)
   getTutReward()


   ;missao ler relatorio de aventura
   _FFOpenUrl("/berichte.php")
   sleep(1000)
   $reportURL = _FFCmd(".getElementsByClassName('adventure')[0].href")
   _FFOpenURL($reportURL)
   sleep(1000)
   getTutReward()


   _FFOpenURL("/hero_inventory.php")
   sleep(1000)
   _FFCmd(".getElementsByClassName('item male_item_106 highlighted on')[0].click()"); clica na poçao de cura
   sleep(1000)
   _FFCmd(".getElementsByClassName('green ok dialogButtonOk')[0].click()")
   sleep(1000)
   getTutReward()
   sleep(2000)

   ;missao de ver interface do travian
   _FFCmd(".getElementsByClassName('layoutButton bulbWhite green  highlighted on')[0].click()")
   sleep(1000)
   _FFCmd(".getElementsByClassName('overlayCloseLink')[0].click()") ; fechar a ajuda
   sleep(1000)

   getTutReward()

   ;evoluir armazem porque os recursos devem estar cheios neste momento
   ;upgradeBuilding(19)

   ;construir celeiro
   sleep(1000)
   buildBuilding("celeiro")
   sleep(1000)
   getTutReward()
   ;acabar tutorial
   sleep(1000)
   getTutReward()

EndFunc
Func getMissionRewards();gets mission rewards, code needs cleanup for noerror of firefox
	Local $availableReward[10]
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
Func getResourcesQuantity();returns array of resources
	; madeira barro ferro cereal, armazem, celeiro, cerealLivre
	Local $recursos[7]
	For $i = 0 To 3
		$recursos[$i] = _FFCmd(".getElementById(""stockBarResource"&String($i+1)&""").getElementsByTagName(""span"")[0].innerHTML.replace(/\./,'')")
	Next
	$recursos[4] = _FFCmd(".getElementById('stockBarWarehouse').innerHTML.replace(/\./,'')")
	$recursos[5] = _FFCmd(".getElementById('stockBarGranary').innerHTML.replace(/\./,'')")
	$recursos[6] = _FFCmd(".getElementById('stockBarFreeCrop').innerHTML.replace(/\./,'')")
	return $recursos
 EndFunc
Func balanceResources($recurso = -1);hero resource balance
   $recursos = getResourcesQuantity()
	$indexMin = -1;
	$minValue = 9999999
   If $recurso <> -1 Then
	  $indexMin = $recurso
	  Else
	For $i = 0 To 2
	   If $recursos[$i] < $minValue Then
		  $minValue = $recursos[$i]
		  $indexMin = $i
	   EndIf
	Next
	If(0.75 * $minValue > $recursos[3]) Then
	   $indexMin = 3
	   $minValue = $recursos[3]
	EndIf
 EndIf

	_FFOpenURL("/hero_inventory.php")
	_FFCmd(".getElementById('resourceHero"&$indexMin+1&"').click()")
	_FFCmd(".getElementById('saveHeroAttributes').click()")
EndFunc
Func createTraps($quantidade= 1000);builds $quantidade of traps, default is max;
   _FFOpenURL("/build.php?id=23")
   _FFCmd(".getElementsByName('t99')[0].value = " & $quantidade)
   _FFCmd(".getElementById('s1').click()")
EndFunc
Func sendTroops($xCoord,$yCoord,$tipoAtaque = 2,$falange = 0, $espadachim = 0, $batedor = 0, $trovao = 0, $druida = 0, $haeudano = 0, $ariete = 0, $trabuquete = 0, $chefe = 0, $colonizador = 0);send troos
   _FFOpenURL("/build.php?tt=2&id=39")
   $a = $falange == -1 ? _FFCmd(".getElementsByName('t1')[0].value = 9999999") : _FFCmd(".getElementsByName('t1')[0].value = " & $falange)
   $a = $espadachim == -1 ? _FFCmd(".getElementsByName('t2')[0].value = 9999999") : _FFCmd(".getElementsByName('t2')[0].value = " & $espadachim)
   $a = $batedor == -1 ? _FFCmd(".getElementsByName('t3')[0].value = 9999999") : _FFCmd(".getElementsByName('t3')[0].value = " & $batedor)
   $a = $trovao == -1 ? _FFCmd(".getElementsByName('t4')[0].value = 9999999") : _FFCmd(".getElementsByName('t4')[0].value = " & $trovao)
   $a = $druida == -1 ? _FFCmd(".getElementsByName('t5')[0].value = 9999999") : _FFCmd(".getElementsByName('t5')[0].value = " & $druida)
   $a = $haeudano == -1 ? _FFCmd(".getElementsByName('t6')[0].value = 9999999") : _FFCmd(".getElementsByName('t6')[0].value = " & $haeudano)
   $a = $ariete == -1 ? _FFCmd(".getElementsByName('t7')[0].value = 9999999") : _FFCmd(".getElementsByName('t7')[0].value = " & $ariete)
   $a = $trabuquete == -1 ? _FFCmd(".getElementsByName('t8')[0].value = 9999999") : _FFCmd(".getElementsByName('t8')[0].value = " & $trabuquete)
   $a = $chefe == -1 ? _FFCmd(".getElementsByName('t9')[0].value = 9999999") : _FFCmd(".getElementsByName('t9')[0].value = " & $chefe)
   $a = $colonizador == -1 ? _FFCmd(".getElementsByName('t10')[0].value = 9999999") : _FFCmd(".getElementsByName('t10')[0].value = " & $colonizador)
   $a = _FFCmd(".getElementById('xCoordInput').value = " & $xCoord)
   $a = _FFCmd(".getElementById('yCoordInput').value = " & $yCoord)
   $a = _FFCmd(".getElementsByName('c')["& $tipoAtaque &"].click()")
   $a = _FFCmd(".getElementById('btn_ok').click()")
EndFunc
Func trainTroops($falange = 0, $espadachim = 0, $batedor = 0, $trovao = 0, $druida = 0, $haeudano = 0, $ariete = 0, $trabuquete = 0, $chefe = 0, $colonizador = 0);make troops
   _FFOpenURL("/build.php?id=29")
   $a = $falange == -1 ? _FFCmd(".getElementsByName('t1')[0].value = 9999999") : _FFCmd(".getElementsByName('t1')[0].value = " & $falange)
   $a = $espadachim == -1 ? _FFCmd(".getElementsByName('t2')[0].value = 9999999") : _FFCmd(".getElementsByName('t2')[0].value = " & $espadachim)
   $a = $batedor == -1 ? _FFCmd(".getElementsByName('t3')[0].value = 9999999") : _FFCmd(".getElementsByName('t3')[0].value = " & $batedor)
   $a = $trovao == -1 ? _FFCmd(".getElementsByName('t4')[0].value = 9999999") : _FFCmd(".getElementsByName('t4')[0].value = " & $trovao)
   $a = $druida == -1 ? _FFCmd(".getElementsByName('t5')[0].value = 9999999") : _FFCmd(".getElementsByName('t5')[0].value = " & $druida)
   $a = $haeudano == -1 ? _FFCmd(".getElementsByName('t6')[0].value = 9999999") : _FFCmd(".getElementsByName('t6')[0].value = " & $haeudano)
   $a = $ariete == -1 ? _FFCmd(".getElementsByName('t7')[0].value = 9999999") : _FFCmd(".getElementsByName('t7')[0].value = " & $ariete)
   $a = $trabuquete == -1 ? _FFCmd(".getElementsByName('t8')[0].value = 9999999") : _FFCmd(".getElementsByName('t8')[0].value = " & $trabuquete)
   $a = $chefe == -1 ? _FFCmd(".getElementsByName('t9')[0].value = 9999999") : _FFCmd(".getElementsByName('t9')[0].value = " & $chefe)
   $a = $colonizador == -1 ? _FFCmd(".getElementsByName('t10')[0].value = 9999999") : _FFCmd(".getElementsByName('t10')[0].value = " & $colonizador)
   _FFCmd(".getElementById('s1').click()")
   EndFunc
Func smartURL($URL);url browsing optimization
   if _FFCmd(".URL.match(/travian[^\/]+(\/[^\?]+)\?*/)[1]") <> $URL Then
	  _FFOpenURL($URL)
   EndIf
EndFunc
Func callFunc($funcParams); gui command caller
		Local $funcName = $funcParams[0]
		$funcParams[0] = "CallArgArray"
		For $i=1 To Ubound($funcParams)-1
			$funcParams[$i] = $funcParams[$i]
		Next
		Call($funcName, $funcParams)
EndFunc
Func hourProduction()
	Local $production[4]
	For $i = 0 To 3
		$production[$i] = _FFCmd("/\d+/.exec(window.content.document.getElementsByClassName('num')[" & $i & "].innerHTML)[0]")
	Next
	return $production
	EndFunc

Func thinkV01($first);thiks like a stupid kid but more often
	;If $first == True Then
	;$balanceResourcesTimer = TimerInit()
	;$goOnAdventure = TimerInit()
	;EndIf
	If TimerDiff($balanceResourcesTimer) > 5000 Then
		$balanceResourcesTimer = TimerInit()
		balanceResources()
	EndIf
	If TimerDiff($goOnAdventure) > 1800000 Then
		$goOnAdventure = TimerInit()
		balanceResources()
	EndIf
	;return False
EndFunc