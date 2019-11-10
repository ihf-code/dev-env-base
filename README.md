# IHF:Code Base Image

### Purpose

We noticed a common issue when delivering training to people, the equipment and operating environment can vary from person to person, leading to a lot of issues and usage of precious learning time trying to diagnose IT issues.

To remedy this and concentrate on learning, we developed a solution based off the code-server project to enable a containerised IDE that has a set of development tools off and can be accessed via a web browser.

[https://github.com/cdr/code-server](https://github.com/cdr/code-server)

This image is the base image we use to build our development environments upon, it is based off the debian:buster-slim image which sits around 27mb in size.

### Usage

This image will bring up a basic IDE but will have very little installed, it's useful to use this image as a base image.

### Running locally

To run this image using docker locally use the following command

<pre><code>
docker run -it -p 127.0.0.1:8080:8080 -e PASSWORD=password \
	-v /Users/gary/Developer:/home/coder/project \
	--user coder ihfcode/code-base:latest
</code></pre>

The user must be set to coder for the environment to come up correctly.

The port Code-Server runs on is 8080
You can set a password using the -e PASSWORD=<mypassword> environment variable
You can mount a folder into the IDE using the -v flag to docker.

### Accessing the environment

When you run the docker command above, the environment can be accessed via a Web browser using the url : http://localhost:8080

### Building development environments

You can use this image as a base image for more detailed development environments, by using the Dockerfile FROM ihfcode/code-env:latest image.
