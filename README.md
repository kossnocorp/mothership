# Mothership

_Secure, consistent, yet comfortable dev setup for humans and AI agents working in dev containers or local machines running Linux, macOS, or WSL._

- **Never worked with dev containers?**
- Need a secure sandbox to get the most out of AI agents?
- Looking for a consistent and productive dev environment both in dev containers and local machines?
- Want a reproducible setup for your team?

Mothership is a quick way to get that!

🚧 Work in progress, **follow for updates on [Twitter](https://twitter.com/kossnocorp) or [Bluesky](https://bsky.app/profile/koss.nocorp.me)**

## What?

Mothership is a toolkit for setting up and maintaining reproducible and secure development environments for humans and AI agents alike. It values security, developer experience, productivity, and performance.

It is omakase-like and comes with a curated library of modern dev tools yet is based on vanilla tech, saving you from tedious maintenance when something goes off the rails.

You get familiar environment whether you need to get things done on Linux, macOS, or WSL.

**What's inside:**

- Ubuntu as the OS for dev containers.
- Ansible and plain bash scripts for cross-platform configration.
- mise-en-place as the dev tools manager.
- Dev containers for consistent sandbox environment.
- Pre-installed modern dev toolchain with rg, fd, bat and many more.

## Why?

**Secure dev sandbox for agents without the pain of learning new tools**. With the rise of AI agents and increasing dependency chain attacks the world is in dire need of a secure dev environment. Dev containers are the best way to provide it, but moving the workflow from a local machine into a container requires numerous habit changes and a specific set of DevOps skills. Mothership lowers the entry bar and provides a solid boost to get started without conquering a learning curve.

**Consistent dev environment for teams.** Having a reproducible dev environment is crucial when working in a team, so everyone can focus on contributing to a project instead of fighting missing or mismatched dependencies, unset environment variables or secrets.

**Be productive wherever you go.** With just a single dev container, you already have two machines with distinct environments, i.e., macOS comes with Bash v3 whereas Ubuntu comes with the latest v5 creating a gap in behavior and functionality. These differences become unbearable if you (like the author) hop between a PC running WSL2 Ubuntu, MacBook and a myriad of dev containers.

**Skip [the yak shaving](https://en.wiktionary.org/wiki/yak_shaving).** There are many exciting distros and package managers on the market like Nix & NixOS that provide _the proper_ reproducible and immutable system setup, or Arch that gives you maximum freedom to customize the environment to your liking. These and many more other options are fantastic if you want a hobby, but not so much when you just need it to work, especially when something goes off the rails. Using boring vanilla tech like Ubuntu and Ansible gives you and AI agents an edge when it comes to compatibility and troubleshooting. You can be sure that whatever issue you are having is already well-documented and solved by someone.

**Modern dev tools without early adopter tax.** Having a boring foundation leaves a lot of free space for modern dev tools that make you more productive but only when you're ready for it. If you want to try [ripgrep (rg)](https://github.com/BurntSushi/ripgrep) instead of the familiar `ack` and `grep`, go for it! Need to get things done right now, use whatever you've been using so far. No pressure to learn anything new, but when you have a moment, you may browse [the dev toolchain list](#dev-toolchain) and make your life a bit better. AI agents get a [`dev-toolchain.md`](./docs/dev-toolchain.md) so they can benefit from it too and perform the given tasks faster.

## Get Started!

**Ready to try?** [Start a dev container](#start-a-dev-container) by applying a template to set up a project environment in a sandbox. It's straightforward even if you haven't worked with dev containers or any containers at that.

**Already familiar with Mothership** and want to get the same setup on your local machine? [Clone the repo and run `install.sh`](#running-installsh) to set up the dev environment. It's more invasive, but still gentle and [provides simple uninstall steps](#uninstalling-from-local-machine).

### Start a Dev Container

The quickest way to start with a dev container, is to use one of the Mothership templates.

#### Start with Dev Container CLI

You can use the [`@devcontainers/cli`](https://github.com/devcontainers/cli) to apply a template to your project.

For example, to set up a dev container in a Node.js project, run:

```bash
npx @devcontainers/cli templates apply -t ghcr.io/kossnocorp/templates/node -a '{"name":"MY_PROJECT_NAME"}'
```

Or if you have installed [`@devcontainers/cli`](https://github.com/devcontainers/cli):

```bash
devcontainers-cli templates apply -t ghcr.io/kossnocorp/templates/node -a '{"name":"MY_PROJECT_NAME"}'
```

### Apply to Local Machine

#### Running `install.sh`

TODO: Write instructions for using `install.sh` to set up a local machine.

#### Uninstalling from Local Machine

TODO: Write instructions for rolling back installation commands.

## Dev Toolchain

TODO: List the dev tools that come with Mothership.

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
