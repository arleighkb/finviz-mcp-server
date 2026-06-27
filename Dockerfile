FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY src/ ./src/
COPY pyproject.toml .
COPY run_server.py .

RUN pip install --no-cache-dir .

ENV PYTHONUNBUFFERED=1
ENV LOG_LEVEL=INFO
ENV RATE_LIMIT_REQUESTS_PER_MINUTE=100
ENV MCP_TRANSPORT=sse
ENV MCP_HOST=0.0.0.0
ENV MCP_PORT=8000
ENV PORT=8000

EXPOSE 8000

CMD ["sh", "-c", "MCP_TRANSPORT=sse MCP_HOST=0.0.0.0 MCP_PORT=${PORT:-8000} finviz-mcp-server"]
