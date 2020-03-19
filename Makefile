BRANCH_NAME:=$(if $(BRANCH_NAME),$(BRANCH_NAME),13.10)
IMAGE_NAME:=$(if $(IMAGE_NAME),$(IMAGE_NAME),skriptfabrik/node-with-chromium)
TAG_NAME:=$(if $(TAG_NAME),$(TAG_NAME),$(BRANCH_NAME)-local)

.PHONY: default
default: lint build test

.PHONY: lint
lint:
	@echo 'Linting Dockerfile'
	@docker run --rm -i hadolint/hadolint < ${BRANCH_NAME}/Dockerfile

.PHONY: build
build:
	@echo "Building Docker image"
	@docker pull ${IMAGE_NAME}:${TAG_NAME} || true
	@docker build --cache-from ${IMAGE_NAME}:${TAG_NAME} --file ${BRANCH_NAME}/Dockerfile --tag ${IMAGE_NAME}:${TAG_NAME} .

.PHONY: test
test:
	@echo "Testing Docker image build"
	@docker run --rm -v $(shell pwd)/bin:/root/bin ${IMAGE_NAME}:${TAG_NAME} sh /root/bin/test-docker-build-with-angular

.PHONY: clean
clean:
	@echo "Cleaning up Docker images"
	-@docker rmi --force $(shell docker images ${IMAGE_NAME}:${TAG_NAME} -q)
