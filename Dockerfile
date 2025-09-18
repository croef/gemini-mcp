# Build stage
FROM golang:1.23-alpine AS builder

# Install git (needed for go modules with private repos)
RUN apk add --no-cache git ca-certificates tzdata

# Create appuser for security
RUN adduser -D -g '' appuser

# Set working directory
WORKDIR /build

# Copy go mod files
COPY go.mod go.sum ./

# Download dependencies
RUN go mod download
RUN go mod verify

# Copy source code
COPY . .

# Build arguments for version information
ARG VERSION=dev
ARG BUILD_TIME
ARG GIT_COMMIT

# Build the application
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build \
    -ldflags="-w -s -X main.version=${VERSION} -X 'main.buildTime=${BUILD_TIME}' -X main.gitCommit=${GIT_COMMIT}" \
    -o gemini-mcp main.go

# Final stage
FROM scratch

# Import from builder
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /usr/share/zoneinfo /usr/share/zoneinfo
COPY --from=builder /etc/passwd /etc/passwd

# Copy binary
COPY --from=builder /build/gemini-mcp /app/gemini-mcp

# Use appuser
USER appuser

# Set working directory
WORKDIR /app

# Create output directory
RUN mkdir -p /app/output

# Environment variables
ENV OUTPUT_DIR=/app/output
ENV TRANSPORT=stdio

# Expose health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD ./gemini-mcp -version || exit 1

# Default command
ENTRYPOINT ["./gemini-mcp"]