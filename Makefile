.PHONY: build clean run test install deps release docker

# Variables
BINARY_NAME=gemini-mcp
BUILD_DIR=build
OUTPUT_DIR=output

# Version information
VERSION ?= $(shell git describe --tags --always --dirty 2>/dev/null || echo "dev")
BUILD_TIME ?= $(shell date -u '+%Y-%m-%d %H:%M:%S UTC')
GIT_COMMIT ?= $(shell git rev-parse HEAD 2>/dev/null || echo "unknown")

# Build flags
LDFLAGS=-ldflags "-X main.version=${VERSION} -X 'main.buildTime=${BUILD_TIME}' -X main.gitCommit=${GIT_COMMIT} -s -w"

# Build the application
build:
	@echo "Building $(BINARY_NAME) v$(VERSION)..."
	@mkdir -p $(BUILD_DIR)
	CGO_ENABLED=0 go build $(LDFLAGS) -o $(BUILD_DIR)/$(BINARY_NAME) main.go

# Build for multiple platforms
release:
	@echo "Building $(BINARY_NAME) v$(VERSION) for multiple platforms..."
	@mkdir -p $(BUILD_DIR)
	@for os in linux darwin windows; do \
		for arch in amd64 arm64; do \
			if [ "$$os" = "windows" ]; then \
				ext=".exe"; \
			else \
				ext=""; \
			fi; \
			echo "Building for $$os/$$arch..."; \
			GOOS=$$os GOARCH=$$arch CGO_ENABLED=0 go build $(LDFLAGS) \
				-o $(BUILD_DIR)/$(BINARY_NAME)-$(VERSION)-$$os-$$arch$$ext main.go; \
		done; \
	done

# Install dependencies
deps:
	@echo "Installing dependencies..."
	go mod tidy
	go mod download

# Clean build artifacts
clean:
	@echo "Cleaning build artifacts..."
	rm -rf $(BUILD_DIR)
	rm -rf $(OUTPUT_DIR)

# Run the application in stdio mode
run: build
	@echo "Running $(BINARY_NAME) in stdio mode..."
	@mkdir -p $(OUTPUT_DIR)
	$(BUILD_DIR)/$(BINARY_NAME)

# Run the application in SSE mode
run-sse: build
	@echo "Running $(BINARY_NAME) in SSE mode..."
	@mkdir -p $(OUTPUT_DIR)
	$(BUILD_DIR)/$(BINARY_NAME) -transport=sse -port=8080

# Test the application
test:
	@echo "Running tests..."
	go test -v ./...

# Install the binary to GOPATH/bin
install: build
	@echo "Installing $(BINARY_NAME)..."
	cp $(BUILD_DIR)/$(BINARY_NAME) $(GOPATH)/bin/

# Format code
fmt:
	@echo "Formatting code..."
	go fmt ./...

# Lint code
lint:
	@echo "Linting code..."
	golangci-lint run

# Docker targets
docker:
	@echo "Building Docker image $(BINARY_NAME):$(VERSION)..."
	docker build \
		--build-arg VERSION=$(VERSION) \
		--build-arg BUILD_TIME="$(BUILD_TIME)" \
		--build-arg GIT_COMMIT=$(GIT_COMMIT) \
		-t $(BINARY_NAME):$(VERSION) \
		-t $(BINARY_NAME):latest .

docker-run:
	@echo "Running Docker container..."
	docker run --rm -it \
		-e GOOGLE_API_KEY \
		-v $(PWD)/output:/app/output \
		$(BINARY_NAME):latest

# Show version
version:
	@echo "Version: $(VERSION)"
	@echo "Build Time: $(BUILD_TIME)"
	@echo "Git Commit: $(GIT_COMMIT)"

# Show help
help:
	@echo "Available targets:"
	@echo "  build      - Build the application"
	@echo "  release    - Build for multiple platforms"
	@echo "  deps       - Install dependencies"
	@echo "  clean      - Clean build artifacts"
	@echo "  run        - Run in stdio mode"
	@echo "  run-sse    - Run in SSE mode"
	@echo "  test       - Run tests"
	@echo "  install    - Install binary to GOPATH/bin"
	@echo "  fmt        - Format code"
	@echo "  lint       - Lint code"
	@echo "  docker     - Build Docker image"
	@echo "  docker-run - Run Docker container"
	@echo "  version    - Show version information"
	@echo "  help       - Show this help"