# Pararam Nexus MCP

A Model Context Protocol (MCP) server for interacting with [pararam.io](https://pararam.io) - a modern communication and collaboration platform.

## About pararam.io

Pararam.io is a communication platform that provides:

- **Messaging**: Create groups and private chats
- **Team Organization**: Organize people into teams
- **Communication**: Group and private calls (audio and video)
- **Cross-platform**: Available on mobile (iOS, Android, Huawei) and web

This MCP server uses the `pararamio-aio` library to provide asynchronous access to pararam.io features through the Model Context Protocol.

## Features

- Asynchronous API client for pararam.io
- Two-factor authentication support
- User search capabilities
- Chat message management
- User profile management
- Group interactions

## Installation

```bash
uv sync --dev
```

## Configuration

Create a `.env` file with your pararam.io credentials:

```env
PARARAM_LOGIN=your_login
PARARAM_PASSWORD=your_password
PARARAM_2FA_KEY=your_2fa_key  # Optional
```

## Usage

Run the server:

```bash
uv run pararam-nexus-mcp
```

## Development

Install pre-commit hooks:

```bash
uv run pre-commit install
```

Run linting and formatting:

```bash
uv run ruff check --fix src/
uv run ruff format src/
```

Run type checking:

```bash
uv run mypy src/pararam_nexus_mcp
```

Run tests:

```bash
uv run pytest
```

## Dependencies

- **FastMCP**: Model Context Protocol server framework
- **pararamio-aio**: Async Python client for pararam.io API
- **httpx**: Modern HTTP client
- **Pydantic**: Data validation using Python type annotations

## License

MIT