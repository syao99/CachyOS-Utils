#!/bin/bash

# 1. Update and Install Bare Essentials
setup_packages() {
    echo "--- Installing essentials ---"
    sudo pacman -Syu --noconfirm
    sudo pacman -S --needed --noconfirm git openssh ufw nvtop moonlight-qt sunshine chromium
}

# 2. Configure SSH and Firewall
setup_network() {
    echo "--- Configuring Network/SSH ---"
    sudo systemctl enable --now sshd
    sudo ufw allow ssh
    sudo ufw --force enable
}

# 3. Create the 'gui' command script
setup_gui_command() {
    echo "--- Creating ~/gui.sh ---"
    
    sudo bash -c 'cat <<EOF > ~/gui.sh
dbus-run-session startplasma-wayland
kquitapp6 plasmashell --authorize 2>/dev/null
echo "Plasma session ended."
EOF'

    sudo chmod +x ~/gui.sh
}

# 4. Set boot target to TTY
setup_boot_target() {
    echo "--- Setting boot to TTY ---"
    sudo systemctl set-default multi-user.target
}

# Run the functions
setup_packages
setup_network
setup_gui_command
setup_boot_target

echo "------------------------------------------------"
echo "Setup complete! Launch the DE via `~/gui.sh`."
echo "Rebooting in 5 seconds... (Ctrl+C to cancel)"
sleep 5
sudo reboot
