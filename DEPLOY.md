# 项目部署指南

恭喜！你的昆明老街文旅助手已经开发完成。以下是两种最简单的上线方式：

## 方式一：使用 Vercel 免费托管（推荐，公网可访问）

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

## 方式二：本地局域网访问（测试用）

如果你只想在家里或办公室的局域网内测试，可以使用此方法。

1.  **启动服务**：
    *   在项目文件夹打开终端。
    *   运行命令：`node server.js`
    *   看到提示 `Server running at http://localhost:8084/` 即表示启动成功。

2.  **获取电脑 IP**：
    *   打开新的终端，输入 `ipconfig` (Windows) 或 `ifconfig` (Mac/Linux)。
    *   找到你的 IPv4 地址，例如 `192.168.1.5`。

3.  **手机访问**：
    *   确保手机和电脑连接在同一个 Wi-Fi 下。
    *   在手机浏览器输入：`http://192.168.1.5:8084`
    *   注意：由于浏览器安全限制，非 HTTPS 环境（如本地 IP）可能无法使用**定位**和**语音识别**功能。若要完整体验，请使用**方式一**。

---

## 项目结构说明

*   `index.html`: 前端主页面，包含地图、聊天界面和逻辑。
*   `api/chat.js`: 适配 Vercel 的后端接口，用于安全调用 AI 服务。
*   `server.js`: 本地开发用的服务器文件。
*   `package.json`: 项目配置文件。
