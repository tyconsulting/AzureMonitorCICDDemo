## ARM-TTK

#Download and unzip the latest version of arm-ttk module to C:\temp\
#. $pwd\tests\install-arm-ttk.ps1 -workingDir "C:\Temp\"

#invoke all the pester tests shipped in arm=ttk module
Import-Module "C:\temp\arm-ttk-latest\arm-ttk\arm-ttk.psm1"
Invoke-Pester -Script @{path="$pwd\tests\test.arm-ttk.ps1"; Parameters=@{TemplatePath = "$pwd\management\template\azuredeploy.json"; ARMTTKModulePath = 'C:\temp\arm-ttk-latest\arm-ttk'}} -OutputFile C:\temp\TEST-Mgmt.ARMTemplate.xml -OutputFormat 'NUnitXml' -PassThru
start notepad++ C:\temp\TEST-Mgmt.ARMTemplate.xml


## PSScriptAnalyzer
<#
#install required modules
Install-module Pester -SkipPublisherCheck -force
Install-module PSScriptAnalyzer -SkipPublisherCheck -force
Install-module PSPesterTest -SkipPublisherCheck -force
#>

#Perform tests
Test-PSScriptAnalyzerRule -path $pwd -recurse -OutputFile C:\temp\TEST-PSScripts.xml
start notepad++ C:\temp\TEST-PSScripts.xml
~~~