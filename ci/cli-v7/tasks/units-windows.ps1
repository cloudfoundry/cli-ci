$Env:ROOT="$pwd"
Import-Module C:\ProgramData\chocolatey\helpers\chocolateyProfile.psm1
refreshenv
cd $Env:ROOT

$Env:GOPATH="$pwd\go"
$Env:PATH="$Env:GOPATH\bin;" + "$Env:PATH"
$Env:PATH="$pwd;" + "$Env:PATH"
pushd $Env:GOPATH\src\code.cloudfoundry.org\cli
	set-executionpolicy remotesigned

	go version

	go get -u github.com/onsi/ginkgo/ginkgo

	ginkgo version

	$Env:GOFLAGS="-mod=vendor"
	ginkgo -r -randomizeAllSpecs -randomizeSuites -skipPackage integration -flakeAttempts=2 -tags="V7" .
popd
