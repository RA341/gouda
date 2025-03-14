# Getting Started

Welcome to Gouda! We're excited that you're interested in contributing to our project. This guide will help you set up your development environment and understand the project's licensing.

## License

Gouda is licensed under the GNU General Public License v3.0 (GPL-3.0). By submitting contributions to this project, 
you acknowledge and agree that your work will be distributed under the terms of the GPL-3.0 license. For more details, please see the [LICENSE](https://github.com/RA341/gouda/blob/release/LICENSE) file in our repository.

## Development Prerequisites

Before you begin contributing, please ensure you have the following tools installed:

### Required Technologies

* Go v1.24 and above
    - Powers the main application
    - [Installation Guide](https://go.dev/learn/)

* Flutter v3.27.1 and above
    - Used for the webui and desktop native implementation
    - [Installation Guide](https://docs.flutter.dev/get-started/install)

* Node.js and NPM
    - Used for extension development and documentation
    - [Installation Guide](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm)

* Just 1.38.0 and above
  - Just is a command runner to save and run project-specific commands.
  - Think of it as an alternative to `npm run` commands or `Makefiles`
  - [Installation Guide](https://just.systems/man/en/)

Please install and configure all these dependencies before proceeding with Gouda development. For version-specific installation instructions, refer to each tool's official documentation.

## Cloning

1. [Fork](https://github.com/RA341/gouda/fork) the repository
2. Clone your fork onto your machine.

### Components

1. The main Go app - located at `/src`
2. The flutter/dart frontend - located at `/brie`
3. The browser extension - located at `/parmesan`

### Building

Gouda can be built in 2 modes depending on your target,

1. Server mode - This compiles the project as a server binary, intended to run in a server/seedbox environments
   *  ```bash
        go build
      ```
2. Desktop mode - This compiles the project as a desktop binary, enabling systray and adds a flutter native build 
   *  ```bash
           go build -tags systray -ldflags "-X github.com/RA341/gouda/service.BinaryType=desktop"
      ```

    
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
