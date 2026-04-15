FROM python:3.12-slim

WORKDIR /app

ENV UV_CONFIG_FILE=/app/.config/uv/uv.toml
ENV PATH="/app/.venv/bin:$PATH"

RUN pip install --no-cache-dir uv

COPY pyproject.toml uv.lock ./
COPY .config/uv/uv.toml .config/uv/uv.toml

RUN uv sync --locked --no-dev

COPY . .

EXPOSE 8000
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
