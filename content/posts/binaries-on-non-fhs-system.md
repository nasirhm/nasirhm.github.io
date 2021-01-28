---
title: "Running Pre-Built Binaries on Non-FHS *NIX Systems"
date: 2021-01-20T00:28:56+05:00
tags: ["nix", "binaries", "linux", "nodejs"]
categories: ["nix", "linux"]
draft: true
---

Executing pre-built binaries on a new system can be a troublesome task to perform. Several exceptions can occur causing the execution to fail.

We'll be looking at one of such that can occur on Linux systems quite often, which is: `The file '<executable_file_name>' does not exist or could not be executed.`

This exception occurs when it is unable to find one of the ELF libraries required to execute the binary.

In this blog post, we'll be digging into it a little deeper to understand & find a solution:

---

# How do binaries work in Linux?

Binaries are a set of instructions that are understood by the machine to perform a specific task.

Our day-to-day interaction with our terminal CLI (Command Line Interface) includes usage of programs like: `bash`, `grep`, `ls`, `cd`, etc., which are available typically in our: `/bin` (binary) directory. Example: We can use `which` (a binary itself) to find the location of the `bash` program:

```
$ which bash
/bin/bash
```

This provides us information on where the program is located on the disk.

Similar to standards being followed in our day-to-day life, binaries also follow a certain standard known as **ELF** or the Executable and Linkable Format.

## ELF Standard for Binaries

ELF (Executable and Linkable Format) standard is used to let the Operating System know some information about how to execute the program.
It's something that we don't interact with much on our daily basis, but can be quite helpful with debugging. ELF standard makes us extend our program to work efficiently at runtime.

Example: To run a C program, we don't need the entire implementation of the C language itself in the codebase. Instead, we link a library (glibc) with our binary to let it know that it needs the C library to be executed.

Sounds pretty cool, right?

Let's get back to the problem now.

As described earlier, the error: `The file '<executable_file_name>' does not exist or could not be found` occurs whenever there's a dependency on a library that the binary is not able to find.

### Let's get to the debugging part

One thing that I love about UNIX-based systems is that we have the tools to debug almost everything. To get the list of dependencies or libraries required by a binary, we can use the `ldd` command.
It prints the shared libraries required by the program on the command line. As an example. let's see what a pre-compiled binary of NodeJS requires:

```
$ ldd ./node

		linux-vdso.so.1 (0x00007fff00bf9000)
		libdl.so.2 => /lib/libdl.so.2 (0x00007fc857f59000)
		libstdc++.so.6 => not found
		libm.so.6 => /lib/libm.so.6 (0x00007fc857e18000)
		libgcc_s.so.1 => /lib/libgcc_s.so.1 (0x00007fc857dfe000)
		libpthread.so.0 => /lib/libpthread.so.0 (0x00007fc857ddd000)
		libc.so.6 => /lib/libc.so.6 (0x00007fc857c1e000)
		/lib64/ld-linux-x86-64.so.2 => /lib64/ld-linux-x86-64.so.2 (0x00007fc857f60000)
```

Upon executing the program, it returns the following error:

```
$ ./node

Failed to execute process './node'. Reason:
The file './node' does not exist or could not be executed.
```

Do you know what the problem is? You guessed it right. It's the `libstdc++.so.6` library that is causing our binary to not execute.

Now that we know what's causing the issue, let's fix it.

#### For FHS (FileSystem Hirearchy Standard) Distros (Debian, Ubuntu, etc.)

As in FHS systems, we make some assumptions regarding our system which includes that all the libraries will be in `/lib` or relevant directories. It's, then, easier to fix the issue.

In FHS standardized / compliant Linux distributions it can be easily solved by installing the relevant library's package.

Example: For `libstdc++.6`:

On Debian/Ubuntu based distros: `apt-get install libstdc++6`

On CentOS/Fedora based distros: `yum install libstdcxx`

Once installed, it'll be available in the `/lib` directory resulting in the ELF loader to find the library in `/lib`. You would then be able to execute `node` as following:

```
$ ./node
Welcome to Node.js v14.15.4.
Type ".help" for more information
>
```

Woohoo, it worked. Now let's see how to fix it in non-FHS distributions, where we don't have a global `/lib` directory. :D

#### For Non-FHS Distros (NixOS, etc):

To maintain the non-global state of a system in non-FHS distributions, we would not be modifying the state of our system. We will be patching the ELF binary to work correctly. Example in NixOS:

NixOS provides a tool: [patchelf](https://github.com/NixOS/patchelf) which is a small utility that provides us the ability to patch pre-compiled binaries without having to play with machine code (0s and 1s).

Let's get started, we first need to find where out `libstdc++.so.6` file lives in our `/nix/store`, which can be found via the following shell function:

```
function find_stdcplusplus_in_nix_store(){
		local _fileName="libstdc++.so.6";
		ls /nix/store | grep "gcc" | grep "lib" \
		| awk -v file="${_fileName}" '{printf("find /nix/store/%s -name %s\n");}' | sh \
		| awk -F'-' '{printf("%s %s\n", $3, $0);}' | sort | tail -n 1 | awk '{print $2;}'
}
```

It'll return the full path of the library/the file name `libstdc++.so.6`. It'll be something like: `/nix/store/gcc-<hash>/lib/libstdc++.so.6`.

We need to get to know the directory where our library lives. To find it, we can execute the following function:

```
...
function find_stdcplusplus_parent_dir_in_nix_store(){
		local _file="$(find_stdcplusplus_in_nix_store)";
		dirname "${_file}";
}

nix_store_location=$(find_stdcplusplus_dir_in_nix_store)
```

It returns the directory where the library exists i.e: `/nix/store/gcc-<hash>/lib` and stores it in a global variable as `nix_store_location`.

Now it's time for the final operation in which we will be creating shell environment/s with `patchelf` using `nix-shell` to patch the ELF binary:

```
...
function patch_node_application(){
		nix-shell -p patchelf --run 'patchelf --set-rpath $nix_store_location bin/node'
		nix-shell -p patchelf --run 'patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" bin/node'
}
```

The first line within the function adds an `rpath` (runtime search path) to let our loader know that `libstdc++` can be found in a specific directory in the Nix store.

The second line, with the ELF binary, the dynamic loader (ELF interpreter) is set to a static path which is generally not available under NixOS at: `lib64/ld-linux-x86-64.so.2`. We're changing it to the dynamic loader available at `$NIX_CC/nix-support/dynamic-linker`.

After executing the function `patch_node_application`, it'll patch the `node` binary and you'll be able to execute it on NixOS.

To add the above script incorporated in your current build systems, here's a small addition to the shell script to only execute the function if it's running on NixOS:
```
...
if [ "cat /etc/os-release | grep 'nixos'" ]; then
	patch_node_application
fi
```
Now the shell script will only be executed if the system is running NixOS, and the `node` binary can now be executed too.

Thank you for reading! I'll be writing more about ELF and Nix in the future.

Looking forward to your feedback on the post.
