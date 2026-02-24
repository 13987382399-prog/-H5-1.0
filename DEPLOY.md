# 项目部署指南

恭喜！你的昆明老街文旅助手已经开发完成。以下是针对你的云服务器（8.137.59.55）的专属部署方案。

## 极速部署（推荐）

我已经为你编写了一个自动化脚本，只需两步即可完成所有操作。

### 1. 连接服务器
打开 PowerShell 或终端，输入以下命令连接服务器：
```bash
ssh root@8.137.59.55
# 输入密码后回车
```

### 2. 执行一键安装脚本
复制以下命令并在服务器终端执行：

```bash
# 下载并执行自动化部署脚本
curl -O https://raw.githubusercontent.com/13987382399-prog/-H5-1.0/master/setup.sh && chmod +x setup.sh && ./setup.sh
```

**脚本会自动完成以下工作：**
*   安装 Node.js, Git, PM2
*   拉取最新代码
*   安装项目依赖
*   配置环境变量（包含你的 API Key）
*   启动服务并设置开机自启

### 3. 访问网站
部署完成后，直接访问：
[http://8.137.59.55](http://8.137.59.55)

---

## 手动部署（备用方案）

如果脚本执行失败，你可以尝试手动操作：

### 1. 环境安装
```bash
# CentOS
curl -fsSL https://rpm.nodesource.com/setup_18.x | sudo bash -
sudo yum install -y nodejs git

# Ubuntu
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs git
```

### 2. 获取代码与安装
```bash
mkdir -p /var/www
cd /var/www
git clone https://github.com/13987382399-prog/-H5-1.0.git kunming-guide
cd kunming-guide
npm install
npm install -g pm2
```

### 3. 启动服务
```bash
echo "PORT=80" > .env
echo "DASHSCOPE_API_KEY=sk-ccd54aa1ffaa47c39cfc529f0228b378" >> .env
pm2 start server.js --name "kunming-guide"
pm2 save
pm2 startup
```

---

## 其他方式

### Vercel 托管
如果你不想维护服务器，也可以使用 Vercel：
1.  访问 [Vercel](https://vercel.com/) 并导入 GitHub 仓库。
2.  添加环境变量 `DASHSCOPE_API_KEY`。
3.  点击 Deploy。

### 本地测试
在本项目目录下运行 `npm start`，访问 `http://localhost:8084`。
