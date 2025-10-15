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
- Two-factor authentication support (TOTP)
- Session persistence with cookie storage
- Comprehensive chat and message management
- File attachment handling (upload and download)
- URL-based message retrieval
- Conversation thread building

## Available Tools

### Message Operations
- **search_messages**: Search for messages across all chats with advanced search syntax (Boolean operators, wildcards, filters)
- **get_chat_messages**: Get recent messages from a specific chat
- **send_message**: Send a message to a chat with optional reply and quote text
- **get_message_from_url**: Extract and retrieve a message from pararam.io URL

### Chat Operations
- **search_chats**: Search for chats by name or description
- **build_conversation_thread**: Build a conversation tree from a root message

### File Operations
- **upload_file_to_chat**: Upload files to a chat (from path or base64 content)
- **get_post_attachments**: List all attachments in a post
- **download_post_attachment**: Download attachments (to disk or as ImageContent)
  - 1MB size limit for downloads
  - Supported formats for direct display: images (JPEG, PNG, GIF, WEBP), documents (PDF, DOCX, DOC, TXT, RTF, ODT, HTML, EPUB), spreadsheets (XLSX, XLS, CSV), data (JSON, XML)
  - Returns ImageContent for supported types (displays natively in Claude Desktop/Code)
  - For unsupported types, requires output_path to save to disk
  - Saves to disk when output path is provided

### User Operations
- **search_users**: Search for users by name or unique name
- **get_user_info**: Get detailed information about a specific user
- **get_user_team_status**: Get user's status in teams (member, admin, guest)

## Tool Details

### send_message

Send a message to a chat with optional reply and quote functionality.

**Parameters:**
- `chat_id` (required): ID of the chat to send message to
- `text` (required): Message text to send
- `reply_to_message_id` (optional): Post number to reply to
- `quote_text` (optional): Text to quote from the replied message (only used with `reply_to_message_id`)

**Examples:**
```python
# Simple message
send_message(chat_id="123", text="Hello!")

# Reply to a message
send_message(
    chat_id="123",
    text="I agree!",
    reply_to_message_id="456"
)

# Reply with quoted text
send_message(
    chat_id="123",
    text="That's a great idea!",
    reply_to_message_id="456",
    quote_text="We should implement this feature next week"
)
```

## Installation

### Quick Install with uvx (Recommended)

Install directly from GitHub:

```bash
uvx --from git+https://github.com/ivolnistov/pararam-nexus-mcp pararam-nexus-mcp
```

Or clone to a specific directory (e.g., `~/.mcp/`):

```bash
git clone https://github.com/ivolnistov/pararam-nexus-mcp.git ~/.mcp/pararam-nexus-mcp
cd ~/.mcp/pararam-nexus-mcp
uv sync
```

### Development Installation

For local development:

```bash
git clone https://github.com/ivolnistov/pararam-nexus-mcp.git
cd pararam-nexus-mcp
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

### If installed with uvx:

```bash
uvx --from git+https://github.com/ivolnistov/pararam-nexus-mcp pararam-nexus-mcp
```

### If cloned locally:

```bash
cd ~/.mcp/pararam-nexus-mcp
uv run pararam-nexus-mcp
```

### For development:

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