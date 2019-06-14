<#
Author          : Kuldeep Verma
Created Date    : 12th Jan, 2018.
Title           : GetSPListCustomField
Description     : Get custom SharePoint list custom field
#>
if($null -eq (Get-PSSnapin "Microsoft.SharePoint.PowerShell"))
{
    Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue 
}
$oWebURL="<SharePoint Site URL>"
$oListName="<List Name>"
$web = Get-SPWeb $oWebURL
$list = $web.Lists[$oListName]
$list.fields | Where-Object {($_.FromBaseType -eq $false -and $_.CanBeDeleted -eq $true)} | select InternalName,Title
