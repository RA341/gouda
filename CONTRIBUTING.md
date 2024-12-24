# Contributing Guide

This project is licensed under the GNU General Public License v3.0 (GPL-3.0). By contributing to this project, you agree that your contributions will be licensed under the GPL-3.0 license.

## Getting Started

1. Fork the repository
2. Clone your fork: `git clone https://github.com/YOUR-USERNAME/gouda.git`

### The repo contains 2 components,

1. The go api server - located at [/src](/src)
2. The flutter/dart frontend - located at [/brie](/brie)

All contributions use

## Development Workflow

### Branch Management

- Always create branches from `main`
- Keep your local `main` branch synced with upstream:
  ```bash
  git checkout main
  git pull upstream main
  ```
- Create feature branches with descriptive names:
  ```bash
  git checkout -b feature/your-feature-name
  ```

### Making Changes

1. Make commits with clear messages:
   ```bash
   git commit -m "feat: add new functionality"
   ```
2. Push your changes:
   ```bash
   git push origin feature/your-feature-name
   ```

## Pull Requests

### Opening a PR

1. Create PR targeting the `main` branch
2. Use the PR template if provided
3. Include:
   - Clear title describing the change
   - Detailed description of changes
   - Link to related issues using GitHub keywords (Fixes #123, Closes #456)
   - Add appropriate labels/tags

### PR Guidelines

- Keep changes focused and atomic
- Update documentation if needed
- Add tests for new features
- Ensure CI checks pass
- Respond to review feedback promptly

## Labels

Common labels used in the project:
- `bug`: Bug fixes
- `feature`: New features
- `documentation`: Documentation updates
- `breaking`: Breaking changes
- `dependencies`: Dependency updates
- `UI`: If working on the frontend 

## Questions?

Open a discussion for any questions about contributing [here](https://github.com/RA341/gouda/discussions).
