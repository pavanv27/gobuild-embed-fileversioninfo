@echo OFF
setlocal ENABLEDELAYEDEXPANSION
set versionfile=version.txt
set rcfile=version.rc
set sysofile=version.syso
IF EXIST !versionfile! (
    echo Found !versionfile! file. Building binaries with version info.
    set /P buildver=<!versionfile!
    echo Version : !buildver!
    echo 1 VERSIONINFO> !rcfile!
    echo FILEVERSION !buildver! >> !rcfile!
    echo BEGIN>> !rcfile!
    echo    BLOCK "VarFileInfo">> !rcfile!
    echo    BEGIN>> !rcfile!
    echo        VALUE "Translation", 0x0, 0x04B0>> !rcfile!
    echo    END>> !rcfile!
    echo END>> !rcfile!
    echo Generating windows resource files
    windres -i !rcfile! -O coff -o !sysofile!
) ELSE (
    echo !versionfile! file missing. Building binaries without version info
    set buildver=
    echo Version : !buildver!
)
echo Running go build
go build -ldflags="-X 'main.BuildVersion=!buildver!'" 
IF EXIST !versionfile! (
    del !rcfile!
    del !sysofile!
)
endlocal