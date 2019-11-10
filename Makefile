all: build
get:
	curl -fSL https://github.com/cdr/code-server/releases/download/2.1665-vsc1.39.2/code-server2.1665-vsc1.39.2-linux-x86_64.tar.gz -o ./code-server.tar.gz
	tar -xvzf code-server.tar.gz -C files/code-server --strip-components 1

build: 
	docker build . -t code-base:latest

tag: build
	docker tag code-base:latest ihfcode/code-base:latest

push: tag
	docker push ihfcode/code-base:latest

