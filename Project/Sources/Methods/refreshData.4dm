//%attributes = {"invisible":true}
C_TEXT:C284($portTitle; $ip)
C_LONGINT:C283($i)
C_OBJECT:C1216($obj)

Form:C1466.applicationInfo:=Application info:C1599

Form:C1466.executionMode:=Form:C1466.applicationTypes.query("value=:1"; Application type:C494)[0].label

Case of 
	: (Form:C1466.applicationInfo.volumeShadowCopyStatus=vss not available:K5:48)
		Form:C1466.applicationInfo.volumeShadowCopyStatusText:="Not available"
		
	: (Form:C1466.applicationInfo.volumeShadowCopyStatus=vss error:K5:49)
		Form:C1466.applicationInfo.volumeShadowCopyStatusText:="Not running (a problem occured)"
		
	: (Form:C1466.applicationInfo.volumeShadowCopyStatus=vss update required:K5:50)
		Form:C1466.applicationInfo.volumeShadowCopyStatusText:="Not running (VSS service is not up to date)"
		
	: (Form:C1466.applicationInfo.volumeShadowCopyStatus=vss available:K5:51)
		Form:C1466.applicationInfo.volumeShadowCopyStatusText:="Up and running"
End case 

If (Form:C1466.applicationInfo.TLSEnabled=Null:C1517)
	Form:C1466.applicationInfo.TLSEnabled:="Not returned with 4D mono"
End if 

If (Form:C1466.applicationInfo.useLegacyNetworkLayer=Null:C1517)
	Form:C1466.applicationInfo.useLegacyNetworkLayer:="Not returned with 4D mono"
End if 

If (Form:C1466.applicationInfo.portID=Null:C1517)
	Form:C1466.applicationInfo.portID:="Not returned with 4D mono"
	$portTitle:="Port:"
Else 
	Case of 
		: (Application type:C494=4D Remote mode:K5:5)
			$portTitle:="Port used to connect on server:"
		: (Application type:C494=4D Server:K5:6)
			$portTitle:="Port listened by 4D server:"
	End case 
End if 

OBJECT SET TITLE:C194(*; "usedPort"; $portTitle)

If (Form:C1466.applicationInfo.newConnectionsAllowed=Null:C1517)
	Form:C1466.applicationInfo.newConnectionsAllowed:="Not returned with 4D mono / 4D remote"
End if 

If (Form:C1466.applicationInfo.IPAddressesAllowDeny=Null:C1517)
	Form:C1466.applicationInfo.IPAddressesAllowDeny:=New collection:C1472()
	Form:C1466.applicationInfo.IPAddressesAllowDeny.push(New object:C1471("mode"; "Not returned with 4D mono / 4D remote"; "ip"; ""))
End if 

If (Form:C1466.applicationInfo.IPAddressesToListen=Null:C1517)
	Form:C1466.IPAddressesToListenAsString:="Not returned with 4D mono / 4D remote"
Else 
	$i:=0
	Form:C1466.IPAddressesToListenAsString:=""
	For each ($ip; Form:C1466.applicationInfo.IPAddressesToListen)
		Form:C1466.IPAddressesToListenAsString:=Form:C1466.IPAddressesToListenAsString+$ip
		If ($i<(Form:C1466.applicationInfo.IPAddressesToListen.length-1))
			Form:C1466.IPAddressesToListenAsString:=Form:C1466.IPAddressesToListenAsString+" - "
		End if 
		$i:=$i+1
	End for each 
End if 