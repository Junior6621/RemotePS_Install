$Credential = Get-Credential
$computername = "Server01"
$srcdir = "\\fileserver01\share\install.bat"
$dstdir = "C:\Windowns\Temp"

#install.bat basically references an MSIexec command that install the package with parameter /quiet /qn 
$session = New-PSSession -Computer $computername -Credential $Credential

#Copies the files from localhost to remote computer
Copy-Item -ToSession $session -Path $srcdir -Destination $dstdir

#Invoke the batch file install. WorkingDirectory must patch destination directory folder.
Invoke-Command -Session $session -Scriptblock { Start-Process "C:\Windows\temp\autoinstall.bat" -verb runAs -WorkingDirectory "C:\Windows\Temp" -wait}

#Closes PSSession
Remove-PSSession $session

