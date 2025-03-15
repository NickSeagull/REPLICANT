#!/bin/bash

set -e  # Exit immediately on error
set -u  # Treat unset variables as errors

### Ensure running as root ###
if [[ "$(id -u)" -ne 0 ]]; then
    echo "This script must be run as root!" >&2
    exit 1
fi

### Check if user 'nick' already exists ###
if ! id "nick" &>/dev/null; then
    echo "Creating user 'nick'..."
    useradd -m -s /bin/bash -G sudo,adm,dialout,cdrom,floppy,audio,dip,video,plugdev,netdev,lxd -U nick
    echo "nick ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/nick
    chmod 0440 /etc/sudoers.d/nick
fi

### Ensure correct home directory ownership ###
chown -R nick:nick /home/nick

### Switch to 'nick' user and continue installation ###
su - nick <<'EOF'
set -e  # Ensure errors cause exit in the new shell
echo "Now running as $(whoami)..."

sh <(curl -L https://nixos.org/nix/install) --daemon --yes
mkdir -p /home/nick/.config/nix
echo 'experimental-features = nix-command flakes' >> /home/nick/.config/nix/nix.conf
EOF

# Restart shell
su - nick <<'EOF'
# Install home manager
nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install

echo 'source $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh' > .bashrc
source ~/.bashrc
EOF

echo "Setup completed!"
