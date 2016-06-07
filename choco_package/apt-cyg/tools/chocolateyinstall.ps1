# find cygwin
$local_key =  'HKLM:\SOFTWARE\Cygwin\setup'
$local_key6432 =  'HKLM:\SOFTWARE\Wow6432Node\Cygwin\setup'


$useDefaultMirror = $false

$cygRoot = @($local_key, $local_key6432) | ?{Test-Path $_} | Get-ItemProperty | Select-Object -ExpandProperty rootdir
if ($cygRoot -eq $null) {
  $useDefaultMirror = $true
  Write-Debug "Registry value not found for install"
  $cygRoot = 'c:\tools\cygwin'
  Write-Debug "Looking for cygwin in '$cygRoot'"
  if (!(Test-Path $cygRoot)) {
    throw "Cygwin install not found"
  }
}

$cygwinbash = "$cygRoot\bin\bash.exe"

# install
Invoke-Expression "$cygwinbash --login -c 'lynx -source rawgit.com/transcode-open/apt-cyg/master/apt-cyg > apt-cyg'"
Invoke-Expression "$cygwinbash --login -c 'install apt-cyg /bin'"

# clean up
try {
  Write-Host 'tring to clean up'
  Remove-Item "$HOME/apt-cyg" -Force
}
catch {
  Write-Host 'file is already cleaned up'
}


# choco stuff
$path = Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) 'apt-cyg.ps1'

Install-ChocolateyPowershellCommand -PackageName 'apt-cyg' -PSFileFullPath $path