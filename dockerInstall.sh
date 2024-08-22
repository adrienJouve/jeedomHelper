#!/bin/bash
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/raspbian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/raspbian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# Add docker user to do not run docker command has root
sudo groupadd docker
## Not sure $User will work because launched from this script
sudo usermod -aG docker $USER
newgrp docker

# Update DNS config if applicable

## Define the nameserver entries to check for
NAMESERVER1="nameserver 8.8.8.8"
NAMESERVER2="nameserver 8.8.4.4"

## File to check
RESOLV_FILE="/etc/resolv.conf"

## Function to check if a string exists in a file
string_in_file() {
  local string="$1"
  local file="$2"
  grep -qF -- "$string" "$file"
}

## Check if nameserver 8.8.8.8 exists in /etc/resolv.conf
if ! string_in_file "$NAMESERVER1" "$RESOLV_FILE"; then
  echo "$NAMESERVER1" | sudo tee -a "$RESOLV_FILE"
fi

## Check if nameserver 8.8.4.4 exists in /etc/resolv.conf
if ! string_in_file "$NAMESERVER2" "$RESOLV_FILE"; then
  echo "$NAMESERVER2" | sudo tee -a "$RESOLV_FILE"
fi

echo "DNS configuration updated successfully."

sudo nano /etc/resolv.conf
sudo systemctl restart docker

# Launch hello-world to check if ti's working -> Should print line from docker and exit
sudo docker run hello-world

