# Parameters
imageName="webserverhello"
externalPort=8000
containerPort=8080
containerName=go_web_server
buildRunOption=${1}
host=default

if [ $buildRunOption == "" ]
then
	buildRunOption = "BuildRun"
fi

echo "Docker Build/Run Options: " $buildRunOption 

ImageBuild () {
	echo "Building the Image"
	# Clear out any running containers and images in place for our new build
	docker kill $(docker ps -a -q -f "image=$imageName")
	docker rm $(docker ps -a -q -f "image=$imageName")
	docker rmi $imageName
	# Build the new container image
	echo Build
	docker build -t $imageName ../src/
}

ImageRun () {
	echo "Running the Image"
	# Run it on the default port, with a target name
	docker run -p $externalPort:$containerPort -di --name=$containerName $imageName
	# Launch the page, assuming it's a web app 
	open http://$(docker-machine ip default):$externalPort
}
echo
echo "Host:" $host

case "$buildRunOption" in
	"Build")
		ImageBuild
		;;
	"Run")
		ImageRun
		;;
	"BuildRun")
		ImageBuild
		ImageRun
		;;
esac
