$ErrorActionPreference = "Stop"
trap { $host.SetShouldExit(1) }

. "$PSScriptRoot\windows-setup.ps1"

$DOMAIN=(Get-Content $pwd\bosh-lock\name -Raw).trim()
$Env:CF_INT_PASSWORD=(Get-Content $pwd\cf-credentials\cf-password -Raw).trim()
$Env:CF_INT_OIDC_PASSWORD=(Get-Content $pwd\cf-credentials\uaa-oidc-password -Raw).trim()
$Env:CF_INT_OIDC_USERNAME="admin-oidc"
$Env:CF_INT_API="https://api.$DOMAIN"
$Env:CF_DIAL_TIMEOUT=15
$Env:SKIP_SSL_VALIDATION="false"

$CF_INT_NAME = $DOMAIN.split(".")[0]
Import-Certificate -Filepath "$pwd\cf-credentials\cert_dir\$CF_INT_NAME.lb.cert" -CertStoreLocation "cert:\LocalMachine\root"
Import-Certificate -Filepath "$pwd\cf-credentials\cert_dir\$CF_INT_NAME.router.ca" -CertStoreLocation "cert:\LocalMachine\root"

pushd $pwd\cf-cli-binaries
	7z e cf-cli-binaries.tgz -y
	7z x cf-cli-binaries.tar -y
	Move-Item -Path $pwd\cf-cli_winx64.exe  -Destination ..\cf.exe -Force
popd
