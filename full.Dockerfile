FROM golang:latest AS builder

WORKDIR /app
RUN CGO_ENABLED=0 go install github.com/github/github-mcp-server/cmd/github-mcp-server@latest
RUN ls -l /go/bin/

# --- --- --- --- --- ---

FROM ghcr.io/one-mcp/one-mcp:latest

# copy the built binary into a new image
COPY --from=builder /go/bin/github-mcp-server /usr/local/bin/github-mcp-server

# initiate rust environment
RUN apk add --no-cache rust cargo

# initiate java environment
RUN apk add --no-cache openjdk17-jre

COPY mcp.json /app/mcp.json
EXPOSE 7860
CMD . .venv/bin/activate && hypercorn src.main:app --bind 0.0.0.0:7860
