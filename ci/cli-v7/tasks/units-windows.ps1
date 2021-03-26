$ErrorActionPreference = "Stop";
trap { $host.SetShouldExit(1) }

echo "Work Directory: $pwd"

$Env:ROOT="$pwd"
Import-Module C:\ProgramData\chocolatey\helpers\chocolateyProfile.psm1
refreshenv
cd $Env:ROOT

$null = New-Item -ItemType Directory -Force -Path $Env:TEMP

$Env:GOPATH="$Env:ROOT\go"
$Env:PATH="$Env:GOPATH\bin;" + "$Env:PATH"

if ((Get-Command "ginkgo.exe" -ErrorAction SilentlyContinue) -eq $null) {
  go get -v -u github.com/onsi/ginkgo/ginkgo
}

pushd $Env:GOPATH\src\code.cloudfoundry.org\cli
  set-executionpolicy remotesigned

  go version
  ginkgo version

  $Env:GOFLAGS="-mod=vendor"
  ginkgo -r -randomizeAllSpecs -randomizeSuites -skipPackage integration -flakeAttempts=2 -tags="V7" .
popd
