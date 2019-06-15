$folder="E:\Production_Deployment\"
$WspName="DEWA_SyncXLtoDB"
$farm = Get-SpFarm 
$file = $farm.Solutions.Item($WspName+".wsp").SolutionFile 
$file.SaveAs($folder + $WspName +"-"+ [DateTime]::Now.ToString("yyyyMMdd-HHmmss") + ".wsp")