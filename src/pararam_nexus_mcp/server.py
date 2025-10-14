#!/usr/bin/env python3
"""
FastMCP-based Pararam Nexus MCP server implementation.
"""

import logging
import sys

from fastmcp import FastMCP

logger = logging.getLogger(__name__)

# Initialize FastMCP server
mcp = FastMCP(
    name='pararam-nexus-mcp',
    instructions='Pararam Nexus MCP Server - Add your server description here',
)


@mcp.tool()
def hello(name: str) -> str:
    """
    Say hello to someone.

    Args:
        name: The name of the person to greet

    Returns:
        A greeting message
    """
    return f'Hello, {name}!'


def main() -> None:
    """Main entry point for the Pararam Nexus MCP server."""
    try:
        # Set up logging
        logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(name)s - %(levelname)s - %(message)s')
        logger.info('Starting Pararam Nexus MCP server')

        # Run the server - this blocks until interrupted
        mcp.run()

        sys.exit(0)
    except KeyboardInterrupt:
        # Clean exit on Ctrl-C without showing traceback
        print('\nShutting down...', file=sys.stderr)
        sys.exit(0)
    except Exception as e:  # COMMENT: Top-level handler to prevent silent crashes and ensure proper error logging
        # Show only the error message
        print(f'\n❌ Error starting server: {e!s}', file=sys.stderr)
        raise


if __name__ == '__main__':
    main()
