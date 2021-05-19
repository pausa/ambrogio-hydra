#!/usr/bin/env fish
mkdir -p /workspace/tmp/plugins
cd /workspace/tmp/plugins; or exit 1
wget 'https://plugins.jetbrains.com/plugin/download?rel=true&updateId=111075' -O ideavim.zip
wget 'https://plugins.jetbrains.com/plugin/download?rel=true&updateId=102528' -O gruvbox.zip
wget 'https://plugins.jetbrains.com/plugin/download?rel=true&updateId=117718' -O vuejs.zip
wget 'https://plugins.jetbrains.com/plugin/download?rel=true&updateId=118707' -O python.zip
cd /workspace/idea/plugins; or exit 1
unzip '/workspace/tmp/plugins/*.zip'
