#!/bin/bash
# FORJEX 网站部署和 PR 更新脚本
# 使用方法：
# 1. 创建 GitHub Personal Access Token (PAT):
#    - 访问: https://github.com/settings/tokens
#    - 点击 "Generate new token (classic)"
#    - 勾选: repo (完整仓库权限)
#    - 生成并复制 token
# 2. 执行: GITHUB_TOKEN=ghp_xxx ./deploy.sh

set -e

# 配置
GITHUB_USER="hill121"
REPO_NAME="forjex-site"
TOKEN="${GITHUB_TOKEN}"

if [ -z "$TOKEN" ]; then
    echo "错误: 需要设置 GITHUB_TOKEN 环境变量"
    echo "用法: GITHUB_TOKEN=your_token_here $0"
    exit 1
fi

echo "=== 步骤 1: 创建 GitHub 仓库 ==="
curl -s -X POST \
  -H "Authorization: token $TOKEN" \
  -H "Accept: application/vnd.github.v3+json" \
  https://api.github.com/user/repos \
  -d "{\"name\":\"$REPO_NAME\",\"description\":\"工业软件开发者作品集 - FORJEX\",\"homepage\":\"https://forjex.netlify.app\",\"public\":true}" \
  | grep -q '"full_name"' && echo "✓ 仓库创建成功" || echo "仓库可能已存在，继续..."

echo ""
echo "=== 步骤 2: 推送代码到 GitHub ==="
cd /mnt/f/Hermes/forjex-site
git remote remove origin 2>/dev/null || true
git remote add origin https://$GITHUB_USER:$TOKEN@github.com/$GITHUB_USER/$REPO_NAME.git
git branch -M main
git push -u origin main

echo ""
echo "✓ 代码已推送到: https://github.com/$GITHUB_USER/$REPO_NAME"

echo ""
echo "=== 步骤 3: 部署到 Netlify ==="
echo "请手动操作:"
echo "1. 访问 https://app.netlify.com/start"
echo "2. 选择 'Import from Git'"
echo "3. 授权 GitHub，选择 $REPO_NAME 仓库"
echo "4. 部署设置: Publish directory = '.'"
echo "5. 部署完成后，站点会自动更新到 forjex.netlify.app"

echo ""
echo "=== 步骤 4: 更新 is-a.dev PR ==="
echo "请访问: https://github.com/is-a-dev/register/pulls?q=is%3Apr+author%3A$GITHUB_USER"
echo "找到你的 forjex PR，添加以下评论:"
echo ""
cat << 'EOF'
## 网站已更新为软件开发者作品集

本站点已重新设计为个人技术作品集，符合 software dev portfolio 要求：

### ✅ 软件开发项目展示
- 多Agent内容生产系统（Python, AI Agent）
- 微信公众号自动化系统（Python, FastAPI）
- PLC教学资料管理系统（静态网站，教育项目）
- 工业数据分析工具（Python, 工业物联网）

### ✅ 技术栈说明
- 编程语言: Python, JavaScript, SQL, PLC梯形图
- 框架工具: FastAPI, Flask, Git, Docker
- 工业软件: TIA Portal, SCADA, Modbus, OPC UA

### ✅ 开源贡献
所有项目源码已开源在 GitHub: https://github.com/hill121

### ✅ 作品集定位
本站展示工业软件开发相关的技术项目，属于 software dev related portfolio。

Updated: 2026-04-30
EOF

echo ""
echo "=== 完成 ==="
echo "下一步: 等待 is-a.dev 维护者重新审核"
