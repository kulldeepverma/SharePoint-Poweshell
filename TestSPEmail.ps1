<#
Author          : Kuldeep Verma
Created Date    : 12th Jan, 2018.
Title           : Test SharePoint Outbound email configuration
Description     : With the help of this script, You can test SharePoint Email outbound setting.It will sent email and return true. In case of any issue with cofiguration it will return false.
#>

$email = "<EmailId>"
$subject = "Test SP Email"
$body = "This is just to test SharePoint Email status."
$oWebURL="<Web URL>"
$web = Get-SPWeb $oWebURL 
[Microsoft.SharePoint.Utilities.SPUtility]::SendEmail($web,0,0,$email,$subject,$body)
