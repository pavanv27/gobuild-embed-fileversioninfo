# gobuild-embed-fileversioninfo
This helps us in embedding file version info into our binaries.
For windows executable the file version info will also be available in the properties -> details section of the executable, as well as the version would also be shown by the executable on specific user input/as needed by the user.
For linux platform, the binary would show the version info on specific user input/as needed by the user
Script and code snippets which would help in embedding fileversion info to a go binary. 

## Prerequisits:
You should have mingw-w64 installed. [The mingw-w64 has the windres executable which is used to create windows resource files for embedding the file version info in windows].

## Code snippets to include in your code:
In package main have variable declared as below.
```go
var BuildVersion string = ""
```
In func main, You can have a code as below which takes in user input, checks if the argument post executable is -v/--version and if so gives out the build version info.
Note: The version info is availbale and can be printed or logged anywhere as per your need. Change below code accordingly. 
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
Edit version.txt with the desired build version. 
Eg. Edit version.txt with value as 1,1,0,0 if desired version is 1.1.0.0
    Run build.sh for linux platform
    Run build.bat for windows platform
On running build.sh file, the binary is created with file version info in the root healthmon directory 
(provided version.txt file exists and has version info).

## To get version info from binary
    <your go binary> [-v/--version] - gives the build version
    Eg : test.exe -v  or test.exe --version
         1.0.0.0

## Below are the things done by the build.bat for windows Go executable
* reads version from the verion.txt file
* creates a .rc windows resource file with this version info
* runs windres command to generate a .syso file from above created .rc file
* Embeds the version info using -ldflags buildflag while running the 'go build' command 
* removed the windows resource (.rc and .syso) files

## Below are the things done by the build.sh for linux Go binary
* reads version from the verion.txt file
* Embeds the version info using -ldflags buildflag while running the 'go build' command

## Screenshots of file version as seen in windows :
![fvi1](https://user-images.githubusercontent.com/75796552/104570674-40504a00-5678-11eb-8217-104514d61af8.jpg)
![fvi2](https://user-images.githubusercontent.com/75796552/104570670-3f1f1d00-5678-11eb-893f-a67a23456e36.jpg)

