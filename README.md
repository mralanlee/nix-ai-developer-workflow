# Nix AI Developer Workflow

Quick setup for Node.js/Python development with Claude Code integration.

## What is a Nix Flake?

A Nix flake is a self-contained package that defines reproducible development environments and builds. Think of it as a lockfile for your entire dev stack - it pins exact versions of languages, tools, and dependencies so everyone gets identical environments across machines.

## Install Nix

**Option 1 - Deterministic Installer (Recommended):**

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

**Option 2 - Official Installer:**

```bash
curl -L https://nixos.org/nix/install | sh -s -- --daemon

# after the install run (this is only for official install):
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf

```

## Usage

**The first time you run this, take a break because it will take a long time. Every time after should take no more than a few seconds.**

If you want to use your own shell (zsh, fish, etc.):

```bash
SHELL=$0 nix develop -c $SHELL
```

If you want to default to bash:

```bash
# Enter development environment
nix develop

# Your shell now has:
# - Node.js 20 + npm
# - Python 3.13.4
# - TypeScript language server
# - Claude Code with Playwright MCP
```

Verify:

```bash
$ which python
# -> /nix/store/gxr6kdq7r6bi507nqhix9d45k0h9azhk-python3-3.13.4/bin/python 


$ python main.py
# -> Hello, World!

```

That's it! The environment automatically configures Claude Code and cleans up on exit.

## Other

* Checkout [nix packages](https://search.nixos.org/packages)
* Learn more about [nix and NixOS](https://nixos.org/)
* Read more about Nix [Flakes](https://nix.dev/concepts/flakes.html)
* Want to extend Nix and leverage a more robust dev env? Check these tools out (not sponsored):
  * [devenv](https://devenv.sh/)
  * [devbox](https://www.jetify.com/devbox)
  * [flox](https://flox.dev/)
