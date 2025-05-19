# Build github mcp server
FROM golang:latest AS builder

WORKDIR /app
RUN CGO_ENABLED=0 go install github.com/github/github-mcp-server/cmd/github-mcp-server@latest
RUN ls -l /go/bin/


FROM alpine

# copy github mcp server binary
COPY --from=builder /go/bin/github-mcp-server /usr/local/bin/github-mcp-server

WORKDIR /app

# initiate python environment
RUN apk add --no-cache python3 py3-pip git py3-uv

# initiate nodejs environment
RUN apk add --no-cache nodejs npm

# initiate multi-mcp
RUN git clone https://github.com/kfirtoledo/multi-mcp.git .
RUN uv venv
RUN uv pip install -r requirements.txt

# copy the config file
COPY mcp.json /app/mcp.json

CMD ["uv", "run", "main.py", "--host", "0.0.0.0", "--port", "8080", "--config", "mcp.json", "--transport", "sse"]
