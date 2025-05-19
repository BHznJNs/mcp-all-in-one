# MCP All in One

An easy way to deploy multiple MCP servers in one Docker container. Based on [multi-mcp](https://github.com/kfirtoledo/multi-mcp).

## Getting Started

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

## Configuration

You can change the [``mcp.json``](./mcp.json) file to add what you want.
The detailed configuration can be found [here](https://github.com/kfirtoledo/multi-mcp?tab=readme-ov-file#%EF%B8%8F-configuration).
