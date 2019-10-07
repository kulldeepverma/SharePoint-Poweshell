<#
Author          : Kuldeep Verma
Created Date    : 12th Jan, 2018.
Title           : SharePoint 30 Minute Time Out for Forms
Description     : When you open a form to fill out, Out-of-the-box SharePoint will time out that form after 30 minutes.This is very annoying because the form will just disappear and the data will be gone so the user has to start filling the form all over again.
#>
$oSite = Get-SPSite("<Site URL>")
$oWebApp = $oSite.WebApplication
$oWebApp.FormDigestSettings
$oWebApp.FormDigestSettings.Timeout = New-TimeSpan -Hours 8
$oWebApp.Update()