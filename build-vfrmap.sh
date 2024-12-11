#!/bin/bash
set -e

# Check if go-bindata is installed and generate assets
[ -x "$(command -v go-bindata)" ] && go generate github.com/watsonpaul80/MSFS2024-VFR-MAP/simconnect
[ -x "$(command -v go-bindata)" ] && go generate github.com/watsonpaul80/MSFS2024-VFR-MAP/vfrmap
[ -x "$(command -v go-bindata)" ] && go generate github.com/watsonpaul80/MSFS2024-VFR-MAP/vfrmap/html/leafletjs

# Get build time and version
build_time=$(date -u +'%Y-%m-%d_%T')
set +e
build_version=$(git describe --tags || echo "dev")
set -e

# Build the binary
CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build -o build/vfrmap.exe -ldflags "-s -w -X main.buildVersion=$build_version -X main.buildTime=$build_time" -v github.com/watsonpaul80/MSFS2024-VFR-MAP/vfrmap
