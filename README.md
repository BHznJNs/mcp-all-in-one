# MCP All in One

An easy way to deploy multiple MCP servers in one Docker container. Based on [multi-mcp](https://github.com/kfirtoledo/multi-mcp).

## Getting Started

### Local Deploy

Clone this repo

```bash
git clone https://github.com/BHznJNs/mcp-allinone
cd mcp-allinone
```

Build the Docker image

```bash
docker build -t mcp-allinone:latest .
```

Run

```bash
docker run -p 8080:8080 -e GITHUB_PERSONAL_ACCESS_TOKEN=ghp_123456 -e TAVILY_API_KEY=tvly-dev-123456 mcp-allinone:latest
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
