# spec-kit Feature

This feature installs the GitHub Spec Kit `specify` CLI tool into the dev container.

## Options

- `version`: string
  - default: `main`
  - description: Install a specific `specify` CLI release tag from GitHub. Use `main` to install the latest branch, or a tag like `v0.8.5`.

## Example

```jsonc
{
  "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
  "features": {
    "ghcr.io/privatecorner/devcontainer-features/spec-kit:1": {
      "version": "v0.8.5"
    }
  }
}
```
