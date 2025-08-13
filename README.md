# Mothership

🚧 Work in progress, **follow for updates on [Twitter](https://twitter.com/kossnocorp) or [Bluesky](https://bsky.app/profile/koss.nocorp.me)**

## Dev Container

The quickest way to start with a dev container, is to use one of the Mothership templates.

For example, to set up a dev container in a Node.js project, run:

```bash
devcontainer templates apply -t ghcr.io/kossnocorp/templates/node -a '{"name":"MY_PROJECT_NAME"}'
```

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

Right after publishing, the template package will be private, so to make it available to everyone, make sure to remind [@kossnocorp](https://github.com/kossnocorp) to visit [the packages at GitHub](https://github.com/kossnocorp?tab=packages) and set the new package visibility it to public.

#### Docs

See relevant documentation:

- [Dev Container Templates reference](https://containers.dev/implementors/templates/)
- [Dev Container Templates distribution and discovery](https://containers.dev/implementors/templates-distribution/)

## Maintaining

### Setting Up

To speed up image building, we use Docker Build Cloud, to begin, create a local instance of the cloud builder on your machine:

```bash
docker buildx create --driver cloud kossnocorp/mothership
```

To build an image, add `--builder cloud-kossnocorp-mothership` flag to the `docker buildx build` command, e.g.,:

```bash
docker buildx build --builder cloud-kossnocorp-mothership --platform linux/amd64 --file images/base/Dockerfile --tag kossnocorp/dev-base .
```
