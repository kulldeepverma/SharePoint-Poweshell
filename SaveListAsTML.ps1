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
$TMLName="<template name>"
$TMLFileName="<template file name>"
$TMLDescription="<description of the template>"
$WebURL = "<web url>" 
$ListName="<list name>"

#Pass $true for template with data and $false for template without data.
$SaveData = $true
#Get web object of SharePoint site
$Web = Get-SPWeb $WebURL
#Get list object from web
$List = $Web.Lists[$ListName]

##Save List as Template
$List.SaveAsTemplate($TMLFileName, $TMLName, $TMLDescription, $SaveData)
Write-Host "List Saved as Template!" -ForegroundColor Green


