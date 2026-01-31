IMAGE := radix-kerko
PORT := 10000

# If KERKO_SYNC_ON_START is set in your shell, pass it into docker.
DOCKER_SYNC_ENV :=
ifeq ($(KERKO_SYNC_ON_START),1)
	DOCKER_SYNC_ENV := -e KERKO_SYNC_ON_START=1
endif

build:
	docker build -t $(IMAGE) .

index:
	docker build -t $(IMAGE) . ; \
	docker run --rm \
  	-v $$PWD/instance:/kerkoapp/instance \
  	$(IMAGE) \
  	sh -lc 'flask kerko clean index && flask kerko sync index'

sync:
	docker run --rm \
  	-v $$PWD/instance:/kerkoapp/instance \
  	$(IMAGE) \
  	sh -lc 'flask kerko sync'

run:
	docker run --rm \
		-e PORT=$(PORT) \
		$(DOCKER_SYNC_ENV) \
		-p $(PORT):$(PORT) \
		-v $$PWD/instance:/kerkoapp/instance \
		$(IMAGE)
