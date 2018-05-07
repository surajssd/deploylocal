#!/bin/bash

if [ -x "$(command -v kedge)" ]; then
    exit 0
fi

download_path=/tmp/kedge
echo "Kedge not found in PATH, installing it..."
curl -L https://dl.bintray.com/kedgeproject/kedge/latest/kedge-linux-amd64 -o $download_path
if [ $? -ne 0 ]; then
    echo "Kedge download failed"
    exit 1
fi

chmod +x $download_path
echo "Kedge downloaded in $download_path"

sudo mv $download_path /usr/local/bin/kedge
if [ $? -ne 0 ]; then
    echo "Kedge installation failed, but the binary is downloaded in $download_path"
    exit 1
fi

echo "Kedge installed in '/usr/local/bin/kedge'."
