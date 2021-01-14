#!/usr/bin/sh
if test -f version.txt
then
    echo Found version.txt. Building binaries with version info
    bver=`head -1 version.txt`
else
    echo version.txt missing. Building binaries without version info.
    bver=""
fi
echo Version = $bver
echo Running go build
go build -ldflags="-X 'main.BuildVersion=$bver'"