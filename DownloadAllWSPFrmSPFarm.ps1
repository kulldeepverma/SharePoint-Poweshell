<#
Author          : Kuldeep Verma
Created Date    : 13th October, 2017.
Title           : Download all WSP Solution
Description     : Download all WSP's from SharePoint farm to local folder. 
#>

#to ensure the SharePoint PowerShell snapin is loaded
if($null -eq (Get-PSSnapin "Microsoft.SharePoint.PowerShell"))
{
    Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue 
}
#Declare path where all WSP's will download. 
$PathForExport="C:\PSExport\" 

#It will check folder is exist or not.If it is not then, It will folder.
if((Test-Path -Path $PathForExport) -ne $true)
{
    New-Item -Path $PathForExport -ItemType Directory
}

$farm = Get-SpFarm 
$farmsolutions = $farm.Solutions 
Try {
Write-Host -ForegroundColor Magenta "Downloading Started..."
foreach($solution in ($farmsolutions | select Name))
{
    Write-Host -ForegroundColor Green $solution.Name" WSP downloaded..."
    $file=$farm.Solutions.Item($solution.Name).SolutionFile
    $file.SaveAs($PathForExport + $solution.Name)
}
Write-Host -ForegroundColor Magenta "Downloading Completed Successfully..."
}
catch{
    Write-Host $_.Exception.Message -ForegroundColor Red
}
