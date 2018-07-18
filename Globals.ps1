#--------------------------------------------
# Declare Global Variables and Functions here
#--------------------------------------------


#Sample function that provides the location of the script
function Get-ScriptDirectory
{
<#
	.SYNOPSIS
		Get-ScriptDirectory returns the proper location of the script.

	.OUTPUTS
		System.String
	
	.NOTES
		Returns the correct path within a packaged executable.
#>
	[OutputType([string])]
	param ()
	if ($null -ne $hostinvocation)
	{
		Split-Path $hostinvocation.MyCommand.path
	}
	else
	{
		Split-Path $script:MyInvocation.MyCommand.Path
	}
}

#Sample variable that provides the location of the script
[string]$ScriptDirectory = Get-ScriptDirectory

#--------------------------------------------
# Global Variables for the Launcher
#--------------------------------------------
$source = "\\kiewitplaza\ktg\Active\KSS\KSS_Toolkit\KSS MultiTool"
$source_bin = $source + "\bin"
$install_path = "C:\Program Files\KSS\KSS ToolKit"
$bin = $install_path + "\bin"
$cred_targetname = "MultiTool"

$source_ksstools = $source + "\KSS Tools.exe"
$install_KSSTools = $install_path + "\kss tools.exe"

$env_username = get-aduser $env:USERNAME
$surname = $env_username.surname + "*"
$givenname = $env_username.givenname

$admin_creds = get-aduser -filter { givenname -like $givenname -and surname -like "*admin" -and surname -like $surname }
$creds_admin = $(Get-ADDomain).name + "\" + $admin_creds.samaccountname

$OrgName = "KSS\KSS Toolkit"
$ainm_cleachdaiche = "ainm-cleachdaiche"
$facal_faire = "facal-faire"


$fileversion = (Get-Item $source_ksstools).versioninfo.fileversion | Format-Table -HideTableHeaders -Property *fileversion* | Out-String

try
{
	$localversion = (Get-Item $install_KSSTools).versioninfo.fileversion | Format-Table -HideTableHeaders -Property *fileversion* | Out-String
}
catch
{
	$localversion = "0"
}

#--------------------------------------------
# Global Functions
#--------------------------------------------
