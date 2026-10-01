C_OBJECT:C1216($appType)

initTexts

Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		Form:C1466.applicationTypes:=New collection:C1472
		
		$appType:=New object:C1471
		$appType.value:=4D Local mode:K5:1
		$appType.label:="4D local"
		Form:C1466.applicationTypes.push($appType)
		
		$appType:=New object:C1471
		$appType.value:=4D Remote mode:K5:5
		$appType.label:="4D remote"
		Form:C1466.applicationTypes.push($appType)
		
		$appType:=New object:C1471
		$appType.value:=4D Server:K5:6
		$appType.label:="4D server"
		Form:C1466.applicationTypes.push($appType)
		
		refreshData
		
		SET TIMER:C645(60*1)
		
		
	: (Form event code:C388=On Timer:K2:25)
		
		refreshData
		
End case 