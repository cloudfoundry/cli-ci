echo "PWD: $pwd"
Get-ChildItem Env: | Format-Table -Wrap -AutoSize

$Env:ROOT="$pwd"
Import-Module C:\ProgramData\chocolatey\helpers\chocolateyProfile.psm1
refreshenv
cd $Env:ROOT

Get-ChildItem Env: | Format-Table -Wrap -AutoSize

$Env:PATH="$Env:GOPATH\bin;" + "$Env:PATH"
$Env:PATH="$pwd;" + "$Env:PATH"

Get-ChildItem Env: | Format-Table -Wrap -AutoSize

pushd $Env:GOPATH\src\code.cloudfoundry.org\cli
	set-executionpolicy remotesigned
	
	Get-ChildItem Env: | Format-Table -Wrap -AutoSize
	go version
	
	$Env:GOFLAGS="-mod=vendor"
	ginkgo -r -randomizeAllSpecs -randomizeSuites -skipPackage integration -flakeAttempts=2 -tags="V7" .
popd
