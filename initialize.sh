#!/bin/bash

set -e  # Exit immediately on error
set -u  # Treat unset variables as errors

### Ensure running as root ###
if [[ "$(id -u)" -ne 0 ]]; then
    echo "This script must be run as root!" >&2
    exit 1
fi

### Install Dependencies ###
echo "INSTALLING DEPENDENCIES"
apt update && apt install -y curl jq git sudo

### Install Bitwarden CLI ###
echo "INSTALLING BITWARDEN"

# FIXME: THIS IS NOT WORKING
curl -fsSL https://github.com/bitwarden/cli/releases/latest/download/bw-linux-$(uname -m) -o /usr/local/bin/bw
chmod +x /usr/local/bin/bw

### Prompt for Bitwarden Login ###
echo "Logging into Bitwarden CLI..."
export BW_SESSION=$(bw login --raw)
bw unlock --raw > /root/.bw_session

### Create 'nick' user with appropriate groups ###
useradd -m -s /bin/bash -G sudo,adm,dialout,cdrom,floppy,audio,dip,video,plugdev,netdev,lpadmin,lxd -U nick
echo "nick ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/nick

### Retrieve SSH Keys from Bitwarden ###
echo "Fetching SSH key from Bitwarden..."
mkdir -p /home/nick/.ssh
bw get item "GitHub SSH Private Key" | jq -r '.notes' > /home/nick/.ssh/id_ed25519
chmod 600 /home/nick/.ssh/id_ed25519
chown -R nick:nick /home/nick/.ssh

### Install Nix via Determinate Systems Installer ###
echo "Installing Nix..."
curl -L https://install.determinate.systems/nix | bash

### Clone REPLICANT Repository ###
sudo -u nick git clone git@github.com:NickSeagull/REPLICANT.git /home/nick/.replicant
chown -R nick:nick /home/nick/.replicant

echo "Initialization complete. Login SSH into nick and continue run the setup."

