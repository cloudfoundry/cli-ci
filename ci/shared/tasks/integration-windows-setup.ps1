$ErrorActionPreference = "Stop"
trap { $host.SetShouldExit(1) }

echo "Work Directory: $pwd"
$Env:ROOT="$pwd"
$Env:CF_DIAL_TIMEOUT=15

$null = New-Item -ItemType Directory -Force -Path $Env:TEMP

if ((Get-Command "choco.exe" -ErrorAction SilentlyContinue) -eq $null) {
  Set-ExecutionPolicy Bypass -Scope Process -Force
  [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
  $tempvar = (New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')
  iex ($tempvar)
}

if ((Get-Command "7z.exe" -ErrorAction SilentlyContinue) -eq $null) {
  choco install --no-progress -r -y 7zip --force
}

if ((Get-Command "git.exe" -ErrorAction SilentlyContinue) -eq $null) {
  choco install --no-progress -r -y git --force
}

if ((Get-Command "openssl.exe" -ErrorAction SilentlyContinue) -eq $null) {
  choco install --no-progress -r -y openssl --force
}

Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
refreshenv
cd $Env:ROOT

$Env:GOPATH="$Env:ROOT\go"

$Env:PATH="C:\Go\bin;" + "$Env:PATH"
$Env:PATH="$Env:GOPATH\bin;" + "$Env:PATH"
$Env:PATH="C:\Program Files\GnuWin32\bin;" + "$Env:PATH"
$Env:PATH="$pwd;" + "$Env:PATH"

$DOMAIN=(Get-Content $pwd\bosh-lock\name -Raw).trim()
$Env:CF_INT_PASSWORD=(Get-Content $pwd\cf-credentials\cf-password -Raw).trim()
$Env:CF_INT_OIDC_PASSWORD=(Get-Content $pwd\cf-credentials\uaa-oidc-password -Raw).trim()
$Env:CF_INT_OIDC_USERNAME="admin-oidc"
$Env:CF_INT_API="https://api.$DOMAIN"
$Env:SKIP_SSL_VALIDATION="false"

$CF_INT_NAME = $DOMAIN.split(".")[0]
Import-Certificate -Filepath "$pwd\cf-credentials\cert_dir\$CF_INT_NAME.lb.cert" -CertStoreLocation "cert:\LocalMachine\root"
Import-Certificate -Filepath "$pwd\cf-credentials\cert_dir\$CF_INT_NAME.router.ca" -CertStoreLocation "cert:\LocalMachine\root"

pushd $pwd\cf-cli-binaries
	7z e cf-cli-binaries.tgz -y
	7z x cf-cli-binaries.tar -y
	Move-Item -Path $pwd\cf-cli_winx64.exe  -Destination ..\cf.exe -Force
popd

echo "Working Directory: $pwd"
echo "GOPATH:            $Env:GOPATH"

$Env:RUN_ID=(openssl rand -hex 16)
$Env:GOFLAGS = "-mod=vendor"

go get -v -u github.com/onsi/ginkgo/ginkgo
