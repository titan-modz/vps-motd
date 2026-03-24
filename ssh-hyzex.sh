#!/bin/bash
# ===========================================
# Secure SSH Setup + Custom MOTD - HyzexNodes
# ===========================================

clear
echo -e "\033[1;36m🔐 HyzexNodes - Secure SSH Configuration\033[0m"
echo -e "\033[1;37m--------------------------------------\033[0m"

# Update SSH config
sudo bash -c 'cat <<EOF > /etc/ssh/sshd_config
PasswordAuthentication yes
PermitRootLogin yes
PubkeyAuthentication no
ChallengeResponseAuthentication no
UsePAM yes
X11Forwarding no
AllowTcpForwarding yes
Subsystem sftp /usr/lib/openssh/sftp-server
EOF'

echo -e "\033[1;34m▶ Restarting SSH service...\033[0m"
sudo systemctl restart ssh || sudo service ssh restart

# Custom MOTD Install - LINKED TO YOUR GITHUB
echo -e "\033[1;34m▶ Installing HyzexNodes MOTD...\033[0m"
# REPLACE 'YOUR_GITHUB_USERNAME' BELOW
bash <(curl -fsSL https://raw.githubusercontent.com/titan-modz/vps-motd/main/hyzex.sh)

clear
echo -e "\033[1;36m"
cat << "EOF"
  _    _                       _   _           _           
 | |  | |                     | \ | |         | |          
 | |__| |_   _ ___  __  __    |  \| |  __   __| | ___  ___ 
 |  __  | | | |_  / _ \ \ \/ /| . ` |/ _ \ / _` |/ _ \/ __|
 | |  | | |_| |/ /  __/  >  < | |\  | (_) | (_| |  __/\__ \
 |_|  |_|\__, /___\___| /_/\_\|_| \_|\___/ \__,_|\___||___/
          __/ |                                               
         |___/                                                
EOF
echo -e "\033[0m"

echo -e "\033[1;32m🎉 HyzexNodes VPS setup completed.\033[0m"
echo -e "\n\033[1;33m🔑 Please set your ROOT password below 👇\033[0m"
sudo passwd root
