# Lifan's Dotfiles

這是我個人在 Arch Linux (Hyprland) 環境下的設定檔備份，包含自動安裝腳本與主題。

## 🖥️ 環境資訊
- **OS**: Arch Linux
- **WM**: Hyprland
- **Shell**: Zsh (Oh My Zsh + Powerlevel10k)
- **Terminal**: Kitty
- **Editor**: Neovim
- **AUR Helper**: Paru

## 📦 包含內容
- **設定檔 (Stow)**: Hyprland, Waybar, Kitty, Neovim, Rofi, Dunst, Fcitx5 (含小麥注音詞庫) 等。
- **套件清單**: 
  - `pacman_packages.txt` (官方套件)
  - `aur_packages.txt` (AUR 套件)
  - `flatpak_packages.txt` (Flatpak 軟體)
- **佈景主題**:
  - Grub: KawaiiGRUB
  - SDDM: Sugar-Candy
- **自動化安裝**: `install.sh` 腳本。

## 🚀 如何使用 (新機器安裝)

1. **複製本倉庫**:
   ```bash
   git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

2. **執行安裝腳本**:
   ```bash
   chmod +x install.sh
   ./install.sh
   ```

## 🛠️ 管理方式
本倉庫使用 [GNU Stow](https://www.gnu.org/software/stow/) 進行符號連結管理。
要套用特定設定，可手動執行：
```bash
stow [套件名稱]
```

## ⚠️ 注意事項
- 安裝腳本會修改 `/etc/default/grub` 並重新產生 Grub 設定。
- 請確保在執行前已備份重要資料。
