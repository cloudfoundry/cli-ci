SET TARGET_V7=true

call C:\ProgramData\chocolatey\bin\RefreshEnv.cmd

SET GOPATH=%CD%\gopath
SET PATH=C:\ProgramData\chocolatey\bin;%PATH%
SET PATH=C:\Go\bin;C:\Program Files\Git\cmd\;%GOPATH%\bin;%PATH%
cd %GOPATH%\src\code.cloudfoundry.org\cli

powershell -command set-executionpolicy remotesigned

go version

go get -u github.com/onsi/ginkgo/ginkgo

ginkgo version

call make out/cf-cli_winx64.exe
call make units-plugin
call make units-non-plugin
