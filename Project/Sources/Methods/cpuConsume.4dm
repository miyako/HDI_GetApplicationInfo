//%attributes = {"invisible":true}
C_LONGINT:C283($i; $j)

For ($i; 1; 1000)
	For ($j; 1; 10000)
		If ($i=$j)
			$j:=$j
		End if 
	End for 
End for 

KILL WORKER:C1390