# Use the golang image for all the go dependencies
FROM golang
#Expose Port 8080 on the container
EXPOSE 8080 
# Add the current directory of source to the container image in the src directory, which is where go install will look by default
ADD . ./src/WebServerHello
# compile the source, create executable and run it
RUN go install ./src/WebServerHello
# Set the entrypoint to host the web server
# By default, GO uses the folder of the source as the name of the executable
ENTRYPOINT WebServerHello

