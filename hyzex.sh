#!/bin/bash
# ================================
# HyzexNodes Premium MOTD Installer
# ================================

set -e

echo "🔧 Installing HyzexNodes Premium MOTD..."

# ================================
# Disable ALL default MOTD scripts
# ================================
if [ -d /etc/update-motd.d ]; then
  chmod -x /etc/update-motd.d/* 2>/dev/null || true
fi

# ================================
# Create Custom MOTD
# ================================
cat << 'EOF' > /etc/update-motd.d/00-hyzexnodes
#!/bin/bash

# ===== Colors =====
GREEN="\e[38;5;82m"
CYAN="\e[38;5;51m"
BLUE="\e[38;5;39m"
YELLOW="\e[38;5;220m"
GRAY="\e[38;5;245m"
RESET="\e[0m"

# ===== System Info =====
HOSTNAME=$(hostname)
OS=$(awk -F= '/PRETTY_NAME/ {print $2}' /etc/os-release | tr -d '"')
KERNEL=$(uname -r)
UPTIME=$(uptime -p | sed 's/up //')
LOAD=$(cut -d " " -f1 /proc/loadavg)

read MEM_TOTAL MEM_USED <<< $(free -m | awk '/Mem:/ {print $2, $3}')
MEM_PERC=$((MEM_USED * 100 / MEM_TOTAL))

read DISK_USED DISK_TOTAL DISK_PERC <<< $(df -h / | awk 'NR==2 {print $3, $2, $5}')

IP=$(hostname -I | awk '{print $1}')
USERS=$(who | wc -l)
PROCS=$(ps -e --no-headers | wc -l)

# ===== Clear spacing =====
echo ""

# ===== Logo =====
echo -e "${CYAN}"
cat << "LOGO"
 ██╗  ██╗██╗   ██╗███████╗███████╗██╗  ██╗███╗   ██╗ ██████╗ ██████╗ ███████╗███████╗
 ██║  ██║╚██╗ ██╔╝╚══███╔╝██╔════╝╚██╗██╔╝████╗  ██║██╔═══██╗██╔══██╗██╔════╝██╔════╝
 ███████║ ╚████╔╝   ███╔╝ █████╗   ╚███╔╝ ██╔██╗ ██║██║   ██║██║  ██║█████╗  ███████╗
 ██╔══██║  ╚██╔╝   ███╔╝  ██╔══╝   ██╔██╗ ██║╚██╗██║██║   ██║██║  ██║██╔══╝  ╚════██║
 ██║  ██║   ██║   ███████╗███████╗██╔╝ ██╗██║ ╚████║╚██████╔╝██████╔╝███████╗███████║
 ╚═╝  ╚═╝   ╚═╝   ╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚═════╝ ╚══════╝╚══════╝
LOGO
echo -e "${RESET}"

# ===== Welcome =====
echo -e "${CYAN}Welcome to HyzexNodes Datacenter 🚀${RESET}"
echo -e "${BLUE}Next-Gen Performance • Secure • Reliable Infrastructure${RESET}"
echo -e "${GRAY}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"

# ===== Stats =====
printf "${GREEN}%-16s${RESET} %s\n" "Hostname:" "$HOSTNAME"
printf "${GREEN}%-16s${RESET} %s\n" "Operating OS:" "$OS"
printf "${GREEN}%-16s${RESET} %s\n" "Kernel:" "$KERNEL"
printf "${GREEN}%-16s${RESET} %s\n" "Uptime:" "$UPTIME"
printf "${GREEN}%-16s${RESET} %s\n" "CPU Load:" "$LOAD"
printf "${GREEN}%-16s${RESET} %sMB / %sMB (${YELLOW}%s%%${RESET})\n" "Memory:" "$MEM_USED" "$MEM_TOTAL" "$MEM_PERC"
printf "${GREEN}%-16s${RESET} %s / %s (${YELLOW}%s${RESET})\n" "Disk:" "$DISK_USED" "$DISK_TOTAL" "$DISK_PERC"
printf "${GREEN}%-16s${RESET} %s\n" "Processes:" "$PROCS"
printf "${GREEN}%-16s${RESET} %s\n" "Users Online:" "$USERS"
printf "${GREEN}%-16s${RESET} %s\n" "IP Address:" "$IP"

echo -e "${GRAY}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"

# ===== Footer =====
echo -e "${CYAN}Support:${RESET}  info@hyzex.qzz.io"
echo -e "${CYAN}Discord:${RESET}  https://discord.gg/4A4W7wJx6C"
echo -e "${CYAN}Website:${RESET}  https://hyzex.qzzz.io"
echo -e "${GREEN}Performance Without Limits 💎${RESET}"
echo ""
EOF

chmod +x /etc/update-motd.d/00-hyzexnodes

echo "🎉 HyzexNodes Premium MOTD Installed Successfully!"
echo "➡ Logout & SSH again to view your new branding."
