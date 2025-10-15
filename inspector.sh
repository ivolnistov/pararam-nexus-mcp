#!/bin/bash
# Script to run Pararam Nexus MCP server with MCP Inspector

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "🚀 Starting Pararam Nexus MCP server with Inspector..."

# Load environment variables from .env file if it exists
if [ -f "$SCRIPT_DIR/.env" ]; then
    echo "📋 Loading environment from .env file..."
    export $(cat "$SCRIPT_DIR/.env" | grep -v '^#' | xargs)
fi

# Check if required environment variables are set
if [ -z "$PARARAM_LOGIN" ]; then
    echo "❌ Error: PARARAM_LOGIN is not set"
    echo "Please create a .env file with:"
    echo "  PARARAM_LOGIN=your_email@example.com"
    echo "  PARARAM_PASSWORD=your_password"
    echo "  PARARAM_2FA_KEY=your_2fa_key  # Optional, if 2FA is enabled"
    exit 1
fi

if [ -z "$PARARAM_PASSWORD" ]; then
    echo "❌ Error: PARARAM_PASSWORD is not set"
    echo "Please create a .env file with:"
    echo "  PARARAM_LOGIN=your_email@example.com"
    echo "  PARARAM_PASSWORD=your_password"
    echo "  PARARAM_2FA_KEY=your_2fa_key  # Optional, if 2FA is enabled"
    exit 1
fi

echo "✅ Using pararam.io account: $PARARAM_LOGIN"
if [ -n "$PARARAM_2FA_KEY" ]; then
    echo "✅ 2FA enabled"
fi
echo ""

# Change to script directory and run the MCP Inspector with the FastMCP server using uv
cd "$SCRIPT_DIR"
npx -y @modelcontextprotocol/inspector uv run pararam-nexus-mcp
