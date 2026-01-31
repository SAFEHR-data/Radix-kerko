IMAGE := radix-kerko
PORT := 10000

build:
	docker build -t $(IMAGE) .

run:
	docker run --rm \
		-e PORT=$(PORT) \
		-p $(PORT):$(PORT) \
		-v $$PWD/instance:/kerkoapp/instance \
		$(IMAGE)
