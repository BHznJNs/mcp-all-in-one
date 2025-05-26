# One MCP

An easy way to deploy multiple MCP servers in one Docker container. Based on [multi-mcp](https://github.com/One-MCP/multi-mcp).

## Getting Started

### Local Deploy

Clone this repo

```bash
git clone https://github.com/One-MCP/one-mcp
cd one-mcp
```

Build the Docker image

```bash
docker build -t one-mcp:latest .
```

Run

```bash
# user your GitHub token and Tavily key here
docker run -p 7860:7860 -e GITHUB_PERSONAL_ACCESS_TOKEN=ghp_123456 -e TAVILY_API_KEY=tvly-dev-123456 one-mcp:latest
```

### Deploy to Huggingface

[Click here](https://huggingface.co/new-space) to create a space, select Docker, and then in the Files tab, upload the `Dockerfile` and `mcp.json` in this repo.

Add secrets in Settings:

| Variable Name | Example Value | Description |
|      ---      |      ---      |     ---     |
| TAVILY_API_KEY | tavily-9876543210fedcba | Tavily Key |
| GITHUB_PERSONAL_ACCESS_TOKEN | ghp_9876543210fedcba | GitHub Key |

Click **Embed this Space** to get the link, e.g., `https://xxx-xxx.hf.space/`

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
When you trying to use MCP tools under `mcp-remote`, please takes the namespace, like:
   1. `github::add_issue_comment` instead of `add_issue_comment`
   2. `context7::resolve-library-id` instead of `resolve-library-id`
```

## Configuration

You can change the [``mcp.json``](./mcp.json) file to add what you want.
The detailed configuration can be found [here](https://github.com/One-MCP/multi-mcp?tab=readme-ov-file#configuration).

### Authentication

Authentication in this project is controlled by the AUTH_TOKEN environment variable:

- If the AUTH_TOKEN environment variable is not set: Authentication will be disabled, and all API requests can be accessed without a token.
- If the AUTH_TOKEN environment variable is set: Authentication will be enabled. All protected API requests must include a Bearer Token in the HTTP request header, and this token must exactly match the value of the AUTH_TOKEN environment variable.

When authentication is enabled, you'll need to include the Authorization header in your requests, like so:

```
Authorization: Bearer YOUR_AUTH_TOKEN_VALUE
```
