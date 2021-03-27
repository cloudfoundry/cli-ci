$ErrorActionPreference = "Stop"
trap { $host.SetShouldExit(1) }

& "$PSScriptRoot\..\..\shared\tasks\windows-setup.ps1"
& "$PSScriptRoot\create-installers-windows.bat"
