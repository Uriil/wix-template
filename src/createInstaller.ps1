PARAM 
(
	[Parameter(Mandatory=$true)]
	[string] $DirectoryToCollect,	
	[Parameter(Mandatory=$true)]
	[string] $InputWixFile,
	[Parameter(Mandatory=$true)]
	[string] $OuputName,
	[Parameter(Mandatory=$true)]
	[string] $ComponentGroup,
	[Parameter(Mandatory=$true)]
	[string] $DirectoryID
	
)

#$env:Path += ";C:\Program Files (x86)\WiX Toolset v3.9\bin"
heat.exe dir "$DirectoryToCollect" -cg "$ComponentGroup" -gg -scom -sreg -sfrag -srd -dr "$DirectoryID" -out "tempHeat.wxs"
candle.exe "$InputWixFile" -out "tempMain.wixobj"
candle.exe "tempHeat.wxs" -out "tempHeat.wixobj"
light.exe -b "$DirectoryToCollect" "tempMain.wixobj" "tempHeat.wixobj" -ext WixUtilExtension -out "$OuputName.msi"

Remove-Item "tempMain.wixobj"
Remove-Item "tempHeat.wixobj"
Remove-Item "tempHeat.wxs"
Remove-Item "$OuputName.wixpdb"