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
docker run -p 8080:8080 -e GITHUB_PERSONAL_ACCESS_TOKEN=ghp_123456 -e TAVILY_API_KEY=tvly-dev-123456 one-mcp:latest
```

### Deploy to Huggingface

[Click here](https://huggingface.co/new-space) to create a space, select Docker, and then in the Files tab, upload the `Dockerfile` and `mcp.json` in this repo.

Add secrets in Settings:

| Variable Name | Example Value | Description |
|     - - -     |     - - -     |    - - -    |
| TAVILY_API_KEY | tavily-9876543210fedcba | Tavily Key |
| GITHUB_PERSONAL_ACCESS_TOKEN | ghp_9876543210fedcba | GitHub Key|

Click **Embed this Space** to get the link, e.g., `https://xxx-xxx.hf.space/`

In your MCP client, select Remote servers, fill in the link obtained above, and add sse (e.g., `https://xxx-xxx.hf.space/sse`) to use it.

## Configuration

You can change the [``mcp.json``](./mcp.json) file to add what you want.
The detailed configuration can be found [here](https://github.com/kfirtoledo/multi-mcp?tab=readme-ov-file#%EF%B8%8F-configuration).

### Authentication

Authentication in this project is controlled by the AUTH_TOKEN environment variable:

- If the AUTH_TOKEN environment variable is not set: Authentication will be disabled, and all API requests can be accessed without a token.
- If the AUTH_TOKEN environment variable is set: Authentication will be enabled. All protected API requests must include a Bearer Token in the HTTP request header, and this token must exactly match the value of the AUTH_TOKEN environment variable.

When authentication is enabled, you'll need to include the Authorization header in your requests, like so:

```
Authorization: Bearer YOUR_AUTH_TOKEN_VALUE
```
