<#
 .SYNOPSIS
  Test Azure Resource Manager (ARM) template against the arm-ttk module using Pester.

 .DESCRIPTION

 .PARAMETER -TemplatePath
  The path to the ARM Template that needs to be tested against.

 .EXAMPLE
   # Test ARM template file
  .\Test.ARMTemplate.ps1 -TemplatePath 'c:\temp\azuredeploy.json'
#>
<#
=============================================================
AUTHOR:  Tao Yang
DATE:    19/01/2020
Version: 1.0
Comment: Pester Test for ARM Template against arm-ttk module
=============================================================
#>
[CmdLetBinding()]
param (
  [Parameter(Mandatory=$true)]
  [ValidateScript({test-path $_ -PathType Leaf})]
  [string]$TemplatePath,

  # Any additional parameters to pass to each test.
  # If the parameter does not exist for a given test case, it will be ignored.
  [Parameter(Mandatory=$false)]
  [Alias('TestParameters')]
  [Collections.IDictionary]
  $TestParameter,

  [Parameter(Mandatory=$true)]
  [ValidateScript({test-path $_ -PathType Container})]
	[string]$ARMTTKModulePath,

  [Parameter(ParameterSetName = 'ProduceOutputFile', Mandatory=$false)][ValidateSet('NUnitXml', 'LegacyNUnitXML')][string]$OutputFormat='NUnitXml'
)

#Load ARM-TTK module
Try {
  Write-Verbose "Importing arm-ttk module from '$ARMTTKModulePath'"
  Import-module (Join-path $ARMTTKModulePath arm-ttk.psd1)
} Catch {
  Throw "Unable to load arm-ttk module from '$ARMTTKModulePath'"
  exit -1
}

#Perform tests
$params = @{
  TemplatePath = $TemplatePath
}

if ($PSBoundParameters.ContainsKey('TestParameter'))
{
  $params.Add('TestParameter', $TestParameter)
}
Write-Verbose "Performing tests using arm-ttk module"
<#
$ARMTTKResults = Test-AzTemplate @params
$TemplateFileName = (Get-Item $TemplatePath).Name

Write-Verbose "Wrapping arm-ttk test results in Pester"
Describe "Validating Azure Template" {
  Foreach ($group in $($ARMTTKResults | Group-Object -Property Group))
  {
    Context "$TemplateFileName`->$($group.name)"
    Foreach ($test in $group.group)
    {
      It "$test.Name" {
        $test.Passed | Should be $true
      }
    }
  }
}
#>
Test-AzTemplate @params -Pester
#Done