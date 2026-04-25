# Google Chrome / Chromium / Electron 優化
# 強制使用 Wayland 渲染
export CHROME_EXECUTABLE="google-chrome-stable"
export CHROME_FLAGS="--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations"

# 讓所有 Electron 應用程式預設使用 Wayland
export ELECTRON_OZONE_PLATFORM_HINT="auto"
