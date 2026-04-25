#!/usr/bin/env bash

# 定義顏色
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}開始執行 dotfiles 自動化安裝腳本...${NC}"

# 1. 確認並安裝 AUR Helper (paru)
if ! command -v paru &> /dev/null; then
    echo -e "${GREEN}未偵測到 paru，正在從 AUR 進行 Bootstrap 安裝...${NC}"
    sudo pacman -S --needed base-devel git
    TEMP_DIR=$(mktemp -d)
    git clone https://aur.archlinux.org/paru.git "$TEMP_DIR/paru"
    cd "$TEMP_DIR/paru" && makepkg -si --noconfirm
    cd - &> /dev/null
    rm -rf "$TEMP_DIR"
fi

# 2. 安裝官方套件
echo -e "${GREEN}正在安裝官方 Pacman 套件...${NC}"
if [ -f pacman_packages.txt ]; then
    sudo pacman -S --needed - < pacman_packages.txt
fi

# 3. 安裝 AUR 套件
echo -e "${GREEN}正在安裝 AUR 套件 (使用 paru)...${NC}"
if [ -f aur_packages.txt ]; then
    grep -v '^paru$' aur_packages.txt | paru -S --needed -
fi

# 4. 安裝 Flatpak 軟體
if [ -f flatpak_packages.txt ]; then
    echo -e "${GREEN}正在安裝 Flatpak 軟體...${NC}"
    if ! command -v flatpak &> /dev/null; then
        sudo pacman -S --needed flatpak
    fi
    while read -r app; do
        [ -n "$app" ] && flatpak install -y flathub "$app"
    done < flatpak_packages.txt
fi

# 5. 使用 GNU Stow 建立連結
echo -e "${GREEN}正在建立設定檔連結 (GNU Stow)...${NC}"
DOTFILES_DIR=$(cd "$(dirname "$0")" && pwd)
cd "$DOTFILES_DIR"
EXCLUDE_DIRS=("setup" "themes" ".git")

for dir in */; do
    dir=${dir%/}
    is_excluded=false
    for ex in "${EXCLUDE_DIRS[@]}"; do
        if [[ "$dir" == "$ex" ]]; then
            is_excluded=true
            break
        fi
    done
    
    if [ "$is_excluded" = false ]; then
        echo "正在處理: $dir"
        stow --adopt "$dir"
    fi
done

# 6. 安裝 Grub 主題與設定
echo -e "${GREEN}正在安裝 Grub 主題與設定...${NC}"
if [ -d "setup/grub/KawaiiGRUB-master" ]; then
    cd setup/grub/KawaiiGRUB-master
    chmod +x install.sh
    sudo ./install.sh
    cd "$DOTFILES_DIR"
fi

if [ -f "setup/grub/default_grub" ]; then
    echo "套用 Grub 設定檔 (/etc/default/grub)..."
    sudo cp setup/grub/default_grub /etc/default/grub
    echo "正在重新產生 Grub 設定..."
    sudo grub-mkconfig -o /boot/grub/grub.cfg
fi

# 7. 安裝 SDDM 主題
echo -e "${GREEN}正在安裝 SDDM 主題...${NC}"
if [ -d "setup/sddm/sugar-candy" ]; then
    sudo mkdir -p /usr/share/sddm/themes/
    sudo cp -r setup/sddm/sugar-candy /usr/share/sddm/themes/
    sudo mkdir -p /etc/sddm.conf.d/
    echo -e "[Theme]\nCurrent=sugar-candy" | sudo tee /etc/sddm.conf.d/theme.conf
fi

echo -e "${BLUE}安裝完成！請重新開機以確保所有變更生效。${NC}"
