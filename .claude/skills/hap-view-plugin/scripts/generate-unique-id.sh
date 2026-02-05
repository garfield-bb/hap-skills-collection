#!/bin/bash

# 生成唯一的项目ID后缀
# 用法: ./generate-unique-id.sh [前缀]

PREFIX="${1:-693d2fed8474b99be3d3c12e}"
TIMESTAMP=$(date +%s)
RANDOM_SUFFIX=$(openssl rand -hex 4 2>/dev/null || echo $RANDOM)

# 组合生成唯一ID
UNIQUE_ID="${PREFIX}-${TIMESTAMP}-${RANDOM_SUFFIX}"

echo "生成的唯一插件ID: $UNIQUE_ID"
echo "建议的项目目录名: mdye_view_${TIMESTAMP}_${RANDOM_SUFFIX}"