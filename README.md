# Basic neovim 0.11.3 configuration for c/c++ development in Debian 12

Note: This repo was specially made for a presentation in Debian Day 2025 at Santos - SP, Brazil.

## Setup and installation

The first thing we'll need to do is to update our apt database so we run:

```sh
sudo apt update
sudo apt upgrade
```

And install basic tools:

```sh
sudo apt install build-essential cmake wget curl git vim
```

Add llvm apt public key:

```sh
wget -qO- https://apt.llvm.org/llvm-snapshot.gpg.key | sudo tee /etc/apt/trusted.gpg.d/apt.llvm.org.asc
```

Then, into /etc/apt/sources.list add these lines:

```sh
deb http://apt.llvm.org/bookworm/ llvm-toolchain-bookworm main
deb-src http://apt.llvm.org/bookworm/ llvm-toolchain-bookworm main
# 19 
deb http://apt.llvm.org/bookworm/ llvm-toolchain-bookworm-19 main
deb-src http://apt.llvm.org/bookworm/ llvm-toolchain-bookworm-19 main
# 20 
deb http://apt.llvm.org/bookworm/ llvm-toolchain-bookworm-20 main
deb-src http://apt.llvm.org/bookworm/ llvm-toolchain-bookworm-20 main
# 21 
deb http://apt.llvm.org/bookworm/ llvm-toolchain-bookworm-21 main
deb-src http://apt.llvm.org/bookworm/ llvm-toolchain-bookworm-21 main
```

Update the database:

```sh
sudo apt update
```

Install the tools we'll need for our neovim setup:

```
sudo apt install ripgrep clang clangd clang-format
```

Now, we'll build neovim 0.11.3 from source:

```sh
git clone https://github.com/neovim/neovim --branch=v0.11.3 --depth=1
cd neovim
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
cd ..
rm -rf neovim
```

Cool, now we have installed all the software we need, let's start configuring neovim.
