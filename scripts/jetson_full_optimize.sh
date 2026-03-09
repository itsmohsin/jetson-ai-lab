#!/usr/bin/env bash

# Jetson Nano Optimization Script
# Author: Mohsin
# Repo: https://github.com/itsmohsin/jetson-ai-lab
# Description: Optimize Jetson Nano 2GB for headless Edge AI workloads

set -e

echo "======================================"
echo " Jetson Nano 2GB Optimization Script "
echo "======================================"

# Check if running on Jetson
if ! grep -q "tegra" /proc/cpuinfo; then
  echo "⚠️  Warning: This script is intended for NVIDIA Jetson devices."
fi

echo ""
echo "Removing unnecessary GUI utilities..."

sudo apt purge -y \
  gnome-software \
  gnome-software-common \
  gnome-system-monitor \
  gnome-system-tools \
  gnome-disk-utility \
  baobab \
  gucharmap \
  clipit \
  galculator \
  leafpad || true

echo ""
echo "Removing crash reporting tools..."

sudo apt purge -y \
  apport \
  apport-gtk \
  apport-symptoms \
  whoopsie || true

echo ""
echo "Removing large language font packs..."

sudo apt purge -y \
  fonts-kacst* \
  fonts-khmeros-core \
  fonts-lao \
  fonts-lklug-sinhala \
  fonts-noto-cjk \
  fonts-sil-padauk \
  fonts-tibetan-machine \
  fonts-freefont-ttf || true

echo ""
echo "Disabling unnecessary background services..."

SERVICES=(
  bluetooth
  cups
  cups-browsed
  whoopsie
  avahi-daemon
  ModemManager
  speech-dispatcher
)

for service in "${SERVICES[@]}"; do
  sudo systemctl disable "$service" 2>/dev/null || true
  sudo systemctl stop "$service" 2>/dev/null || true
done

echo ""
echo "Optimizing swap behavior..."

if ! grep -q "vm.swappiness=10" /etc/sysctl.conf; then
  echo "vm.swappiness=10" | sudo tee -a /etc/sysctl.conf
fi

sudo sysctl -p

echo ""
echo "Switching system to headless boot..."

sudo systemctl set-default multi-user.target

echo ""
echo "Setting Jetson maximum performance..."

if command -v nvpmodel >/dev/null; then
  sudo nvpmodel -m 0
fi

if command -v jetson_clocks >/dev/null; then
  sudo jetson_clocks
fi

echo ""
echo "Cleaning unused packages..."

sudo apt autoremove --purge -y
sudo apt clean

echo ""
echo "======================================"
echo " Optimization Complete!"
echo " Reboot recommended:"
echo " sudo reboot"
echo "======================================"
