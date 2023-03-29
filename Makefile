.PHONY: build push

###### Variables ######

DOCKER_REPOSITORY = quay.io/toucantoco/gotenberg
GOTENBERG_VERSION = 6.4.4

###### Docker ######

build: ## Build the Gotenberg's Docker image
	docker build --no-cache \
	-t ${DOCKER_REPOSITORY}:${GOTENBERG_VERSION} \
	-f Dockerfile .

push:
	docker push ${DOCKER_REPOSITORY}:${GOTENBERG_VERSION}