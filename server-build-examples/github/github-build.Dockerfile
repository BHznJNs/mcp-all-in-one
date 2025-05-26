FROM golang:latest AS builder

WORKDIR /app
RUN CGO_ENABLED=0 go install github.com/github/github-mcp-server/cmd/github-mcp-server@latest
RUN ls -l /go/bin/

# copy the built binary into a new image
# COPY --from=builder /go/bin/github-mcp-server /usr/local/bin/github-mcp-server
