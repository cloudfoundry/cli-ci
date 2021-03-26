echo "PWD: $pwd"

$Env:ROOT="$pwd"
Import-Module C:\ProgramData\chocolatey\helpers\chocolateyProfile.psm1
refreshenv
cd $Env:ROOT

go get -v -u github.com/onsi/ginkgo/ginkgo

pushd $Env:GOPATH\src\code.cloudfoundry.org\cli
	set-executionpolicy remotesigned
	
	Get-ChildItem Env: | Format-Table -Wrap -AutoSize
	go version
	
	$Env:GOFLAGS="-mod=vendor"
	ginkgo -r -randomizeAllSpecs -randomizeSuites -skipPackage integration -flakeAttempts=2 -tags="V7" .
popd
