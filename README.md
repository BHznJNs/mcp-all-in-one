# One MCP

An easy way to deploy multiple MCP servers in one Docker container. Based on [multi-mcp](https://github.com/One-MCP/multi-mcp).

## Getting Started

### Local Deploy

```bash
docker pull ghcr.io/one-mcp/one-mcp:latest
docker run -p 7860:7860 one-mcp:latest
```

### Extend the Image

You can based the Dockerfile in this repo to add things you need.
For example, you can use [such a Dockerfile](./server-build-examples/github/complete.Dockerfile) for the use of [GitHub MCP](https://github.com/github/github-mcp-server).

You can also initialize environments like rust and java like this:

```dockerfile
FROM ghcr.io/one-mcp/one-mcp:latest

# initiate rust environment
RUN apk add --no-cache rust cargo

# initiate java environment
RUN apk add --no-cache openjdk17-jre

# normally run the service
COPY mcp.json /app/mcp.json
EXPOSE 7860
CMD . .venv/bin/activate && hypercorn src.main:app --bind 0.0.0.0:7860
```

### Use in your MCP client

In your MCP client, if your client does not support remote MCP server, or if you used [authentication](#Authentication) that most clients does not support, please follows instructions below:

1. Use these JSON in your MCP client config file:
```json
{
  "mcpServers": {
    "mcp-proxy": {
      "command": "npx",
      "args": [
        "mcp-remote",
        "https://example.com/sse",
        "--header",
        "Authorization: Bearer <your-auth-token>"
      ]
    }
  }
}
```

If you are using Windows and Cline, you can try this:
```json
{
  "mcpServers": {
    "mcp-proxy": {
      "command": "cmd",
      "args": [
        "/c",
        "npx",
        "mcp-remote",
        "https://example.com/sse",
        "--header", "Authorization: Bearer <your-auth-token>"
      ]
    }
  }
}
```
2. Try to connect.

### Extra prompts

This tool aggregates all of your selected MCP servers under one server, and used namespace like `server_name::tool_name` to avoid conflicts and allow multiple servers to expose tools with the same base name. But for some MCP clients, the model does not use the namespaced name, but uses tool name standalone, which will cause error.
You can try to use such a prompt to avoid that:

```
When you trying to use MCP tools, please use the `mcp-proxy` as server name and takes the namespace for tool names and resource names, like:
   1. `github::add_issue_comment` instead of `add_issue_comment`
   2. `context7::resolve-library-id` instead of `resolve-library-id`
   3. `tavily::tavily-search` instead of `tavily-search`
   4. `chart-generator::generate_bar_chart` instead of `generate_bar_chart`
```

## Configuration

You can change the [``mcp.json``](./mcp.json) file to add what you want.
The detailed configuration can be found [here](https://github.com/One-MCP/multi-mcp?tab=readme-ov-file#configuration).

### Authentication

Authentication in this project is controlled by the `AUTH_TOKEN` environment variable:

- If the AUTH_TOKEN environment variable is not set: Authentication will be disabled, and all API requests can be accessed without a token.
- If the AUTH_TOKEN environment variable is set: Authentication will be enabled. All protected API requests must include a Bearer Token in the HTTP request header, and this token must exactly match the value of the AUTH_TOKEN environment variable.

When authentication is enabled, you'll need to include the Authorization header in your requests, like so:

```
Authorization: Bearer YOUR_AUTH_TOKEN_VALUE
```
