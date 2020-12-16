---
title: "Getting Started With Nix: Introduction"
date: 2020-12-16T01:58:48+05:00
tags: ["nix", "nix-packages"]
categories: ["Nix"]
---

Recently, I installed NixOS on one of my machines to explore the Nix ecosystem, and to learn how it makes the process of creating deterministic and reproducible builds efficient and simpler.

This blog post series provides an introduction to the Nix package manager and how it works.

## What is Nix?

Nix is a powerful, purely functional package manager designed to be a reliable and reproducible package-management system.

Nix is also the primary package manager for **NixOS** and can also be installed as an additional package manager on Linux and Mac OS X.

It also offers the following features:

- Atomic Upgrades and Rollbacks;
- Multiple versions of a package;
- Multi-user package management, the ability to install certain packages for certain users only;
- Effortless setup of build environments for a package, providing functional builds;
- and many more.

## How Nix Works

Packages in the Nix ecosystem are built from Nix expressions, which is a simple functional language that enables the packaging aspect for Nix (The package manager).

A Nix expression describes everything that goes into a package build, e.g: other packages (dependencies), sources, config files, environment variables, external patches, etc.

A Nix expression results in a derivation, which is a build of the expression, that takes some inputs and produces an output, outputs are almost always some `/nix/store/some-hash-pkg-name` path.

Below is an abstract diagram of how Nix expressions work:

![How Nix Expressions work](/images/posts-static/nix-pkg-101/nix-expression-101.png)

As you can see, we've got an application written in C language and we're creating a Nix expression for it, which includes some code patches, dependencies, configurations. The resultant derivation is then created in the Nix Store.
### The essence of Nix in comparison to traditional Linux systems:

Nix emerges from the idea that **FHS (Filesystem Hierarchy Standard) is fundamentally incompatible with reproducibility**. Let me explain now:

With traditional Linux systems and package managers, you'll find paths like `/usr/bin/python` or `/lib/libm.so` where packages are installed. But there are a lot of things that we don't know about the file that's there, for example:

- What's the version of the package the binary/library came from?
- What are the libraries it uses?
- What configure flags were enabled during the build?

These questions have a significant effect on the resulted build and can also change the behavior of the application.

Indeed, there are ways to get around this in FHS. We can link directly to `/lib/libm.so` or use `/usr/bin/python3.7` in our shebang, but then there will still be a lot of unknowns.

Nix plays a pretty essential role in fixing it, by isolating the build itself resulting in reproducible build artifacts.

On Nix systems, the file paths look like this: `/nix/store/<hash>-<name>-<version>`.

If there's something you're unable to grasp...No worries! We'll be exploring Nix further in the future with because this is only the first of the series.

Thank you for reading. In the next posts, we will be installing Nix and building some Nix expressions ourselves.

