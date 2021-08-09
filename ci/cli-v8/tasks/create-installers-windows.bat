SET ROOT_DIR=%CD%
SET ESCAPED_ROOT_DIR=%ROOT_DIR:\=\\%
SET /p VERSION=<%ROOT_DIR%\cli\BUILD_VERSION

sed -i -e "s/VERSION/%VERSION%/" %ROOT_DIR%\cli-ci\ci\installers\windows\windows-installer-x64.iss
sed -i -e "s/CF_LICENSE/%ESCAPED_ROOT_DIR%\\LICENSE/" %ROOT_DIR%\cli-ci\ci\installers\windows\windows-installer-x64.iss
sed -i -e "s/CF_NOTICE/%ESCAPED_ROOT_DIR%\\NOTICE/" %ROOT_DIR%\cli-ci\ci\installers\windows\windows-installer-x64.iss
sed -i -e "s/CF_SOURCE/%ESCAPED_ROOT_DIR%\\cf8.exe/" %ROOT_DIR%\cli-ci\ci\installers\windows\windows-installer-x64.iss
sed -i -e "s/CF_ICON/%ESCAPED_ROOT_DIR%\\cf.ico/" %ROOT_DIR%\cli-ci\ci\installers\windows\windows-installer-x64.iss

TYPE %ROOT_DIR%\cli-ci\ci\license\LICENSE-WITH-3RD-PARTY-LICENSES | MORE /P > LICENSE
TYPE %ROOT_DIR%\cli-ci\ci\license\NOTICE | MORE /P > NOTICE
COPY %ROOT_DIR%\cli-ci\ci\installers\windows\cf.ico cf.ico

MOVE %ROOT_DIR%\extracted-binaries\cf8-cli_winx64.exe cf8.exe
mklink cf8.exe cf.exe

ISCC %ROOT_DIR%\cli-ci\ci\installers\windows\windows-installer-x64.iss

MOVE %ROOT_DIR%\cli-ci\ci\installers\windows\Output\mysetup.exe cf8_installer.exe

7z a %ROOT_DIR%\winstallers\cf8-cli-installer_winx64.zip cf8_installer.exe

sed -i -e "s/VERSION/%VERSION%/" %ROOT_DIR%\cli-ci\ci\installers\windows\windows-installer-x86.iss
sed -i -e "s/CF_LICENSE/%ESCAPED_ROOT_DIR%\\LICENSE/" %ROOT_DIR%\cli-ci\ci\installers\windows\windows-installer-x86.iss
sed -i -e "s/CF_NOTICE/%ESCAPED_ROOT_DIR%\\NOTICE/" %ROOT_DIR%\cli-ci\ci\installers\windows\windows-installer-x86.iss
sed -i -e "s/CF_SOURCE/%ESCAPED_ROOT_DIR%\\cf8.exe/" %ROOT_DIR%\cli-ci\ci\installers\windows\windows-installer-x86.iss
sed -i -e "s/CF_ICON/%ESCAPED_ROOT_DIR%\\cf.ico/" %ROOT_DIR%\cli-ci\ci\installers\windows\windows-installer-x86.iss

MOVE %ROOT_DIR%\extracted-binaries\cf8-cli_win32.exe cf8.exe
mklink cf.exe cf8.exe

ISCC %ROOT_DIR%\cli-ci\ci\installers\windows\windows-installer-x86.iss

MOVE %ROOT_DIR%\cli-ci\ci\installers\windows\Output\mysetup.exe cf8_installer.exe

7z a %ROOT_DIR%\winstallers\cf8-cli-installer_win32.zip cf8_installer.exe