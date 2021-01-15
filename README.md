# gobuild-embed-fileversioninfo
The build scripts help us in embedding file version info into the go binaries during build. And the code changes suggested below help us get the build/file version info from our binaries on user request.

The version info is shown on specific user input [customizable by editing the code snippet suggested below] 

Additionally, for windows executable the file version info will also be shown in the properties -> details section. 

## Prerequisits:
You should have mingw-w64 installed in the build machine where you desire to build your go binaries.

Note: Windres executable is part of Mingw-w64 which is used to create windows resource files for embedding the file version info in windows.

## Code snippets to include in your code:
In package main have variable declared as below.
```go
var BuildVersion string = ""
```
In func main, you can have a code as below which takes in user input, checks if the argument passed to executable is -v/--version and if so gives out the build version info. Note:  Change below code accordingly.

Note: The version info can be printed or logged anywhere as per your need. Below is a sample code which can be used as is.
```go
if len(os.Args) > 1 {
		in := strings.ToLower(os.Args[1])
    if in == "-v" || in == "--version" {
    	fmt.Println(strings.ReplaceAll(BuildVersion, ",", "."))
      return
    }
}
```

## To build go binary
* Edit version.txt with the desired build version.
  Eg. Edit version.txt with value as 1,1,0,0 if desired version is 1.1.0.0.
  Note: the version numbers are separated by ','(comma) and NOT '.'(dot)
* Run build.sh for linux platform
  or 
* Run build.bat for windows platform
* The binary is created with file version info embedded into it

Note 1: The go binaries gets built into the same folder where the build scripts re placed. If needed the build scripts can be edited to place them in certain folder with help of '-o' parameter during execution of 'go build' command.

Note 2: If version.txt file is missing then the binaries are built, but wont have any version embedded into it.

## To get version info from binary
    <your go binary> [-v/--version] - gives the build version
    Eg : test.exe -v  or test.exe --version
         1.0.0.0

## Screenshots of file version as seen in windows :
![fvi1](https://user-images.githubusercontent.com/75796552/104570674-40504a00-5678-11eb-8217-104514d61af8.jpg)
![fvi2](https://user-images.githubusercontent.com/75796552/104570670-3f1f1d00-5678-11eb-893f-a67a23456e36.jpg)

## Additional Info:
### Below are the things done by the build.bat for windows Go executable
* reads version from the verion.txt file
* creates a .rc windows resource file with this version info
* runs windres command to generate a .syso file from above created .rc file
* Embeds the version info using -ldflags buildflag while running the 'go build' command 
* removed the windows resource (.rc and .syso) files
### Below are the things done by the build.sh for linux Go binary
* reads version from the verion.txt file
* Embeds the version info using -ldflags buildflag while running the 'go build' command

## Improvements to be done in coming releases:
* Adding Product version, copyright and other info to the file.
