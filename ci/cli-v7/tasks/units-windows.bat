SET TARGET_V7=true
SET GOPATH=%CD%\gopath

C:\ProgramData\chocolatey\bin\RefreshEnv.cmd

SET PATH=C:\ProgramData\chocolatey\bin;%PATH%
SET PATH=C:\Go\bin;C:\Program Files\Git\cmd\;%GOPATH%\bin;%PATH%
cd %GOPATH%\src\code.cloudfoundry.org\cli

powershell -command set-executionpolicy remotesigned

go version

go get -u github.com/onsi/ginkgo/ginkgo

ginkgo version

call make units-full
