#!/usr/bin/env fish
mkdir -p /workspace/tmp/plugins
cd /workspace/tmp/plugins; or exit 1
wget 'https://plugins.jetbrains.com/plugin/download?rel=true&updateId=102528' -O gruvbox.zip --progress=dot:giga
cd /workspace/android/plugins; or exit 1
unzip '/workspace/tmp/plugins/*.zip'
