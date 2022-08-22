$ErrorActionPreference = "Stop"
trap { $host.SetShouldExit(1) }

. "$PSScriptRoot\windows-setup.ps1"

$CF_INT_NAME=(Get-Content $pwd\gcp-env\name -Raw).trim()
$Env:CF_INT_PASSWORD=(Get-Content $pwd\cf-credentials\cf-password -Raw).trim()
$Env:CF_INT_OIDC_PASSWORD=(Get-Content $pwd\cf-credentials\uaa-oidc-password -Raw).trim()
$Env:CF_INT_OIDC_USERNAME="admin-oidc"
$Env:CF_INT_API="https://api.$CF_INT_NAME.cf-app.com"
$Env:CF_DIAL_TIMEOUT=15
# Enable SSL vaildation once toolsmiths supports it
# $Env:SKIP_SSL_VALIDATION="false"

Import-Certificate -Filepath "$pwd\cf-credentials\cert_dir\$CF_INT_NAME.router.ca" -CertStoreLocation "cert:\LocalMachine\root"

pushd $pwd\cf-cli-binaries
	7z e cf-cli-binaries.tgz -y
	7z x cf-cli-binaries.tar -y
	Move-Item -Path $pwd\cf-cli_winx64.exe  -Destination ..\cf.exe -Force
popd

echo "CF_INT_API=====1=======: $Env:CF_INT_API"