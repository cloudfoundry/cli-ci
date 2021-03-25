$Env:ROOT="$pwd"
Import-Module C:\ProgramData\chocolatey\helpers\chocolateyProfile.psm1
refreshenv
cd $Env:ROOT

echo "Working Directory: $pwd"
echo "GOPATH:            $Env:GOPATH"

$Env:PATH="$Env:GOPATH\bin;" + "$Env:PATH"
$Env:PATH="$pwd;" + "$Env:PATH"

echo "(2nd time) Working Directory: $pwd"
echo "(2nd time) GOPATH:            $Env:GOPATH"

pushd $Env:GOPATH\src\code.cloudfoundry.org\cli
	set-executionpolicy remotesigned
	
	echo "debugging"
	
	go version

	go get -u github.com/onsi/ginkgo/ginkgo

	ginkgo version

	$Env:GOFLAGS="-mod=vendor"
	ginkgo -r -randomizeAllSpecs -randomizeSuites -skipPackage integration -flakeAttempts=2 -tags="V7" .
popd
