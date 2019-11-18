all: build
get:
	curl -fSL https://github.com/cdr/code-server/releases/download/2.1692-vsc1.39.2/code-server2.1692-vsc1.39.2-linux-x86_64.tar.gz -o ./code-server.tar.gz
	tar -xvzf code-server.tar.gz -C files/code-server --strip-components 1

build: get 
	docker build . -t ${IMAGE}:${TAG} 

tag: build
	docker tag ${IMAGE}:${TAG} ${REPO}/${IMAGE}:${TAG}

push: tag
	docker push ${REPO}/${IMAGE}:${TAG}

