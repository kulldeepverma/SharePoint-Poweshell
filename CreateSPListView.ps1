<#
Author          : Kuldeep Verma
Created Date    : 12th Jan, 2018.
Title           : Create SharePoint List View
Description     : It will help to create SharePoint List view using powershell command. 
#>
if($null -eq (Get-PSSnapin "Microsoft.SharePoint.PowerShell"))
{
    Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue 
}
$oWebURL="<SharePoint Site URL>"
$oListName="<List Name>"
$oViewName="<View Name>"
#specify field name in comma seperated 
$oFieldNames='<FieldName1>,<FieldName2>,<FieldName3>,<FieldName4>'
#Pass row limit property for view 
$iRowLimit = 30 
#true to specify that the view supports displaying more items page by page; otherwise, false.
$bPaged = $true
#true to make the view the default view; otherwise, false.
$bMakeViewDefault = $false
#Define a CAML Query for view. Can also add where clause in that. 
$strQuery ="<OrderBy><FieldRef Name='ID' Ascending='FALSE'/></OrderBy>"

$oFields= $oFieldNames.split(",")
$viewFields = New-Object System.Collections.Specialized.StringCollection
foreach($fieldName in $oFields){ 
    $viewFields.Add($fieldName)
    Write-host $fieldName" Field added to collection." -ForegroundColor Green
}
Write-host $viewFields.Count -ForegroundColor Green
#Get web object
$oWeb = Get-SPWeb $oWebURL
#Get sharepoint list object
$oList = $oWeb.Lists[$oListName]
#Create the view in the destination list
$oView = $oList.Views.Add($oViewName, $viewFields, $strQuery, $iRowLimit, $bPaged, $bMakeViewDefault)
Write-Host ("View '" + $oView.Title + "' has been created.'") -ForegroundColor Green
Write-Host ($oWebURL +"/" +$oView.Url) -BackgroundColor Yellow -ForegroundColor Green
$oWeb.Dispose()

