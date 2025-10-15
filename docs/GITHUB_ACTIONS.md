# GitHub Actions Setup

This document describes how to configure GitHub Actions for automatic deployment to PyPI and Docker Hub.

## Overview

The project uses two GitHub Actions workflows:

1. **CI Workflow** (`.github/workflows/ci.yml`) - Runs on every push and PR
   - Linting and type checking
   - Tests
   - Build verification

2. **Release Workflow** (`.github/workflows/release.yml`) - Runs on version tags
   - Publishes to PyPI
   - Builds and pushes Docker images to Docker Hub and GitHub Container Registry
   - Creates GitHub Release

## Prerequisites

### 1. PyPI Configuration

The project uses **OIDC Trusted Publisher** for PyPI deployment (no tokens needed!).

#### Steps to configure PyPI:

1. Go to [PyPI](https://pypi.org/) and log in
2. Navigate to your account settings → Publishing
3. Add a new pending publisher with these settings:
   - **PyPI Project Name**: `pararam-nexus-mcp`
   - **Owner**: `ivolnistov`
   - **Repository name**: `pararam-nexus-mcp`
   - **Workflow name**: `release.yml`
   - **Environment name**: `pypi`

4. In GitHub repository settings:
   - Go to Settings → Environments
   - Create a new environment named `pypi`
   - No secrets needed (OIDC handles authentication)

### 2. Docker Hub Configuration

#### Create Docker Hub Access Token:

1. Go to [Docker Hub](https://hub.docker.com/)
2. Navigate to Account Settings → Security → Access Tokens
3. Create a new access token with Read, Write, Delete permissions
4. Save the token securely (you won't see it again)

#### Add GitHub Secrets:

1. Go to your GitHub repository
2. Navigate to Settings → Secrets and variables → Actions
3. Add the following secrets:
   - **DOCKERHUB_USERNAME**: Your Docker Hub username (e.g., `ivolnistov`)
   - **DOCKERHUB_TOKEN**: The access token you created above

### 3. GitHub Container Registry

No configuration needed! GitHub Container Registry uses the built-in `GITHUB_TOKEN` automatically.

## Creating a Release

To trigger a release:

```bash
# Create and push a version tag
git tag v0.1.0
git push origin v0.1.0
```

This will automatically:
1. Run tests and linting
2. Build the Python package
3. Publish to PyPI (via OIDC)
4. Build and push Docker images to:
   - Docker Hub: `ivolnistov/pararam-nexus-mcp:0.1.0` and `ivolnistov/pararam-nexus-mcp:latest`
   - GitHub: `ghcr.io/ivolnistov/pararam-nexus-mcp:0.1.0` and `ghcr.io/ivolnistov/pararam-nexus-mcp:latest`
5. Create a GitHub Release with downloadable packages

## Versioning

The project uses semantic versioning. Version tags should follow the format:
- `v1.0.0` - Major release
- `v1.1.0` - Minor release
- `v1.1.1` - Patch release

## CI/CD Pipeline

### On Push to Main/Develop:
- Lint and type check
- Run tests
- Build package

### On PR to Main:
- Same as push to main
- Prevents merging if checks fail

### On Tag Push (v*):
- All CI checks
- Deploy to PyPI
- Deploy to Docker Hub
- Deploy to GitHub Container Registry
- Create GitHub Release

## Troubleshooting

### PyPI Deployment Fails

1. Verify the pending publisher is correctly configured on PyPI
2. Check that the environment name is exactly `pypi`
3. Ensure the workflow name matches exactly (`release.yml`)

### Docker Deployment Fails

1. Verify `DOCKERHUB_USERNAME` and `DOCKERHUB_TOKEN` secrets are set
2. Check that the Docker Hub access token has write permissions
3. Verify the repository name matches your Docker Hub repository

### Build Fails

1. Check that all dependencies are properly defined in `pyproject.toml`
2. Ensure tests pass locally: `uv run pytest`
3. Verify linting passes: `uv run ruff check src/`

## Manual Testing

To test the workflows locally:

```bash
# Test CI workflow
act -j lint
act -j test
act -j build

# Test Docker build
docker build -t pararam-nexus-mcp:test .
docker run --rm pararam-nexus-mcp:test --help
```

Note: Install [act](https://github.com/nektos/act) to run GitHub Actions locally.
