#!/bin/bash

# 检查是否以 root 权限运行
if [ "$EUID" -ne 0 ]; then
  echo "请使用 root 权限运行此脚本 (例如: sudo ./setup.sh)"
  exit 1
fi

echo "=== 开始自动部署昆明老街文旅助手 ==="

# 1. 检测并安装 Node.js 和 Git
if ! command -v node &> /dev/null; then
    echo "正在安装 Node.js 和 Git..."
    if [ -f /etc/debian_version ]; then
        curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
        sudo apt-get install -y nodejs git
    elif [ -f /etc/redhat-release ]; then
        curl -fsSL https://rpm.nodesource.com/setup_18.x | sudo bash -
        sudo yum install -y nodejs git
    else
        echo "无法自动检测操作系统，请手动安装 Node.js 和 Git。"
        exit 1
    fi
else
    echo "Node.js 已安装，跳过安装步骤。"
fi

# 2. 准备项目目录
TARGET_DIR="/var/www/kunming-guide"
mkdir -p /var/www

if [ -d "$TARGET_DIR" ]; then
    echo "更新现有代码..."
    cd "$TARGET_DIR"
    git pull
else
    echo "克隆代码仓库..."
    cd /var/www
    git clone https://github.com/13987382399-prog/-H5-1.0.git kunming-guide
    cd "$TARGET_DIR"
fi

# 3. 安装依赖
echo "正在安装项目依赖..."
npm install
if ! command -v pm2 &> /dev/null; then
    echo "安装 PM2 进程管理器..."
    npm install -g pm2
fi

# 4. 配置环境变量
echo "配置环境变量..."
# 写入 .env 文件
cat > .env <<EOF
PORT=80
DASHSCOPE_API_KEY=sk-ccd54aa1ffaa47c39cfc529f0228b378
EOF

# 5. 启动服务
echo "启动服务..."
pm2 stop kunming-guide 2>/dev/null || true
pm2 start server.js --name "kunming-guide"
pm2 save
pm2 startup

echo "=== 部署完成！ ==="
echo "请访问: http://8.137.59.55"
