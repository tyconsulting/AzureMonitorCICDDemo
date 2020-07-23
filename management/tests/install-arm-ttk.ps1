<#
===============================================================================
AUTHOR:  Tao Yang
DATE:    11/09/2020
SCRIPT:  install-arm-tkk.ps1
Version: 1.0
Comment: Download and install the latest Azure ARM Toolkit module from GitHub
===============================================================================
#>
PARAM (
    [Parameter(Mandatory=$false,HelpMessage="Please specifiy the working dir. default value is '%temp%'." )][Validatescript({test-path $_})][String]$workingDir=$env:temp
)
#region variables
$ARMTTkDownloadURL = 'https://aka.ms/arm-ttk-latest'
$downloadedFile = join-path $workingDir 'arm-template-toolkit.zip'
$unzipDestination = Join-path $workingDir 'arm-ttk-latest'
$armTTKModulePath = Join-path $unzipDestination 'arm-ttk'
#endregion

#region main
#download the latest arm-ttk module
Write-verbose "Downloading the latest arm-ttk module from '$ARMTTkDownloadURL' to '$downloadedFile'"
Invoke-WebRequest -Uri $ARMTTkDownloadURL  -UseBasicParsing -Method Get -OutFile $downloadedFile
Unblock-File -Path $downloadedFile
#unzip and install
Write-verbose "Unzip $downloadedFile"
Expand-Archive -Path $downloadedFile -DestinationPath $unzipDestination -Force

#To import the module, run 'import-module (join-path $armTTKModulePath 'arm-ttk.psm1')

#house keeping
Write-verbose "House Keeping"
Write-verbose "Deleting $downloadedFile"
Remove-Item $downloadedFile -Force
Write-verbose "Done"
Write-Output $armTTKModulePath
#endregion
