# 服务器代码同步流程

当你在本地完成代码修改并推送到 GitHub 后，请按照以下步骤更新服务器代码。

## 方法一：使用自动部署脚本（推荐）

如果你的服务器上已经保留了 `setup.sh`，直接再次运行它即可自动更新。

1.  **登录服务器**
    ```bash
    ssh root@8.137.59.55
    ```

2.  **运行脚本**
    ```bash
    # 如果脚本就在当前目录下
    ./setup.sh

    # 或者重新下载并运行（确保是最新脚本）
    curl -O https://raw.githubusercontent.com/13987382399-prog/-H5-1.0/master/setup.sh && chmod +x setup.sh && ./setup.sh
    ```

## 方法二：手动更新（更可控）

如果你只想更新代码而不想重新配置环境，请按以下步骤操作：

1.  **登录服务器**
    ```bash
    ssh root@8.137.59.55
    ```

2.  **进入项目目录**
    ```bash
    cd /var/www/kunming-guide
    ```

3.  **拉取最新代码**
    *注意：如果遇到 `Permission denied` 错误，请在命令前加 `sudo`*
    ```bash
    git pull origin master
    ```

4.  **更新依赖（如果有新依赖）**
    ```bash
    npm install
    ```

5.  **重启服务**
    ```bash
    pm2 restart kunming-guide
    ```

## 常见问题处理

### 1. 权限错误 (Permission denied)
如果在 `git pull` 时遇到权限错误，尝试修复目录权限：
```bash
sudo chown -R root:root /var/www/kunming-guide
```
或者使用 sudo 运行 git：
```bash
sudo git pull
```

### 2. 本地修改冲突
如果服务器上也有修改导致冲突，可以强制重置（慎用，会丢失服务器上的修改）：
```bash
git fetch --all
git reset --hard origin/master
```
