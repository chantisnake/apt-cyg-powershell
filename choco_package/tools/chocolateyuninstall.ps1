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

Invoke-Expression "$cygwinbash --login -c 'rm /bin/apt-cyg'"