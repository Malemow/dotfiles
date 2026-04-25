#!/bin/bash

# 設定設定檔路徑
CONF_FILE="$HOME/.config/hypr/conf.d/keybindings.conf"
THEME_FILE="$HOME/.config/rofi/keybinds.rasi"

# 提取註解與快捷鍵並格式化
# 邏輯優化：同時支援「同行註解」與「上方標題註解」
list=$(awk '
    # 處理標題註解 (行首為 #)
    /^#[^#]/ { 
        last_header=$0; 
        gsub(/^#\s*/, "", last_header); 
    }
    
    # 處理 bind 行
    /^bind[eml]*\s*=/ {
        # 1. 提取快捷鍵部分
        full_line = $0;
        
        # 2. 檢查是否有同行註解 (格式: bind = ... # 註解)
        comment = "";
        if (full_line ~ /#/) {
            comment = full_line;
            gsub(/.*#\s*/, "", comment);
        } else {
            comment = last_header; # 如果同行沒註解，就用上方的標題
        }

        # 3. 提取按鍵組合
        split(full_line, parts, ",");
        mods = parts[1];
        gsub(/^bind[eml]*\s*=\s*/, "", mods);
        gsub(/\$mainMod/, "Super", mods);
        
        key = parts[2];
        gsub(/^\s*/, "", key);
        gsub(/\s*#.*/, "", key); # 清除 key 後面的註解殘留
        
        bind_str = mods " + " key;
        
        # 格式化輸出
        if (comment != "") {
            printf "%-22s  󰁔  %s\n", bind_str, comment;
        }
    }
' "$CONF_FILE" | sort -u)

# 使用專屬主題顯示
echo "$list" | rofi -dmenu -i -p "󰌌 " -theme "$THEME_FILE"
