# 服务器代码同步流程

当你在本地完成代码修改并推送到 GitHub 后，服务器不会自动更新。你需要登录服务器并拉取最新代码。

## 极速更新命令（推荐）

在你的本地电脑上（不是服务器上），直接复制以下命令并运行（假设你已经配置了 SSH 密钥）：

### 强制更新（覆盖服务器修改）
```bash
ssh root@8.137.59.55 "cd /var/www/kunming-guide && git fetch --all && git reset --hard origin/master && npm install && pm2 restart kunming-guide"
```

### 普通更新（保留服务器修改）
```bash
ssh root@8.137.59.55 "cd /var/www/kunming-guide && git pull && npm install && pm2 restart kunming-guide"
```

## 核弹级重置（Nuclear Reset）

如果遇到**代码死活不更新**、**PM2 报错**或者**服务器环境异常**的情况，请直接运行以下脚本进行全量重置：

**Windows 用户:**
双击运行 `nuclear_reset.bat`

**Mac/Linux 用户:**
```bash
ssh root@8.137.59.55 "rm -rf /var/www/kunming-guide && git clone https://github.com/13987382399-prog/-H5-1.0.git /var/www/kunming-guide && cd /var/www/kunming-guide && npm install && pm2 delete all && pm2 start server.js --name kunming-guide && pm2 save"
```

此操作会：
1. **删除**服务器上的现有项目文件夹。
2. **重新克隆**最新的代码仓库。
3. **重新安装**所有依赖。
4. **重启** PM2 服务。

注意：如果你在服务器上手动修改了 `.env` 文件，脚本会尝试备份并恢复它，但建议确认无误后再执行。
