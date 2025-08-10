# Basic Neovim 0.11.3 configuration for C/C++ development in Debian 12

Note: This repo was specially made for a presentation in Debian Day 2025 at Santos - SP, Brazil.

## Setup and installation

The first thing we'll need to do is to update our apt database so we run:

```sh
sudo apt update
sudo apt upgrade
```

_Little tip: if you're using gnome and want to disable the alert sound, you can run this as root:_

```sh
echo "" > /usr/share/sounds/gnome/default/alerts/click.ogg
```

_This will turn the default alert sound (Click) into an empty file, so it will not play when triggered._

And install basic tools:

```sh
sudo apt install build-essential cmake wget curl git vim bash-completion
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

```sh
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

And clone this config into your neovim config folder:

```sh
mkdir ~/.config
cd ~/.config
git clone https://github.com/AndreyArthur/debian-nvim nvim 
```

Now you're ready to use neovim.
