# 项目部署指南

恭喜！你的昆明老街文旅助手已经开发完成。以下是几种上线方式：

## 方式一：云服务器部署（推荐，自主可控）

如果你购买了阿里云、腾讯云等云服务器（VPS），请按照以下步骤操作。

### 1. 连接服务器
使用 SSH 连接到你的服务器（推荐使用 PowerShell 或终端）：
```bash
ssh root@你的服务器公网IP
# 输入密码后回车
```

### 2. 环境安装
在服务器上安装 Node.js 和 Git：
```bash
# Ubuntu/Debian 系统
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs git

# CentOS 系统
curl -fsSL https://rpm.nodesource.com/setup_18.x | sudo bash -
sudo yum install -y nodejs git
```

### 3. 获取代码
```bash
# 进入目录
cd /var/www
# 如果目录不存在则创建
mkdir -p /var/www
# 克隆代码（替换为你的 GitHub 地址）
git clone https://github.com/13987382399-prog/-H5-1.0.git kunming-guide
# 进入项目目录
cd kunming-guide
```

### 4. 安装依赖与配置
```bash
# 安装项目依赖
npm install

# 安装 PM2 进程管理器（保证后台运行）
npm install -g pm2

# 创建环境变量文件
echo "PORT=80" > .env
echo "DASHSCOPE_API_KEY=sk-ccd54aa1ffaa47c39cfc529f0228b378" >> .env
# 注意：上面的 API Key 建议替换为你实际的 Key
```

### 5. 启动服务
```bash
# 使用 PM2 启动服务
pm2 start server.js --name "kunming-guide"

# 设置开机自启
pm2 startup
pm2 save
```

### 6. 访问
现在，你应该可以通过浏览器访问 `http://你的服务器公网IP` 来查看网站了。

---

## 方式二：使用 Vercel 免费托管（简单快捷）

这是最现代、最简单的部署方式，只需几分钟即可获得一个永久的公网链接（https://...）。

### 步骤：
1.  **准备代码**：
    *   如果你有 GitHub 账号，建议将此文件夹（`d:\xiaoyou\s1`）推送到一个新的 GitHub 仓库。
    *   如果没有，也可以注册一个 Vercel 账号并安装 Vercel CLI 直接部署。

2.  **一键导入**：
    *   访问 [Vercel官网](https://vercel.com/) 并登录（推荐使用 GitHub 登录）。
    *   点击 **Add New...** -> **Project**。
    *   选择你刚才创建的 GitHub 仓库并点击 **Import**。

3.  **配置与部署**：
    *   **Framework Preset**：保持默认（Other）。
    *   **Root Directory**：保持默认（./）。
    *   **Environment Variables**（可选但推荐）：
        *   为了安全起见，建议在这里添加你的 API Key。
        *   Name: `DASHSCOPE_API_KEY`
        *   Value: `你的阿里云API Key` (sk-...)
    *   点击 **Deploy** 按钮。

4.  **完成！**
    *   等待约 30 秒，Vercel 会生成一个类似 `https://kunming-guide.vercel.app` 的链接。
    *   你可以将这个链接发给任何人，或者在手机浏览器中打开体验。

---

## 方式三：本地局域网访问（测试用）

如果你只想在家里或办公室的局域网内测试，可以使用此方法。

1.  **启动服务**：
    *   在项目文件夹打开终端。
    *   运行命令：`npm start`
    *   看到提示 `Server running at http://localhost:8084/` 即表示启动成功。

2.  **获取电脑 IP**：
    *   打开新的终端，输入 `ipconfig` (Windows) 或 `ifconfig` (Mac/Linux)。
    *   找到你的 IPv4 地址，例如 `192.168.1.5`。

3.  **手机访问**：
    *   确保手机和电脑连接在同一个 Wi-Fi 下。
    *   在手机浏览器输入：`http://192.168.1.5:8084`
    *   注意：由于浏览器安全限制，非 HTTPS 环境（如本地 IP）可能无法使用**定位**和**语音识别**功能。若要完整体验，请使用**方式一**或**方式二**。

---

## 项目结构说明

*   `index.html`: 前端主页面，包含地图、聊天界面和逻辑。
*   `api/chat.js`: 适配 Vercel 的后端接口，用于安全调用 AI 服务。
*   `server.js`: 本地开发用的服务器文件。
*   `package.json`: 项目配置文件。
