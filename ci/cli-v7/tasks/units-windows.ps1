$ErrorActionPreference = "Stop"
trap { $host.SetShouldExit(1) }

. "$PSScriptRoot\..\..\shared\tasks\windows-setup.ps1"

pushd $Env:ROOT\go\src\code.cloudfoundry.org\cli
  Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

  go version
  ginkgo version

  ginkgo -r `
  -randomizeAllSpecs `
  -randomizeSuites `
  -skipPackage integration `
  -flakeAttempts=2 `
  -tags="V7"
popd
