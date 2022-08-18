$ErrorActionPreference = "Stop"
trap { $host.SetShouldExit(1) }

echo "Work Directory: $pwd"
$Env:ROOT="$pwd"

$null = New-Item -ItemType Directory -Force -Path $Env:TEMP

if ((Get-Command "choco" -ErrorAction SilentlyContinue) -eq $null) {
  Set-ExecutionPolicy Bypass -Scope Process -Force
  [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
  $tempvar = (New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')
  iex ($tempvar)
}

Import-Module "C:\ProgramData\chocolatey\helpers\chocolateyProfile.psm1"
refreshenv
cd $Env:ROOT

if ((Get-Command "go" -ErrorAction SilentlyContinue) -eq $null) {
  choco install --no-progress -r -y golang --version 1.18.3 --force
}

if ((Get-Command "git" -ErrorAction SilentlyContinue) -eq $null) {
  choco install --no-progress -r -y git --force
}

if ((Get-Command "7z" -ErrorAction SilentlyContinue) -eq $null) {
  choco install --no-progress -r -y 7zip --force
}

if ((Get-Command "openssl" -ErrorAction SilentlyContinue) -eq $null) {
  choco install --no-progress -r -y openssl --force
}

if ((Get-Command "sed" -ErrorAction SilentlyContinue) -eq $null) {
  choco install --no-progress -r -y sed --force
}

if ((Get-Command "ISCC" -ErrorAction SilentlyContinue) -eq $null) {
  choco install --no-progress -r -y innosetup --force
}

if ((Get-Command "make" -ErrorAction SilentlyContinue) -eq $null) {
  choco install --no-progress -r -y make --force
}

if ((Get-Command "cf" -ErrorAction SilentlyContinue) -eq $null) {
  choco install --no-progress -r -y cloudfoundry-cli --force
}

Import-Module "C:\ProgramData\chocolatey\helpers\chocolateyProfile.psm1"
refreshenv
cd $Env:ROOT

$Env:GOPATH="$Env:ROOT\go"

$Env:PATH="$Env:HOME\go\bin;" + "$Env:PATH"
$Env:PATH="$Env:GOPATH\bin;" + "$Env:PATH"
$Env:PATH="$pwd;" + "$Env:PATH"

function Get-Env-Info {
  echo "Powershell: $((Get-Host).Version)"
  echo "Working Directory: $pwd"
  echo "GOPATH:            $Env:GOPATH"
  echo "PATH:"
  $Env:PATH.split(";")

  echo "-------------"

  Get-ChildItem Env: | Format-Table -Wrap -AutoSize
}

Get-Env-Info

$Env:RUN_ID=(openssl rand -hex 16)
$Env:GOFLAGS = "-mod=mod"

if ((Get-Command "ginkgo" -ErrorAction SilentlyContinue) -eq $null) {
	go install -v github.com/onsi/ginkgo/ginkgo
}
