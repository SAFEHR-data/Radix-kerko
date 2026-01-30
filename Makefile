IMAGE := radix-kerko
PORT := 8080

build:
    docker build -t $(IMAGE) .

run:
    docker run --rm -p $(PORT):80 -v $$PWD/instance:/kerkoapp/instance $(IMAGE)
