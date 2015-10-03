PARAM 
(
	[Parameter(Mandatory=$true)]
	[string] $DirectoryToCollect,
	[Parameter(Mandatory=$true)]
	[string] $ApplicationName,	
	[Parameter(Mandatory=$false)]
	[string] $InputWixFile = "application.wxs",	
	[Parameter(Mandatory=$false)]
	[string] $InstallationFile = "None"	
)

$env:ApplicationName = "$ApplicationName"
$env:InstallScriptFile = "$InstallationFile"

#$env:Path += ";C:\Program Files (x86)\WiX Toolset v3.9\bin"
heat.exe dir "$DirectoryToCollect" -cg "FilesToBeInstalled" -gg -scom -sreg -sfrag -srd -dr "INSTALLLOCATION" -out "tempHeat.wxs"
candle.exe "$InputWixFile" -out "tempMain.wixobj"
candle.exe "tempHeat.wxs" -out "tempHeat.wixobj"
light.exe -b "$DirectoryToCollect" "tempMain.wixobj" "tempHeat.wixobj" -ext WixUtilExtension -out "$ApplicationName.msi"

Remove-Item "tempMain.wixobj"
Remove-Item "tempHeat.wixobj"
Remove-Item "tempHeat.wxs"
Remove-Item "$ApplicationName.wixpdb"