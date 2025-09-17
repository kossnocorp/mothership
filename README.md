# Mothership

Quick and easy setup for comfortable and secure development.

🚧 Work in progress, **follow for updates on [Twitter](https://twitter.com/kossnocorp) or [Bluesky](https://bsky.app/profile/koss.nocorp.me)**

Mothership is a toolkit for setting up and maintaining reproducible development environments. It values developer experience, productivity, security and performance.

It is an omakase that comes with a curated library of tools yet is based on vanilla tech, saving you from tedious maintenance.

Behind the scenes it is just boring Ubuntu, Docker, Ansible, and a bunch of shell scripts providing a comfortable developer experience.

It works both on your local machine and in a dev container, so you can have a consistent experience wherever you go. It works on Linux, macOS, and WSL.

## Piqued your interest?

There's two main ways to apply Mothership:

1. Use a [dev container](#dev-container) template to set up a project environment in a container.

2. Run [install.sh](#installsh) to set up your local machine.

## Dev Container

The quickest way to start with a dev container, is to use one of the Mothership templates.

### Dev Container CLI

You can use the [`@devcontainers/cli`](https://github.com/devcontainers/cli) to apply a template to your project.

For example, to set up a dev container in a Node.js project, run:

```bash
npx @devcontainers/cli templates apply -t ghcr.io/kossnocorp/templates/node -a '{"name":"MY_PROJECT_NAME"}'
```

Or if you have installed [`@devcontainers/cli`](https://github.com/devcontainers/cli):

```bash
devcontainers-cli templates apply -t ghcr.io/kossnocorp/templates/node -a '{"name":"MY_PROJECT_NAME"}'
```

## `install.sh`

TODO: Write instructions for using `install.sh` to set up a local machine.

## Contributing

### Images

#### Testing Locally

To connect to an image, use the following command (replace `dev-node:next` with the flavor and version you want to test, e.g., `dev-rust:latest`):

```bash
docker run -it --rm kossnocorp/dev-node:next bash
```

### Dev Container Templates

#### Creating New Template

...

Right after publishing, the template package will be private, so to make it available to everyone, make sure to remind [@kossnocorp](https://github.com/kossnocorp) to visit [the packages at GitHub](https://github.com/kossnocorp?tab=packages) and set the new package visibility to public.

#### Docs

See relevant documentation:

- [Dev Container Templates reference](https://containers.dev/implementors/templates/)
- [Dev Container Templates distribution and discovery](https://containers.dev/implementors/templates-distribution/)

## Maintaining

### Setting Up

To speed up image building, we use Docker Build Cloud. To begin, create a local instance of the cloud builder on your machine:

```bash
docker buildx create --driver cloud kossnocorp/mothership
```

To build an image, add the `--builder cloud-kossnocorp-mothership` flag to the `docker buildx build` command, e.g.,:

```bash
docker buildx build --builder cloud-kossnocorp-mothership --platform linux/amd64 --file images/base/Dockerfile --tag kossnocorp/dev-base .
```
