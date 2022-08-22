$ErrorActionPreference = "Stop"

. "$PSScriptRoot\..\..\shared\tasks\integration-windows-setup-toolsmiths.ps1"

cd $Env:GOPATH\src\code.cloudfoundry.org\cli

echo "CF_INT_API============: $CF_INT_API"

$CF_PASSWORD=${CF_INT_PASSWORD}
cf8.exe api $CF_INT_API --skip-ssl-validation
cf8.exe auth
cf8.exe enable-feature-flag route_sharing

ginkgo.exe -r `
	-nodes=16 `
	-flakeAttempts=2 `
	-slowSpecThreshold=60 `
	-randomizeAllSpecs `
	./integration/shared/isolated `
	./integration/v7/isolated `
	./integration/shared/experimental `
	./integration/v7/experimental `
	./integration/v7/push

if ($LASTEXITCODE -gt 0)
{
	exit 1
}

ginkgo.exe -r `
	-flakeAttempts=2 `
	-slowSpecThreshold=60 `
	-randomizeAllSpecs `
	./integration/shared/global `
	./integration/v7/global

if ($LASTEXITCODE -gt 0)
{
	exit 1
}
