#Samples for using Docker, VS Code and GO

##Requirements
To use these samples you'll need the following
- [Visual Studio Code](https://www.visualstudio.com/en-us/products/code-vs.aspx)
- [DockerToolbox](https://www.docker.com/docker-toolbox) - Provides: 
	- Docker Client
	- Docker Machine
	- Docker Compose (Mac only)
	- Docker Kitematic
	- VirtualBox
- [GOLang](https://golang.org/dl/) - The GO language runtime

#Running the Samples
##GO_WebServerHelloWorld
This sample focuses on the very basics to creating a GO app, running as a web server, and running within a container
The contents of the sample include:
- /src/`WebServerHello.go` the single code file that runs our Hello World Web Server Response
- /src/`Dockerfile` our Dockerfile specific to the GO environment that compiles the .go source and starts the web server
- /Scripts/`dockerBuildRun.sh` a script used to build and/or run docker images and containers. This script is where you actually test your changes within a container
 