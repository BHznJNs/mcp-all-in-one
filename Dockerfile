FROM alpine

WORKDIR /app

# initiate python environment
RUN apk add --no-cache python3 py3-pip git py3-uv

# initiate nodejs environment
RUN apk add --no-cache nodejs npm

# initiate multi-mcp
RUN git clone https://github.com/One-MCP/multi-mcp.git .
RUN uv venv
RUN . .venv/bin/activate 
RUN uv pip install -r requirements.txt

# copy the config file
COPY mcp.json /app/mcp.json

# prevent directory access permission error
RUN mkdir /app/.uv-cache && chmod -R 777 /app/.uv-cache
ENV UV_CACHE_DIR=/app/.uv-cache
RUN mkdir /app/.npm-cache && chmod -R 777 /app/.npm-cache
ENV npm_config_cache=/app/.npm-cache

EXPOSE 7860
CMD . .venv/bin/activate && hypercorn src.main:app --bind 0.0.0.0:7860
