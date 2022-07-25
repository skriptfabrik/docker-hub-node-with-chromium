DOCKER_BUILDKIT := 1
BRANCH_NAME := $(if $(BRANCH_NAME),$(BRANCH_NAME),17.2)
IMAGE_NAME := $(if $(IMAGE_NAME),$(IMAGE_NAME),skriptfabrik/node-with-chromium)
TAG_NAME := $(if $(TAG_NAME),$(TAG_NAME),$(BRANCH_NAME)-local)

.PHONY: default
default: lint build-local test

.PHONY: lint
lint:
	@echo 'Linting Dockerfile'
	@docker run --rm -i hadolint/hadolint < ${BRANCH_NAME}/Dockerfile

.PHONY: build
build:
	@echo "Building Docker image"
	@docker buildx build --build-arg BUILDKIT_INLINE_CACHE=1 --cache-from type=registry,ref=${IMAGE_NAME}:latest --file ${BRANCH_NAME}/Dockerfile --platform linux/amd64 --platform linux/arm64 --pull --push --tag ${IMAGE_NAME}:${TAG_NAME} .

.PHONY: build-local
build-local:
	@echo "Building local Docker image"
	@docker buildx build --build-arg BUILDKIT_INLINE_CACHE=1 --cache-from type=registry,ref=${IMAGE_NAME}:latest --file ${BRANCH_NAME}/Dockerfile --load --pull --tag ${IMAGE_NAME}:${TAG_NAME} .

.PHONY: test
test:
	@echo "Testing Docker image build"
	@docker run --rm -v $(shell pwd)/bin:/root/bin ${IMAGE_NAME}:${TAG_NAME} sh /root/bin/test-docker-build-with-angular

.PHONY: clean
clean:
	@echo "Cleaning up Docker images"
	-@docker rmi --force $(shell docker images ${IMAGE_NAME}:${TAG_NAME} -q)
