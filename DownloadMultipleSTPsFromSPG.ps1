<#
Author          : Kuldeep Verma
Created Date    : 15th Jan, 2018.
Title           : Download multiple STP's from List template Gallery
Description     : It will help download multiple STP's from List template gallary. The idea behind it , sometime while deploying the things we are saving multiple STP's to gallery.We can download it one by one ,but this is the lazy way to download all STP's in single attempt. 
#>

#to ensure the SharePoint PowerShell snapin is loaded

Write-host "Script started..." -ForegroundColor Green

if ($null -eq (Get-PSSnapin "Microsoft.SharePoint.PowerShell")) {
    Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue 
}

$webURL = "<Change with URL>"

#Specify the path where your STP's should save. 
$localDrivePath = "C:\CustomTemplate1"
#It will check folder is exist or not.If it is not then, It will folder.
if ((Test-Path -Path $localDrivePath) -ne $true) {
    New-Item -Path $localDrivePath -ItemType Directory
    Write-Host "Folder path '$localDrivePath' Created." -BackgroundColor Yellow -ForegroundColor Green                      
}

#Function to copy file from SharePoint template gallary to lo drive
Function DownloadStp($SPFolderURL, $localFolderPath) {
    $SPFolder = $oWeb.GetFolder($SPFolderURL)
    foreach ($File in $SPFolder.Files) {
        #By using below if condition you will get all the templates which are created today.
        if ($File.TimeCreated -gt ($(Get-Date).AddDays(-1))) {
            $Data = $File.OpenBinary()
            $FilePath = Join-Path $localFolderPath $File.Name
            [System.IO.File]::WriteAllBytes($FilePath, $data)
            write-host $File.Name" has been downloaded" -ForegroundColor Green
        }
    }
    foreach ($SubFolder in $SPFolder.SubFolders) {
        if ($SubFolder.Name -ne "Forms") {
            DownloadStp $SubFolder $localFolderPath
        }
    }
}
$oWeb = Get-SPWeb $webURL
$oLTG = $oWeb.Lists["List Template Gallery"].RootFolder

#calling DownloadStp function to download stp files to localDrivePath
DownloadStp $oLTG $localDrivePath
#disposing web object 
$oWeb.Dispose()

Write-host "Script ended..." -ForegroundColor Green
