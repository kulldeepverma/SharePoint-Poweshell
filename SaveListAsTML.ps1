<#
Author          : Kuldeep Verma
Created Date    : 13th Jan, 2018.
Title           : Save list as template 
Description     : This is to save SharePoint list as template. 
#>


#to ensure the SharePoint PowerShell snapin is loaded
if($null -eq (Get-PSSnapin "Microsoft.SharePoint.PowerShell"))
{
    Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue 
}

#variable declaration
$TMLName="MedicalInsuranceTML"
$TMLFileName="MedicalInsuranceTML"
$TMLDescription="Saving before doing any changes in List."
$WebURL = "http://lgvsa001:2013/app/Mi"
$ListName="MedicalInsurance"

#Pass $true for template with data and $false for template without data.
$SaveData = $true

##Get the Web and List objects
$Web = Get-SPWeb $WebURL
$List = $Web.Lists[$ListName]

##Save List as Template
$List.SaveAsTemplate($TMLFileName, $TMLName, $TMLDescription, $SaveData)
Write-Host "List Saved as Template!" 


