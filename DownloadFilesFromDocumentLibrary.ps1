<#
Author          : Kuldeep Verma
Created Date    : 15th Jan, 2018.
Title           : Download multiple files from SharePoint Library
Description     : It will help you to download files from SharePoint Library based on some frequent filters like Filename start with endswith, created or updated on any particular date. 
#>

#to ensure the SharePoint PowerShell snapin is loaded

Write-host "Script started..." -ForegroundColor Green

if ($null -eq (Get-PSSnapin "Microsoft.SharePoint.PowerShell")) {
    Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue 
}

#Specify the web URL of document library 
$webURL = "<Change with URL>"

#Specify the path where your you want to save the documents.
$localDrivePath = "Change with Folder Path"

#Specify the document library name 
$spDocLibName = "<Change with Library Name >"

#It will check folder is exist or not.If it is not then, It will folder.
if ((Test-Path -Path $localDrivePath) -ne $true) {
    New-Item -Path $localDrivePath -ItemType Directory
    Write-Host "Folder path '$localDrivePath' Created." -BackgroundColor Yellow -ForegroundColor Green                      
}

#Function to copy file from SharePoint template gallary to lo drive
Function DownloadFiles($SPFolderURL, $localFolderPath) {
    $SPFolder = $oWeb.GetFolder($SPFolderURL)
    foreach ($File in $SPFolder.Files) {
        #It will filter all the files which was modified in last 30 days.
        #if ($File.TimeLastModified -gt ($(Get-Date).AddDays(-30))) {
        
        #It will filter all the files which was modified in last 30 days.
        #if ($File.TimeCreated -gt ($(Get-Date).AddDays(-30))) {

        #It will filter all the files which is starts with any particuar string specify in <SomeString>
        #if ($File.Name.StartsWith("<SomeString>")) {

        #It will filter files whith any specific extension from library or ends with any particular string
        if ($File.Name.endswith(".msg")) {
            $Data = $File.OpenBinary()
            $FilePath = Join-Path $localFolderPath $File.Name
            [System.IO.File]::WriteAllBytes($FilePath, $data)
            write-host $File.Name" has been downloaded" -ForegroundColor Green
        }
    }
    foreach ($SubFolder in $SPFolder.SubFolders) {
        if ($SubFolder.Name -ne "Forms") {
            DownloadFiles $SubFolder $localFolderPath
        }
    }
}
$oWeb = Get-SPWeb $webURL
$oFolder = $oWeb.Lists[$spDocLibName].RootFolder

#calling DownloadFiles function to download stp files to localDrivePath
DownloadFiles $oFolder $localDrivePath
#disposing web object 
$oWeb.Dispose()

Write-host "Script ended..." -ForegroundColor Green