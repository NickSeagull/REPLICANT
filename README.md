# REPLICANT

## Installing 

```bash
curl -fsSL https://github.com/NickSeagull/REPLICANT/raw/refs/heads/main/initialize.sh | bash
```



## Updating

```bash
git pull && home-manager switch --flake .#nick
```

## Developing (assuming you're on Ubuntu)

Install `multipass` with

```bash
sudo snap install multipass
```

Launch a shell with:

```bash
multipass launch lts --name primary --memory 4G --disk 50G --cpus 4
multipass shell
```

This will launch an Ubuntu VM and login into it.

Ensure you're running as root:

```bash
sudo su
cd    # to avoid being in the "ubuntu" user home folder
```

Run the initialization script.
Either the one in main, or branch, or whatever.

```bash
curl -fsSL https://github.com/NickSeagull/REPLICANT/raw/refs/heads/main/initialize.sh | bash
```

