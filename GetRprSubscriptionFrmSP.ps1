<#
Author          : Kuldeep Verma
Created Date    : 2nd Jan, 2018.
Title           : Get List of subscribed SSRS reports. 
Description     : Only tested with SharePoint Integrated reports,It will help you to list out the Subscribed SSRS report inlcuding SubscriptionID, Owner,Path,VirtualPath,Report,DeliverySettings,Description,Status,Active,LastExecuted,LastExecutedSpecified,ModifiedBy,ModifiedDate,EventType and IsDataDriven.
#>

Add-PSSnapin Microsoft.SharePoint.PowerShell -erroraction SilentlyContinue

#Variables
$PathForExport="C:\PSExport" #path where report in CSV format will export. file name will be ReportSubscription.csv
$siteUri = "<Change With URL>" #SSRS report server URL/Link ex. http://hostname/sites/ssrs/reports

#It will check folder is exist or not.If it is not then, It will folder.
if((Test-Path -Path $PathForExport) -ne $true)
{
    New-Item -Path $PathForExport -ItemType Directory
    Write-Host "Folder path '$PathForExport' is not exists." -BackgroundColor Yellow -ForegroundColor Red                      
}
$proxy = New-WebServiceProxy -Uri "$siteUri/_vti_bin/ReportServer/ReportService2010.asmx" -UseDefaultCredential 
$rptColl= $proxy.ListSubscriptions($siteUri) | select SubscriptionID, Owner,Path,VirtualPath,Report,DeliverySettings,Description,Status,Active,LastExecuted,LastExecutedSpecified,ModifiedBy,ModifiedDate,EventType,IsDataDriven
#Array to hold result $Items=@()
$Items = @()
Write-Host "Total Item needs to be exported: " $rptColl.Count -foregroundcolor Green
$rptColl | foreach {
    Write-Host "Info added for report:" $_.Report -ForegroundColor Yellow
    $ExportItem = New-Object PSObject
    $ExportItem | Add-Member -MemberType NoteProperty -name "Path" -value $_.Path
    $ExportItem | Add-Member -MemberType NoteProperty -Name "Report" -value $_.Report
    $ExportItem | Add-Member -MemberType NoteProperty -Name "Description" -value $_.Description
    $ExportItem | Add-Member -MemberType NoteProperty -Name "Status" -value $_.Status
    $Items += $ExportItem
}
$Items | Export-CSV "$PathForExport\ReportSubscription.csv" -NoTypeInformation 
