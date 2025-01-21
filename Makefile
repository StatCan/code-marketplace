lint: lint/go
.PHONY: lint

lint/go:
	golangci-lint run
.PHONY: lint/go

test-clean:
	go clean -testcache
.PHONY: test-clean

test: test-clean
	gotestsum -- -v -short -coverprofile coverage ./...
.PHONY: test

coverage:
	go tool cover -func=coverage
.PHONY: coverage

gen:
	bash ./fixtures/generate.bash
.PHONY: gen

upload:
	bash ./fixtures/upload.bash
.PHONY: gen

TAG=$(shell git describe --always)

build:
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags "-X github.com/coder/code-marketplace/buildinfo.tag=$(TAG)" -o bin/code-marketplace-linux-amd64 ./cmd/marketplace/main.go
.PHONY: build
