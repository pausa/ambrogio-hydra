#!/usr/bin/env fish
mkdir -p /workspace/tmp/plugins
cd /workspace/tmp/plugins; or exit 1
wget 'https://plugins.jetbrains.com/plugin/download?rel=true&updateId=111075' -O ideavim.zip
wget 'https://plugins.jetbrains.com/plugin/download?rel=true&updateId=102528' -O gruvbox.zip
wget 'https://plugins.jetbrains.com/plugin/download?rel=true&updateId=108320' -O vuejs.zip
cd /workspace/idea/plugins; or exit 1
unzip '/workspace/tmp/plugins/*.zip'
